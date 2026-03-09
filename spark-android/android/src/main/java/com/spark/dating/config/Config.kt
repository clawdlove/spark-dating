package com.spark.dating.config

import com.spark.dating.BuildConfig

object Config {
    // Supabase (from BuildConfig)
    val SUPABASE_URL: String = BuildConfig.SUPABASE_URL
    val SUPABASE_ANON_KEY: String = BuildConfig.SUPABASE_ANON_KEY
    
    // Stripe (from BuildConfig)
    val STRIPE_PUBLISHABLE_KEY: String = BuildConfig.STRIPE_PUBLISHABLE_KEY
    
    // Stripe Product IDs (from your Stripe dashboard - set these in gradle.properties too)
    const val STRIPE_PREMIUM_MONTHLY = "price_premium_monthly"
    const val STRIPE_PREMIUM_YEARLY = "price_premium_yearly"
}
