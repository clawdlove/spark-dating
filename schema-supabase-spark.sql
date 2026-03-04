-- Database Schema for Spark Dating App
-- Supabase PostgreSQL

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- USERS
-- ============================================
CREATE TABLE profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    username TEXT UNIQUE NOT NULL,
    full_name TEXT,
    bio TEXT,
    birth_date DATE,
    gender TEXT CHECK (gender IN ('male', 'female', 'other')),
    interested_in TEXT CHECK (interested_in IN ('male', 'female', 'both')),
    location TEXT, -- City, displayed not precise coordinates
    latitude FLOAT,
    longitude FLOAT,
    
    -- Wealth/Ambition Info
    income_range TEXT, -- e.g., '$100k-$150k', '$250k+'
    income_verified BOOLEAN DEFAULT FALSE,
    occupation TEXT,
    company TEXT,
    education TEXT,
    lifestyle_tags TEXT[], -- Array: 'Luxury travel', 'Fine dining', 'Ambition-driven'
    
    -- Photos
    avatar_url TEXT,
    photo_urls TEXT[], -- Up to 6 photos
    
    -- Verification
    phone_verified BOOLEAN DEFAULT FALSE,
    linkedin_verified BOOLEAN DEFAULT FALSE,
    identity_verified BOOLEAN DEFAULT FALSE,
    
    -- Preferences
    min_age_pref INTEGER DEFAULT 18,
    max_age_pref INTEGER DEFAULT 50,
    distance_pref INTEGER DEFAULT 50, -- miles
    income_pref_min TEXT,
    income_pref_max TEXT,
    
    -- Stats
    likes_received INTEGER DEFAULT 0,
    matches_count INTEGER DEFAULT 0,
    profile_views INTEGER DEFAULT 0,
    
    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    last_active TIMESTAMPTZ DEFAULT NOW(),
    
    -- Settings
    is_premium BOOLEAN DEFAULT FALSE,
    is_incognito BOOLEAN DEFAULT FALSE,
    show_in_online BOOLEAN DEFAULT TRUE
);

-- Index for discovery queries (simple separate indexes for now)
CREATE INDEX idx_profiles_lat ON profiles(latitude);
CREATE INDEX idx_profiles_lon ON profiles(longitude);
CREATE INDEX idx_profiles_active ON profiles(last_active DESC);
CREATE INDEX idx_profiles_gender ON profiles(gender);

-- ============================================
-- LIKES / SWIPES
-- ============================================
CREATE TABLE likes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    liker_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    liked_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    status TEXT CHECK (status IN ('liked', 'passed', 'superliked')) DEFAULT 'liked',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(liker_id, liked_id)
);

CREATE INDEX idx_likes_liker ON likes(liker_id);
CREATE INDEX idx_likes_liked ON likes(liked_id);

-- ============================================
-- MATCHES
-- ============================================
CREATE TABLE matches (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_a UUID REFERENCES profiles(id) ON DELETE CASCADE,
    user_b UUID REFERENCES profiles(id) ON DELETE CASCADE,
    match_score INTEGER, -- Compatibility score
    created_at TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(user_a, user_b)
);

CREATE INDEX idx_matches_users ON matches(user_a, user_b);

-- ============================================
-- MESSAGES
-- ============================================
CREATE TABLE messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    match_id UUID REFERENCES matches(id) ON DELETE CASCADE,
    sender_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    content TEXT,
    message_type TEXT CHECK (message_type IN ('text', 'image', 'voice')) DEFAULT 'text',
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_messages_match ON messages(match_id) WHERE is_read = FALSE;
CREATE INDEX idx_messages_sender ON messages(sender_id);

-- ============================================
-- REPORTS
-- ============================================
CREATE TABLE reports (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    reporter_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    reported_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    reason TEXT CHECK (reason IN ('fake', 'harassment', 'scam', 'other')),
    details TEXT,
    status TEXT CHECK (status IN ('pending', 'reviewed', 'actioned')) DEFAULT 'pending',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- BLOCKS
-- ============================================
CREATE TABLE blocks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    blocker_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    blocked_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(blocker_id, blocked_id)
);

