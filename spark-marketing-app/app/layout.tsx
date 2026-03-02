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
