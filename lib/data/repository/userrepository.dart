import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  SharedPreferences spf;
  UserRepository(this.spf);

  Future<bool> hasToken() async {
    return spf.getString('token') != null;
  }

  Future<void> persistToken(String token) async {
    spf.setString('token', token);
  }

  Future<void> clearToken() async {
    spf.remove('token');
  }
}
