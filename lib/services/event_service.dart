import 'dart:convert';

import 'package:http/http.dart';
import 'package:michango/models/event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventService {
  final Uri apiUrl = Uri.parse('http://172.20.10.2:3000/api/v1/events');
  //final Uri apiUrl = Uri.parse('http://192.168.1.174:3000/api/v1/events');

  Future<Event> createInitialEvent(body) async {
    final Response response = await post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to regiser event');
    }
  }

  Future<Event> createEvent(Event event) async {
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
    final Uri apiUrl = Uri.parse(
        "http://172.20.10.2:3000/api/v1/users/${prefs.getString('userId')}/events");
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
