class Event {
  //final String _id;
  final String name;
  final String venue;
  final String date;

  Event({this.name, this.venue, this.date});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      venue: json['venue'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'venue': venue, 'date': date};
}
