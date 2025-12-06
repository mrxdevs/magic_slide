import 'package:magic_slide/core/config/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Authentication controller for handling user authentication with Supabase
class AuthController {
  // Get Supabase client instance
  SupabaseClient get _supabase => SupabaseConfig.client;

  /// Sign up a new user with email and password
  /// Returns the user on success, throws an exception on error
  Future<User?> signUp({required String email, required String password}) async {
    try {
      final response = await _supabase.auth.signUp(email: email, password: password);
      return response.user;
    } on AuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An unexpected error occurred during sign up';
    }
  }

  /// Sign in an existing user with email and password
  /// Returns the user session on success, throws an exception on error
  Future<Session?> signIn({required String email, required String password}) async {
    try {
      final response = await _supabase.auth.signInWithPassword(email: email, password: password);
      return response.session;
    } on AuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An unexpected error occurred during sign in';
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw 'Failed to sign out';
    }
  }

  /// Send password reset email to the user
  /// Always returns success for security reasons (doesn't reveal if email exists)
  Future<void> resetPassword({required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'Failed to send password reset email';
    }
  }

  /// Get the current authenticated user
  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  /// Check if a user is currently signed in
  bool isSignedIn() {
    return _supabase.auth.currentUser != null;
  }

  /// Get current session
  Session? getCurrentSession() {
    return _supabase.auth.currentSession;
  }

  /// Stream of authentication state changes
  Stream<AuthState> get authStateChanges {
    return _supabase.auth.onAuthStateChange;
  }

  /// Handle authentication exceptions and return user-friendly messages
  String _handleAuthException(AuthException exception) {
    switch (exception.message) {
      case 'Invalid login credentials':
        return 'Invalid email or password';
      case 'Email not confirmed':
        return 'Please verify your email address';
      case 'User already registered':
        return 'An account with this email already exists';
      default:
        return exception.message;
    }
  }
}
