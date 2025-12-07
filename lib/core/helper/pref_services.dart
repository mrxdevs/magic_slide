import 'package:shared_preferences/shared_preferences.dart';

class PrefServices {
  static final PrefServices _instance = PrefServices._();

  PrefServices._();

  static PrefServices get instance => _instance;

  final _sharedPreferences = SharedPreferences.getInstance();

  Future<bool> isLoggedIn() async {
    final prefs = await _sharedPreferences;
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> setIsLoggedIn(bool value) async {
    final prefs = await _sharedPreferences;
    await prefs.setBool('isLoggedIn', value);
  }
}
