# Spark — Paywall & Monetization Spec

## Overview

Freemium model with premium features designed for wealth-conscious audience. Higher price point ($14.99/mo) aligns with user expectations.

---

## Free Tier Features

| Feature | Limit |
|---------|-------|
| Profile creation | ✅ |
| Swiping | 10 likes/day |
| See who liked you | ❌ |
| Messaging | Limited to matches |
| Filters | Basic (age, distance) |
| Income filters | ❌ |
| Super Likes | 1/week |
| Boost | ❌ |

---

## Premium Tier — "Spark Premium" ($14.99/mo or $119.99/yr)

### All Free Features +

| Feature | Description |
|---------|-------------|
| **Unlimited Likes** | Swipe without limits |
| **See Who Liked You** | Access "Likes You" queue before swiping |
| **Income Filters** | Filter by income brackets |
| **Advanced Filters** | Education, occupation, lifestyle tags |
| **5 Super Likes/day** | Stand out with 5 super likes daily |
| **Boost** | Top priority for 30 min — $5 each |
| **Rewind** | Undo accidental left swipes |
| **Travel Mode** | Change location temporarily |
| **Incognito Mode** | Browse without appearing to others |
| **Read Receipts** | See when messages are read |
| **No Ads** | (if ads added later) |

---

## Paywall Screen Design

### Screen: "Unlock Spark Premium"

```
┌─────────────────────────────────────┐
│                                     │
│           🔥 SPARK PREMIUM          │
│                                     │
│   Connect with exceptional people   │
│                                     │
├─────────────────────────────────────┤
│                                     │
│  ✓  Unlimited Likes                │
│  ✓  See Who Liked You              │
│  ✓  Advanced Income Filters         │
│  ✓  5 Super Likes / day            │
│  ✓  Profile Boosts                 │
│  ✓  Incognito Mode                 │
│                                     │
├─────────────────────────────────────┤
│                                     │
│   ┌─────────────────────────────┐   │
│   │   $14.99 / month            │   │
│   └─────────────────────────────┘   │
│                                     │
│   Or save 33% with yearly:          │
│   ┌─────────────────────────────┐   │
│   │  $119.99 / year   $9.99/mo  │   │
│   └─────────────────────────────┘   │
│                                     │
│        [ Continue ]                 │
│                                     │
│   🔒 Secure payment via Stripe     │
│                                     │
└─────────────────────────────────────┘
```

### Trigger Points (When to Show Paywall)

1. **Daily Like Limit Reached** — "You've run out of likes! Upgrade to unlock more."
2. **Viewing "Likes You" Tab** — Blurred preview, tap to upgrade
3. **Using Income Filter** — "Premium feature. Upgrade to filter by income."
4. **Profile Actions** — "Boost your profile — Premium only"
5. **Settings** — Some premium settings show lock icon

### UX Best Practices

- **Don't block core functionality** — Free users can still match and chat
- **Show value, not just limitations** — Feature-focused, not punishment-focused
- **Timing** — Show after first 5+ matches (user is engaged)
- **Pricing psychology** — Yearly shows "per month" equivalent ($9.99/mo)

---

## Stripe Integration

### Products

| Product ID | Name | Price |
|------------|------|-------|
| spark_premium_monthly | Spark Premium (Monthly) | $14.99 |
| spark_premium_yearly | Spark Premium (Yearly) | $119.99 |
| spark_superlike_pack | 5 Super Likes | $4.99 |
| spark_boost_30min | Profile Boost (30 min) | $4.99 |

### Flow

1. User taps "Subscribe" → Redirect to Stripe Checkout (hosted)
2. Stripe Webhook → Supabase `subscriptions` table updated
3. App polls / checks subscription status on launch
4. Premium features unlocked immediately

---

## Conversion Optimization Ideas

- **Free trial:** 3 days of premium on signup (removes friction)
- **Welcome offer:** $0.99 first month for new users
- **Referral bonus:** Free premium days for both users
- **Win-back:** "We miss you" — free week after 30 days inactive
