# Spark App UI Specification

## Design System

### Colors
- **Primary:** Coral #FF6B6B (warm, energetic, romantic)
- **Secondary:** Teal #4ECDC4 (fresh, friendly)
- **Background Light:** #FFFFFF
- **Background Dark:** #1A1A2E
- **Text Primary:** #2D3436
- **Text Secondary:** #636E72
- **Success:** #00B894
- **Error:** #E74C3C
- **Warning:** #FDCB6E

### Typography
- **Font:** System default (San Francisco iOS / Roboto Android)
- **Heading 1:** 28px, Bold
- **Heading 2:** 24px, SemiBold
- **Heading 3:** 20px, SemiBold
- **Body:** 16px, Regular
- **Caption:** 14px, Regular
- **Small:** 12px, Regular

### Spacing (8pt grid)
- **xs:** 4px
- **sm:** 8px
- **md:** 16px
- **lg:** 24px
- **xl:** 32px
- **xxl:** 48px

---

## Screen Structure

### Navigation
- **Bottom Tab Bar:** Discover | Matches | Messages | Profile
- **Height:** 60px + safe area

---

## Screens

### 1. Splash / Onboarding

#### 1.1 Welcome Screen
- Full screen illustration (spark/connection themed)
- Logo (centered, 120x120)
- Tagline: "Quality Connections. Not Just Matches."
- "Get Started" button (primary, full width - 16px margins)

#### 1.2 Permissions Screen
- Illustration: phone with notifications
- Title: "Enable Notifications"
- Subtitle: "Get matches and messages in real-time"
- "Enable" button
- "Skip" text button (secondary)

#### 1.3 Profile Setup Screen
- Multi-step form with progress indicator
- Steps:
  1. Photos (upload 2-6, first = primary)
  2. Basic info (name, birth date, gender)
  3. About (bio, prompts)
  4. Preferences (what you're seeking)
  5. Verification (optional income/employment)
- Progress bar at top (step X of 5)
- "Next" / "Back" navigation

---

### 2. Discover Screen

#### 2.1 Card Stack
- Full-screen card (with safe area padding)
- Card content:
  - Photo carousel (swipeable, dots indicator)
  - Name + Age (top-left overlay)
  - Verified badge (if applicable)
  - Location (e.g., "2 miles away")
  - Bio preview (2 lines max)
  - Lifestyle tags (horizontal scroll, max 4 visible)
  - Compatibility score (percentage, top-right)
- Gradient overlay at bottom for text readability

#### 2.2 Action Buttons (bottom of card)
- X button (pass) — left, 60px circle, gray
- Heart button (like) — right, 60px circle, coral
- Super Like star — center, 50px circle, teal (premium)

#### 2.3 Filters (top bar)
- Filter icon (opens filter sheet)
- Active filter pills below (e.g., "$100k+", "25-35", "10mi")

#### 2.4 Filter Sheet (bottom sheet)
- Age range slider
- Distance slider
- Income range (dropdown: $50k+, $100k+, $250k+, $500k+)
- Lifestyle tags (multi-select chips)
- "Apply" button

---

### 3. Match Screen

#### 3.1 Match Celebration
- Full screen overlay
- Both user photos (circular, animated bounce)
- "It's a Match!" headline (coral, 32px)
- "You and [Name] liked each other" subtitle
- "Send Message" button (primary)
- "Keep Swiping" button (secondary/outline)

---

### 4. Matches Screen (Who Liked You)

#### 4.1 Grid View
- Section: "Who Likes You" (if free: blur, "Upgrade to see")
- Grid: 3 columns, square thumbnails
- Overlay on each: name + compatibility %
- Tap → profile detail

#### 4.2 Profile Detail (from match grid)
- Large photo (can swipe)
- Name, age, location
- Verified badges
- Bio
- Lifestyle tags
- "Like Back" button
- "Pass" button

---

### 5. Messages / Chat List

#### 5.1 Conversation List
- Search bar at top
- List items:
  - Avatar (48px circle)
  - Name (bold)
  - Last message preview (gray, 1 line)
  - Timestamp (right aligned)
  - Unread dot (coral, if unread)
  - Online status indicator (green dot)
- Empty state: "No matches yet"

#### 5.2 Chat Detail
- Header: avatar + name + online status
- Back button + menu (report, block)
- Message bubbles:
  - Sent: coral background, white text, right
  - Received: gray background, left
  - Timestamp below each bubble
- Input area:
  - Text input (expandable)
  - Voice note button (hold to record)
  - Send button (coral)
- Voice note playback: waveform + play/pause
- Image preview: tap to expand

#### 5.3 Message Input States
- Default: "Type a message..."
- Typing: show "Typing..." in chat
- Voice: hold mic button, release to send

---

### 6. Profile Screen

#### 6.1 My Profile Header
- Large photo (tap to edit)
- Edit button (pencil icon)
- Name + Age
- Location
- Verification badges
- Stats row: Likes | Matches | Profile Views

#### 6.2 Profile Details (scrollable)
- Bio section
- Lifestyle tags
- "My Standards" (dealbreakers)
- Preferences summary

#### 6.3 Premium Banner
- "Upgrade to Premium" card
- Benefits: unlimited likes, see who liked you, etc.

#### 6.4 Settings List
- Account Settings
- Discovery Preferences
- Safety & Privacy
- Help & Support
- Log Out

---

### 7. Settings Screens

#### 7.1 Discovery Settings
- Age range
- Distance
- Income preferences
- Show me: Men / Women / Everyone
- Premium: Travel mode, etc.

#### 7.2 Safety & Privacy
- Incognito mode toggle
- Show online status toggle
- Read receipts toggle
- Blocked users list
- Delete account (danger zone)

---

## Components

### Buttons
- **Primary:** Coral bg, white text, 48px height, 12px radius
- **Secondary:** Transparent, coral border, coral text
- **Text:** No bg, coral text
- **Disabled:** Gray bg, gray text

### Input Fields
- Height: 48px
- Border: 1px #E0E0E0
- Focus: 2px coral border
- Radius: 8px
- Label above (14px, gray)

### Chips / Tags
- Height: 32px
- Padding: 12px horizontal
- Radius: 16px (pill)
- Selected: coral bg, white text
- Unselected: gray bg, dark text

### Cards
- Radius: 16px
- Shadow: 0 2px 8px rgba(0,0,0,0.1)
- Padding: 16px

### Bottom Sheets
- Handle bar at top (40px wide, 4px height, gray)
- Radius top: 24px
- Max height: 70% screen

### Modals
- Centered
- Radius: 24px
- Backdrop: 50% black overlay

---

## Animations

### Card Swipe
- Rotate based on drag direction (±15° max)
- Opacity fade on overlay (Like/Pass stamp)
- Spring animation on release

### Match Celebration
- Confetti burst
- Photos scale up with bounce
- Buttons fade in after 500ms

### Tab Bar
- Icon scale on tap (1.0 → 1.2 → 1.0)
- Color transition: 200ms

---

## Dark Mode

- Background: #1A1A2E
- Cards: #2D3436
- Text primary: #FFFFFF
- Text secondary: #B2BEC3
- Primary stays coral
- Secondary stays teal
