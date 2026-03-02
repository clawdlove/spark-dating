# PRD: Spark — Android Dating App

## 1. Overview

**App Name:** Spark  
**Platform:** Android (Native) → iOS via Kotlin Multiplatform  
**Target Audience:** Wealth-conscious adults 22–45 seeking romantic connections  
**Core Value Prop:** A dating app that connects ambitious, successful individuals with like-minded partners — prioritizing compatibility, shared values, and meaningful connections over superficial swiping.

---

## 2. Problem Statement

- Existing wealth-conscious dating apps have trust/safety issues (fake profiles, "salt daddies")
- Mainstream apps don't filter by income/ambition — wasted time on mismatched values
- Users seeking financial stability or ambitious partners have no dedicated platform that works
- Verification is weak — hard to confirm income claims

---

## 3. Goals

1. **Verified Profiles** — Income/employment verification to build trust
2. **Values-Based Matching** — Match on ambition, lifestyle goals, not just photos
3. **Safety & Trust** — Robust verification, moderation, and user control
4. **Quality over Quantity** — Incentivize meaningful conversations

---

## 4. Target Audience

| Segment | Demographics | Pain Points |
|---------|--------------|-------------|
| Ambitious Women | 22–35, professionals | Want partners with similar drive/financial stability |
| Successful Men | 28–45, entrepreneurs/execs | Tired of superficial apps, want someone who values ambition |
| Late Career Professionals | 35–50 | Re-entering dating, want quality over quantity |

**Note:** This is a niche dating app. App store compliance: Avoid any language implying "compensated dating" or sugar arrangements. Frame as "quality-focused matchmaking for ambitious singles."

---

## 5. Core Features

### 5.1 Onboarding & Profile

- **Multi-step profile creation** — Photos, bio, prompts, interests (tags), lifestyle preferences
- **Income/Employment verification** — Optional but badge shown:
  - Self-reported income range (displayed as "Ambition Verified")
  - Optional: LinkedIn verification, or upload proof (pay stub, tax return — reviewed manually, never exposed)
- **"Lifestyle Tags"** — What you're seeking: "Luxury travel", "Fine dining", "Ambition-driven", "Family-oriented"
- **"My Standards" section** — Dealbreakers: income range, education, lifestyle preferences

### 5.2 Discovery

- **Card-style swiping** — Photos + bio + income/ambition badge + lifestyle tags + compatibility %
- **"Ambition-First" Algorithm** — Match based on: income alignment, lifestyle goals, shared interests, values
- **Income Range Filter** — Users can filter by income brackets (e.g., $100k+, $250k+, $500k+)
- **"Dealbreakers"** — Hard filters (e.g., "must be ambitious", "non-smoker", "wants kids")
- **"Verified" Badge** — Highlight users who verified income/employment (increases match likelihood)

### 5.3 Matching

- **Two-step match** — Both must "like" AND respond to a prompt/question to match
  - After swiping right, user answers a quick prompt question from their match's profile
  - Match only happens if they also like you AND answer your question (or accept)
- **Match queue** — See who liked you before deciding (freemium feature)

### 5.4 Messaging

- **Conversation starters** — AI suggests topics based on shared interests
- **"Voice Note" quick reply** — Send voice clips instead of text (less pressure)
- **"Mood" status** — Set availability: "Open to chat", "Busy", "Late night"
- **Read receipts** — Optional, off by default
- **Unsend / Edit** — Within 5 minutes

### 5.5 Safety

- **Report flow** — Easy reporting with categories (harassment, fake, scam)
- **Block list** — Full control, blocked users can't see your profile
- **AI profile review** — Flag suspicious photos/bios for human moderation
- **Incognito mode** — Hide from specific contacts (optional import from contacts)
- **Safe mode** — Auto-blur sensitive images, toggle in settings

### 5.6 Premium Features (Freemium)

- **Unlimited likes**
- **See who liked you**
- **Rewind last swipe**
- **Travel mode** — Change location temporarily
- **Boost** — Get top placement for 30 min

---

## 6. UI/UX Guidelines

