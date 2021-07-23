import 'dart:convert';

import 'package:http/http.dart';
import 'package:michango/models/user.dart';

class UserService {
  final Uri apiUrl = Uri.parse('http://localhost:3000/api/v1/users');

  Future<User> createUser(User user) async {
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
    final Response response = await get(apiUrl);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      return User.fromJson(body);
    } else {
      throw Exception('Failed to regiser user');
    }
  }
}
