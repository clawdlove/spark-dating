package com.spark.dating.supabase

import android.content.Context
import com.spark.dating.config.Config
import io.github.jan.supabase.SupabaseClient
import io.github.jan.supabase.createSupabaseClient
import io.github.jan.supabase.gotrue.Auth
import io.github.jan.supabase.gotrue.auth
import io.github.jan.supabase.postgrest.Postgrest
import io.github.jan.supabase.postgrest.postgrest

object SupabaseManager {
    lateinit var client: SupabaseClient
    
    fun initialize(context: Context) {
        client = createSupabaseClient(
            supabaseUrl = Config.SUPABASE_URL,
            supabaseKey = Config.SUPABASE_ANON_KEY
        ) {
            install(Auth)
            install(Postgrest)
        }
    }
    
    val auth: Auth get() = client.auth
    val postgrest: Postgrest get() = client.postgrest
}
