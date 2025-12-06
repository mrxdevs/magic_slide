import 'package:supabase/supabase.dart';

class AuthController {
  final supabase = SupabaseClient;
  late final authSubscription = supabase.onAuthStateChange.listen((data) {
    final AuthChangeEvent event = data.event;
    final Session? session = data.session;

    print('event: $event, session: $session');

    switch (event) {
      case AuthChangeEvent.initialSession:
      // handle initial session
      case AuthChangeEvent.signedIn:
      // handle signed in
      case AuthChangeEvent.signedOut:
      // handle signed out
      case AuthChangeEvent.passwordRecovery:
      // handle password recovery
      case AuthChangeEvent.tokenRefreshed:
      // handle token refreshed
      case AuthChangeEvent.userUpdated:
      // handle user updated
      case AuthChangeEvent.userDeleted:
      // handle user deleted
      case AuthChangeEvent.mfaChallengeVerified:
      // handle mfa challenge verified
    }
  });
}