-- ============================================
-- PREMIUM SUBSCRIPTIONS (Stripe)
-- ============================================
CREATE TABLE subscriptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    stripe_subscription_id TEXT UNIQUE,
    stripe_customer_id TEXT,
    plan TEXT CHECK (plan IN ('monthly', 'yearly')),
    status TEXT CHECK (status IN ('active', 'canceled', 'past_due')),
    current_period_start TIMESTAMPTZ,
    current_period_end TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- USER ACTIVITY (for analytics)
-- ============================================
CREATE TABLE user_activity (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    event_type TEXT, -- 'swipe', 'match', 'message', 'login'
    metadata JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_activity_user ON user_activity(user_id, created_at DESC);

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================

-- Profiles: readable by authenticated, editable by owner
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Profiles are viewable by everyone" 
    ON profiles FOR SELECT 
    USING (auth.role() = 'authenticated');

CREATE POLICY "Users can update own profile" 
    ON profiles FOR UPDATE 
    USING (auth.uid() = id);

-- Likes: only visible to the two users involved
CREATE POLICY "Likes visible to matched users"
    ON likes FOR SELECT
    USING (
        liker_id = auth.uid() 
        OR liked_id = auth.uid()
    );

CREATE POLICY "Users can create likes"
    ON likes FOR INSERT
    WITH CHECK (liker_id = auth.uid());

-- Matches: visible to both users
CREATE POLICY "Matches visible to participants"
    ON matches FOR SELECT
    USING (
        user_a = auth.uid() 
        OR user_b = auth.uid()
    );

-- Messages: visible to match participants
CREATE POLICY "Messages visible to match participants"
    ON messages FOR SELECT
    USING (
        sender_id = auth.uid() 
        OR EXISTS (
            SELECT 1 FROM matches m 
            WHERE m.id = messages.match_id 
            AND (m.user_a = auth.uid() OR m.user_b = auth.uid())
        )
    );

CREATE POLICY "Users can send messages"
    ON messages FOR INSERT
    WITH CHECK (sender_id = auth.uid());

-- ============================================
-- FUNCTIONS
-- ============================================

-- Get discovery queue (potential matches)
CREATE OR REPLACE FUNCTION get_discovery_queue(
    target_user_id UUID,
    limit_count INTEGER DEFAULT 20
)
RETURNS SETOF profiles AS $$
BEGIN
    RETURN QUERY
    SELECT p.*
    FROM profiles p
    WHERE p.id != target_user_id
    AND p.id NOT IN (
        SELECT liked_id FROM likes WHERE liker_id = target_user_id
    )
    AND p.id NOT IN (
        SELECT blocked_id FROM blocks WHERE blocker_id = target_user_id
    )
    AND p.gender IN (
        SELECT interested_in FROM profiles WHERE id = target_user_id
    )
    AND p.id IN (
        SELECT liker_id FROM likes WHERE liked_id = target_user_id AND status = 'liked'
    )
    ORDER BY p.last_active DESC
    LIMIT limit_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create match when two users like each other
CREATE OR REPLACE FUNCTION try_create_match(
    liker_uuid UUID,
    liked_uuid UUID
)
RETURNS UUID AS $$
DECLARE
    new_match_id UUID;
BEGIN
    -- Check if the other person already liked us
    IF EXISTS (
        SELECT 1 FROM likes 
        WHERE liker_id = liked_uuid 
        AND liked_id = liker_uuid 
        AND status = 'liked'
    ) THEN
        -- Create match
        INSERT INTO matches (user_a, user_b)
        VALUES (liker_uuid, liked_uuid)
        ON CONFLICT (user_a, user_b) DO NOTHING
        RETURNING id INTO new_match_id;
        
        -- Update match counts
        UPDATE profiles SET matches_count = matches_count + 1 
        WHERE id IN (liker_uuid, liked_uuid);
        
        RETURN new_match_id;
    END IF;
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
