import 'package:shared_preferences/shared_preferences.dart';

class PrefServices {
  static final PrefServices _instance = PrefServices._();

  PrefServices._();

  static PrefServices get instance => _instance;

  final _sharedPreferences = SharedPreferences.getInstance();

  // User Info
  Future<String?> getUserEmail() async {
    final prefs = await _sharedPreferences;
    return prefs.getString('userEmail');
  }

  Future<String?> getUserUid() async {
    final prefs = await _sharedPreferences;
    return prefs.getString('userUid');
  }

  Future<void> setUserEmail(String email) async {
    final prefs = await _sharedPreferences;
    await prefs.setString('userEmail', email);
  }

  Future<void> setUserUid(String uid) async {
    final prefs = await _sharedPreferences;
    await prefs.setString('userUid', uid);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await _sharedPreferences;
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> setIsLoggedIn(bool value) async {
    final prefs = await _sharedPreferences;
    await prefs.setBool('isLoggedIn', value);
  }
}
