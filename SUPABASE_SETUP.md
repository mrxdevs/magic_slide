# Supabase Authentication Setup Guide

## Quick Start

Your Supabase authentication is fully implemented! Follow these steps to configure and test:

### 1. Get Your Supabase Credentials

1. Go to [app.supabase.com](https://app.supabase.com)
2. Select your project (or create a new one)
3. Navigate to **Settings** → **API**
4. Copy your:
   - **Project URL** (looks like: `https://xxxxx.supabase.co`)
   - **Anon public key** (starts with `eyJhbG...`)

### 2. Add Credentials to Your App

Open `lib/core/config/supabase_config.dart` and replace the placeholders:

```dart
static const String supabaseUrl = 'https://your-project.supabase.co';  // Replace this
static const String supabaseAnonKey = 'your-anon-key-here';           // Replace this
```

### 3. Enable Email Authentication in Supabase

1. In your Supabase dashboard, go to **Authentication** → **Providers**
2. Ensure **Email** is enabled
3. Configure email settings:
   - **Enable email confirmations** (optional but recommended)
   - **Configure SMTP** for custom emails (optional)

### 4. Test the Authentication

Run your app:
```bash
flutter run
```

#### Test Sign Up
1. Navigate to Sign Up screen
2. Enter email and password (min 8 characters)
3. Passwords must match
4. Click "Sign Up"
5. Check Supabase dashboard → **Authentication** → **Users** to verify

#### Test Sign In
1. Use the credentials from sign up
2. Click "Login"
3. Should navigate to Home screen

#### Test Forgot Password
1. Click "Forgot Password?" on login screen
2. Enter your email
3. Click "Send Reset Link"
4. Check your email inbox

## Features Implemented

✅ **Sign Up**: Create new user accounts with email/password  
✅ **Sign In**: Authenticate existing users  
✅ **Sign Out**: End user session  
✅ **Forgot Password**: Send password reset emails  
✅ **Form Validation**: Email format, password length, password matching  
✅ **Error Handling**: User-friendly error messages  
✅ **Loading States**: Visual feedback during API calls  
✅ **Success Messages**: Confirmation dialogs and snackbars  

## File Structure

```
lib/
├── core/
│   └── config/
│       └── supabase_config.dart          # Supabase client configuration
├── feature/
│   └── login_signup/
│       ├── data/
│       │   └── auth_controller.dart      # Authentication service
│       ├── login_screen.dart             # Login UI
│       ├── signup_screen.dart            # Sign up UI
│       └── forgot_password_screen.dart   # Password reset UI
└── main.dart                             # Supabase initialization
```

## Authentication Controller Methods

```dart
// Sign up a new user
await authController.signUp(email: email, password: password);

// Sign in existing user
await authController.signIn(email: email, password: password);

// Sign out current user
await authController.signOut();

// Send password reset email
await authController.resetPassword(email: email);

// Check if user is signed in
bool isLoggedIn = authController.isSignedIn();

// Get current user
User? user = authController.getCurrentUser();

// Listen to auth state changes
authController.authStateChanges.listen((AuthState state) {
  // Handle auth state changes
});
```

## Common Issues & Solutions

### Issue: "Invalid login credentials"
- **Cause**: Wrong email or password
- **Solution**: Verify credentials or use forgot password

### Issue: "User already registered"
- **Cause**: Email already exists in database
- **Solution**: Use sign in instead, or reset password

### Issue: "Email not confirmed"
- **Cause**: Email confirmation required but not completed
- **Solution**: Check email inbox for confirmation link

### Issue: Supabase initialization fails
- **Cause**: Invalid credentials in config
- **Solution**: Double-check URL and anon key in `supabase_config.dart`

## Security Notes

⚠️ **Never commit your Supabase credentials to version control**

For production apps, consider using environment variables:
1. Create a `.env` file (add to `.gitignore`)
2. Use a package like `flutter_dotenv`
3. Load credentials from environment

## Next Steps

1. **Add user profiles**: Extend with user profile data
2. **Social auth**: Add Google, GitHub, etc.
3. **Email verification**: Enforce email confirmation
4. **Session management**: Handle token refresh
5. **Protected routes**: Add auth guards to routes

## Resources

- [Supabase Auth Documentation](https://supabase.com/docs/guides/auth)
- [Flutter Supabase Package](https://pub.dev/packages/supabase_flutter)
- [Supabase Dashboard](https://app.supabase.com)
