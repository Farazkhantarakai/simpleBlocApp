import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simplebloc/blocs/authenticationbloc/authenticationbloc.dart';

class AuthRepository {
  AuthRepository();

  String baseUrl = 'https://learnunstoppable.com/fileshare/api/login';

  Future<dynamic> authenticateUser(String email, String password) async {
    String token = '';

    try {
      final response = await http.post(Uri.parse(baseUrl),
          body: {"email": email, "password": password});

      final result = jsonDecode(response.body);
      // debugPrint(result.toString());

      if (response.statusCode == 200) {
        token = result['data']['fcm_token'];
        if (token.isNotEmpty) {
          AuthenticationBloc().persistToken(token);
        }
      }
    } catch (err) {
      rethrow;
    }
    return token;
  }
}
