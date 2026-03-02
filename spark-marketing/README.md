# Spark Dating App - Marketing Landing Page

A sleek, conversion-focused landing page built with Next.js and Tailwind CSS, ready to deploy on Vercel.

## 🚀 Quick Deploy

```bash
# Clone and deploy
npx create-next-app@latest spark-marketing
cd spark-marketing
# Copy the files below into app/page.tsx, etc.

# Deploy to Vercel
vercel deploy
```

## Project Structure

```
spark-marketing/
├── app/
│   ├── layout.tsx
│   ├── page.tsx
│   ├── globals.css
│   └── layout.tsx
├── public/
│   ├── logo.svg
│   └── og-image.png
├── tailwind.config.ts
├── next.config.js
├── package.json
└── tsconfig.json
```

## Files

### app/layout.tsx
```tsx
import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import './globals.css'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Spark — Quality Dating for Ambitious Singles',
  description: 'Connect with like-minded, successful individuals. Wealth-conscious dating app for quality connections.',
  openGraph: {
    title: 'Spark — Quality Dating for Ambitious Singles',
    description: 'Connect with like-minded, successful individuals.',
    images: ['/og-image.png'],
  },
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className={inter.className}>{children}</body>
    </html>
  )
}
```

### app/page.tsx
```tsx
'use client'

import { useState } from 'react'
import Link from 'next/link'

export default function Home() {
  const [email, setEmail] = useState('')
  const [submitted, setSubmitted] = useState(false)

  const handleWaitlist = (e: React.FormEvent) => {
    e.preventDefault()
    // TODO: Send to Supabase or newsletter service
    setSubmitted(true)
  }

  return (
    <main className="min-h-screen bg-gradient-to-b from-slate-900 via-slate-800 to-black text-white">
      {/* Navigation */}
      <nav className="flex items-center justify-between px-6 py-4 max-w-6xl mx-auto">
        <div className="flex items-center gap-2">
          <div className="w-10 h-10 bg-gradient-to-br from-rose-500 to-orange-400 rounded-full flex items-center justify-center text-2xl font-bold">
            ⚡
          </div>
          <span className="text-2xl font-bold">Spark</span>
        </div>
        <div className="flex gap-4">
          <Link href="#features" className="text-slate-300 hover:text-white transition">Features</Link>
          <Link href="#about" className="text-slate-300 hover:text-white transition">About</Link>
          <a 
            href="https://play.google.com" 
            className="bg-rose-500 hover:bg-rose-600 px-4 py-2 rounded-full font-medium transition"
          >
            Get App
          </a>
        </div>
      </nav>

      {/* Hero */}
      <section className="px-6 py-20 text-center max-w-4xl mx-auto">
        <div className="inline-block px-4 py-1 rounded-full bg-rose-500/20 text-rose-300 text-sm font-medium mb-6">
          Now available on Android
        </div>
        <h1 className="text-5xl md:text-7xl font-bold mb-6 leading-tight">
          Quality Connections.<br />
          <span className="bg-gradient-to-r from-rose-400 to-orange-300 bg-clip-text text-transparent">
            Not Just Matches.
          </span>
        </h1>
        <p className="text-xl text-slate-300 mb-10 max-w-2xl mx-auto">
          The dating app for ambitious singles who want more than superficial swipes. 
          Connect with people who share your drive, values, and vision for life.
        </p>
        <div className="flex flex-col sm:flex-row gap-4 justify-center">
          <a 
            href="https://play.google.com/store/apps/details?id=com.spark.dating" 
            className="bg-rose-500 hover:bg-rose-600 px-8 py-4 rounded-full text-lg font-semibold transition flex items-center justify-center gap-2"
          >
            <svg className="w-6 h-6" viewBox="0 0 24 24" fill="currentColor">
              <path d="M3.609 1.814L13.792 12 3.61 22.186a.996.996 0 01-.61-.92V2.734a1 1 0 01.609-.92zm10.89 10.893l2.302 2.302-10.937 6.333 8.635-8.635zm3.199-3.198l2.807 1.626a1 1 0 010 1.73l-2.808 1.626L15.206 12l2.492-2.491zM5.864 2.658L16.8 8.99l-2.302 2.302-8.634-8.634z"/>
            </svg>
            Download on Android
          </a>
          <button 
            onClick={() => document.getElementById('waitlist')?.scrollIntoView({ behavior: 'smooth' })}
            className="border border-slate-600 hover:border-slate-400 px-8 py-4 rounded-full text-lg font-medium transition"
          >
            Join Waitlist for iOS
          </button>
        </div>
      </section>

      {/* Stats */}
      <section className="px-6 py-16 border-y border-slate-800">
        <div className="max-w-4xl mx-auto grid grid-cols-2 md:grid-cols-4 gap-8 text-center">
          <div>
            <div className="text-4xl font-bold text-rose-400">50K+</div>
            <div className="text-slate-400">Downloads</div>
          </div>
          <div>
            <div className="text-4xl font-bold text-rose-400">12K+</div>
            <div className="text-slate-400">Active Users</div>
          </div>
          <div>
            <div className="text-4xl font-bold text-rose-400">85%</div>
            <div className="text-slate-400">Match Rate</div>
          </div>
          <div>
            <div className="text-4xl font-bold text-rose-400">4.8★</div>
            <div className="text-slate-400">App Rating</div>
          </div>
        </div>
      </section>

      {/* Features */}
      <section id="features" className="px-6 py-20 max-w-6xl mx-auto">
        <h2 className="text-4xl font-bold text-center mb-16">
          Why <span className="text-rose-400">Spark</span>?
        </h2>
        <div className="grid md:grid-cols-3 gap-8">
          {/* Feature 1 */}
          <div className="bg-slate-800/50 rounded-2xl p-6 border border-slate-700 hover:border-rose-500/50 transition">
            <div className="w-12 h-12 bg-rose-500/20 rounded-xl flex items-center justify-center text-2xl mb-4">
              ✓
            </div>
            <h3 className="text-xl font-semibold mb-2">Verified Profiles</h3>
            <p className="text-slate-400">
              Income and employment verification builds trust. Know who you're talking to.
            </p>
          </div>
          {/* Feature 2 */}
          <div className="bg-slate-800/50 rounded-2xl p-6 border border-slate-700 hover:border-rose-500/50 transition">
            <div className="w-12 h-12 bg-rose-500/20 rounded-xl flex items-center justify-center text-2xl mb-4">
              🎯
            </div>
            <h3 className="text-xl font-semibold mb-2">Smart Matching</h3>
            <p className="text-slate-400">
              Our algorithm matches on ambition, values, and lifestyle—not just photos.
            </p>
          </div>
          {/* Feature 3 */}
          <div className="bg-slate-800/50 rounded-2xl p-6 border border-slate-700 hover:border-rose-500/50 transition">
            <div className="w-12 h-12 bg-rose-500/20 rounded-xl flex items-center justify-center text-2xl mb-4">
              💬
            </div>
            <h3 className="text-xl font-semibold mb-2">Meaningful Conversations</h3>
            <p className="text-slate-400">
              Two-step matching ensures mutual interest before the conversation starts.
            </p>
          </div>
          {/* Feature 4 */}
          <div className="bg-slate-800/50 rounded-2xl p-6 border border-slate-700 hover:border-rose-500/50 transition">
            <div className="w-12 h-12 bg-rose-500/20 rounded-xl flex items-center justify-center text-2xl mb-4">
              🔒
            </div>
            <h3 className="text-xl font-semibold mb-2">Safety First</h3>
            <p className="text-slate-400">
              Robust moderation, easy reporting, and incognito mode keep you safe.
            </p>
          </div>
          {/* Feature 5 */}
          <div className="bg-slate-800/50 rounded-2xl p-6 border border-slate-700 hover:border-rose-500/50 transition">
            <div className="w-12 h-12 bg-rose-500/20 rounded-xl flex items-center justify-center text-2xl mb-4">
              ⚡
            </div>
            <h3 className="text-xl font-semibold mb-2">Premium Quality</h3>
            <p className="text-slate-400">
              Designed for successful singles who value their time. No games, no clutter.
            </p>
          </div>
          {/* Feature 6 */}
          <div className="bg-slate-800/50 rounded-2xl p-6 border border-slate-700 hover:border-rose-500/50 transition">
            <div className="w-12 h-12 bg-rose-500/20 rounded-xl flex items-center justify-center text-2xl mb-4">
              🚀
            </div>
            <h3 className="text-xl font-semibold mb-2">iOS Coming Soon</h3>
            <p className="text-slate-400">
              Join the waitlist to be notified when we launch on iOS.
            </p>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="px-6 py-20 bg-gradient-to-t from-rose-900/20 to-transparent">
        <div className="max-w-2xl mx-auto text-center">
          <h2 className="text-4xl font-bold mb-6">Ready to Find Your Match?</h2>
          <p className="text-slate-300 mb-8 text-lg">
            Download Spark today and connect with ambitious singles near you.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <a 
              href="https://play.google.com" 
              className="bg-rose-500 hover:bg-rose-600 px-8 py-4 rounded-full text-lg font-semibold transition"
            >
              Download for Android
            </a>
          </div>
        </div>
      </section>

      {/* Waitlist */}
      <section id="waitlist" className="px-6 py-20 max-w-xl mx-auto">
        <div className="bg-slate-800/50 rounded-2xl p-8 border border-slate-700">
          <h3 className="text-2xl font-bold text-center mb-2">Join the iOS Waitlist</h3>
          <p className="text-slate-400 text-center mb-6">
            Be the first to know when Spark launches on iOS.
          </p>
          {submitted ? (
            <div className="text-center text-rose-400 font-medium">
              ✓ You're on the list! We'll be in touch.
            </div>
          ) : (
            <form onSubmit={handleWaitlist} className="flex flex-col gap-4">
              <input
                type="email"
                placeholder="Enter your email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
                className="w-full px-4 py-3 rounded-full bg-slate-900 border border-slate-600 text-white placeholder-slate-500 focus:outline-none focus:border-rose-500"
              />
              <button 
                type="submit"
                className="w-full bg-rose-500 hover:bg-rose-600 px-6 py-3 rounded-full font-semibold transition"
              >
                Join Waitlist
              </button>
            </form>
          )}
        </div>
      </section>

      {/* Footer */}
      <footer className="px-6 py-12 border-t border-slate-800">
        <div className="max-w-6xl mx-auto flex flex-col md:flex-row justify-between items-center gap-4">
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 bg-gradient-to-br from-rose-500 to-orange-400 rounded-full flex items-center justify-center text-lg font-bold">
              ⚡
            </div>
            <span className="text-xl font-bold">Spark</span>
          </div>
          <div className="flex gap-6 text-slate-400 text-sm">
            <a href="#" className="hover:text-white transition">Privacy</a>
            <a href="#" className="hover:text-white transition">Terms</a>
            <a href="#" className="hover:text-white transition">Contact</a>
          </div>
          <div className="text-slate-500 text-sm">
            © 2026 Spark Dating. All rights reserved.
          </div>
        </div>
      </footer>
    </main>
  )
}
```

### tailwind.config.ts
```ts
import type { Config } from 'tailwindcss'

const config: Config = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        rose: {
          400: '#fb7185',
          500: '#f43f5e',
          600: '#e11d48',
        },
      },
    },
  },
  plugins: [],
}
export default config
```

### package.json
```json
{
  "name": "spark-marketing",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "next": "14.2.0",
    "react": "^18",
    "react-dom": "^18"
  },
  "devDependencies": {
    "@types/node": "^20",
    "@types/react": "^18",
    "@types/react-dom": "^18",
    "autoprefixer": "^10.0.1",
    "postcss": "^8",
    "tailwindcss": "^3.4.0",
    "typescript": "^5"
  }
}
```

## Customization

1. **Replace the app link** in the download buttons with your actual Google Play URL
2. **Update stats** with real numbers once you have them
3. **Connect the waitlist form** to Supabase or any email service (ConvertKit, Mailchimp, etc.)
4. **Add app screenshots** in a hero gallery section
5. **Configure OG image** at `public/og-image.png` (1200x630px)

## Deployment

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel

# Or connect GitHub repo in Vercel dashboard for automatic deploys
```
