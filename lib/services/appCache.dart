import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  final ready = 'pilot';
  final whoLogin = 'whoLogin';
  final firstLoginWork = 'first_login_work';
  final firstLoginCustomer = 'first_login_customer';

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(whoLogin) ?? true;
  }

  Future<bool> checkActivity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(ready) ?? false;
  }

  Future<bool> checkFirstWork() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(firstLoginWork) ?? true;
  }

  Future<bool> checkFirstCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(firstLoginCustomer) ?? true;
  }

  Future<void> doneTipsCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(firstLoginCustomer, false);
  }

  Future<void> doneTipsWork() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(firstLoginWork, false);
  }
}
