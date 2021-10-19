import 'dart:convert';

import 'package:http/http.dart';
import 'package:michango/models/event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventService {
  final String baseUrl = 'http://172.20.10.2:3000/api/v1';

  //final Uri apiUrl = Uri.parse('http://192.168.1.174:3000/api/v1/events');

  Future<Event> createInitialEvent(body) async {
    final Uri apiUrl = Uri.parse('$baseUrl/events');

    final Response response = await post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));

    var event = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(event['userMessage']);
    }

    return Event.fromJson(json.decode(response.body));
  }

  Future<Event> createEvent(Event event) async {
    final Uri apiUrl = Uri.parse('$baseUrl/events');

    Map data = {'name': event.name, 'date': event.date};

    final Response response = await post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to regiser event');
    }
  }

  Future<List<Event>> getEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Uri apiUrl =
        Uri.parse("$baseUrl/users/${prefs.getString('userId')}/events");
    Response response = await get(apiUrl, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print(response.body);
      return body.map<Event>((event) => Event.fromJson(event)).toList();
    } else {
      throw Exception('Failed to get events');
    }
  }
}
