import 'dart:convert';

import 'package:http/http.dart';
import 'package:michango/models/contributor.dart';

class ContributorService {
  final Uri apiUrl = Uri.parse('http://172.20.10.2:3000/api/v1/contributors');
  //final Uri apiUrl = Uri.parse('http://192.168.1.174:3000/api/v1/contributors');

  Future<Contributor> createContributor(contributor) async {
    Map data = {
      'fullName': contributor.fullName,
      'phoneNumber': contributor.phoneNumber,
      'pledgedAmount': contributor.pledgedAmount,
      'paidAmount': contributor.paidAmount,
      'title': contributor.title,
      'event': contributor.event
    };

    Response response = await post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return Contributor.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add contributor');
    }
  }

  Future<List<Contributor>> getContributors() async {
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
