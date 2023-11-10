import 'dart:convert';

import 'package:http/http.dart';
import 'package:michango/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:michango/constants.dart' as Constants;

class UserService {
  String baseUrl = Constants.BASE_URL;

  Future<User> createUser(User user) async {
    final Uri apiUrl = Uri.parse('$baseUrl/users');

    Map data = {
      'fullName': user.fullName,
      'phoneNumber': user.phoneNumber,
      'type': user.type
    };

    final Response response = await post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to regiser user');
    }
  }

  Future<User> getUsers() async {
    final Uri apiUrl = Uri.parse('$baseUrl/users');

    final Response response = await get(apiUrl);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      return User.fromJson(body);
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  Future<dynamic> login(loginInfo) async {
    final Uri apiUrl = Uri.parse('$baseUrl/auth/login');
    var status = false;

    try {
      final Response response = await post(apiUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(loginInfo));

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var mappedUser = json.decode(response.body)['user'];
        var token = json.decode(response.body)['token'];
        var user = User.fromJson(mappedUser);

        prefs.setString('userId', user.id);
        prefs.setString('fullName', user.fullName);
        prefs.setString('token', token);

        status = true;
      }
    } catch (e) {
      status = false;
    }

    return status;
  }
}
