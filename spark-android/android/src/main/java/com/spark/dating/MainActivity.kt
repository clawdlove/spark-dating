package com.spark.dating

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.ui.Modifier
import com.spark.dating.config.Config
import com.spark.dating.supabase.SupabaseManager
import com.spark.dating.ui.theme.SparkTheme
import com.stripe.android.Stripe

class MainActivity : ComponentActivity() {
    
    private lateinit var stripe: Stripe
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Initialize Supabase
        SupabaseManager.initialize(this)
        
        // Initialize Stripe
        stripe = Stripe(this, Config.STRIPE_PUBLISHABLE_KEY)
        
        setContent {
            SparkTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Text("Spark Dating App")
                }
            }
        }
    }
}
