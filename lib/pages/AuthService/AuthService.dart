import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  Future<void> saveUserInfo(String info) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("info", info);
  }
  Future<String> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('info') ?? "";
  }

  Future<void> saveDate(String date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("date", date);
  }
  Future<String> getDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('date') ?? "";
  }

}
