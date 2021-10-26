import 'dart:convert';

import 'package:http/http.dart';
import 'package:michango/constants.dart' as Constants;
import 'package:michango/models/contributor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContributorService {
  String baseUrl = Constants.BASE_URL;
  //final Uri apiUrl = Uri.parse('http://192.168.1.174:3000/api/v1/contributors');

  Future<Contributor> createContributor(contributor) async {
    final Uri apiUrl = Uri.parse('$baseUrl/contributors');

    Response response = await post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(contributor));

    if (response.statusCode == 200) {
      return Contributor.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add contributor');
    }
  }

  Future<List<Contributor>> getContributors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Uri apiUrl = Uri.parse(
        '$baseUrl/events/${prefs.getString('currentEventId')}/contributors');

    Response response = await get(apiUrl, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return body
          .map<Contributor>((contributor) => Contributor.fromJson(contributor))
          .toList();
    } else {
      throw Exception('Failed to get contributors');
    }
  }
}