- **Primary Color:** Warm coral (#FF6B6B) — energetic, romantic
- **Secondary:** Soft teal (#4ECDC4) — fresh, friendly
- **Typography:** Clean sans-serif (Roboto or similar)
- **Navigation:** Bottom tab bar — Discover | Matches | Messages | Profile
- **Dark mode:** Supported

### Key Screens

1. **Splash/Onboarding** — 3-step intro (value prop, permissions, profile setup)
2. **Discover** — Full-screen cards, swipe left/right, tap for details
3. **Match** — Celebration animation, option to message or keep swiping
4. **Chat List** — Conversations sorted by recent activity
5. **Chat Detail** — Messages, voice notes, media sharing
6. **Profile** — Editable, stats (likes, matches), settings access
7. **Settings** — Preferences, safety, account management

---

## 7. Technical Requirements

### Platform Strategy: Kotlin Multiplatform (KMP)

- **Android:** Native with Jetpack Compose
- **iOS:** Jetpack Compose for iOS (shared business logic, native UI where needed)
- **Future-proof:** Single codebase, easier maintenance, faster iteration

### Marketing Site (Vercel)

- **Framework:** Next.js 14 + Tailwind CSS
- **Hosting:** Vercel (auto-deploy from GitHub)
- **Features:**
  - Landing page with hero, features, stats
  - Google Play download button
  - iOS waitlist signup form
  - SEO optimized (OG tags, meta description)
  - Dark theme matching app branding

### Web Admin Panel

- **Framework:** Next.js (same repo or separate)
- **Purpose:** Internal tool for moderation and management
- **Hosting:** Vercel (password protected via middleware)
- **Features:**
  - User management (view, suspend, delete profiles)
  - Report queue (review flagged users)
  - Verification queue (manual review of income/employment claims)
  - Analytics dashboard (DAU, MAU, match rates, revenue)
  - Content moderation (view reported photos/messages)
  - Broadcast messaging (notify all users)

### Platform (Android)
- **Min SDK:** 24 (Android 7.0)
- **Target SDK:** 34 (Android 14)
- **Language:** Kotlin 1.9+

### Architecture
- **Pattern:** MVVM + Clean Architecture
- **DI:** Koin (lightweight, KMP-friendly)
- **Networking:** Ktor Client (KMP-native)
- **Local DB:** Room (for caching)
- **Async:** Kotlin Coroutines + Flow
- **UI:** Jetpack Compose (shared across Android/iOS)

### Backend & Data
- **Backend:** Supabase (PostgreSQL + Edge Functions)
- **Auth:** Supabase Auth (phone + email)
- **Realtime:** Supabase Realtime (live chat)
- **Storage:** Supabase Storage (profile photos)
- **Push:** Firebase Cloud Messaging

### Key Dependencies
- Jetpack Compose + Compose Multiplatform
- Koin (dependency injection)
- Ktor (HTTP client)
- Room (local database)
- Coil (image loading, KMP support)
- Supabase Kotlin SDK

---

## 8. Monetization

| Model | Description |
|-------|-------------|
| Freemium | Core features free, premium $14.99/mo or $119.99/yr (higher price point fits niche) |
| Credits | Buy "Super Likes" à la carte ($2 each) — stand out to serious matches |
| Spotlight | Boost profile for 30 min ($5) — gets priority placement |

**Note:** Higher price point aligns with wealth-conscious audience. Free tier has limited daily likes to drive conversions.

---

## 9. Roadmap

### Phase 0 — Pre-Development (Week 0)
- [x] PRD finalization
- [x] Database schema (Supabase)
- [x] Marketing site (Next.js → Vercel)
- [x] CI/CD setup (GitHub Actions)

### Phase 1 — MVP (Weeks 1–10)
- KMP project setup + shared module
- Android: Compose UI + navigation
- Supabase backend: users, matching, messages
- Basic swiping, matching, chat
- Phone auth
- Income self-report + basic verification

### Phase 2 — Polish (Weeks 11–16)
- iOS shell (Compose for iOS)
- Income/employment verification flow (manual review)
- Lifestyle tags, dealbreakers
- Push notifications
- Safety features (reporting, blocking)

### Phase 3 — Growth (Weeks 17+)
- iOS full release
- Premium features
- Ads integration
- Analytics + A/B testing
- Performance optimization

### Phase 4 — Admin & Management (Parallel)
- Web admin panel (Next.js)
- User moderation tools
- Verification review queue
- Analytics dashboard

---

## 10. Success Metrics

- **DAU/MAU ratio:** > 20%
- **Match rate:** > 10% of swipes result in match
- **Message rate:** > 60% of matches start a conversation
- **Retention:** > 30% day-7, > 15% day-30
- **Reports per 1K users:** < 5

---

*Document Version: 1.0*  
*Created: 2026-03-02*
