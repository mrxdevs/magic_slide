import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase configuration and client initialization
class SupabaseConfig {
  // Get these from: https://app.supabase.com/project/_/settings/api
  static const String supabaseUrl = 'https://mgznydkaegsvjzcrjumz.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_hc3qM04ihfFTrqyoYX068Q_26dxKtIr';

  /// Initialize Supabase
  /// Call this in main() before runApp()
  static Future<void> initialize() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  /// Get the Supabase client instance
  static SupabaseClient get client => Supabase.instance.client;
}
