import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const userKey = "user";

  Future<String?> get user async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final user = sharedPreferences.getString(userKey);

    return user;
  }

  Future<void> setUser(String newUser) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(userKey, newUser);
  }
}
