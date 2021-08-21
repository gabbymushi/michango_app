class Event {
  final String id;
  final String name;
  final String venue;
  final String date;

  Event({this.id, this.name, this.venue, this.date});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      name: json['name'],
      venue: json['venue'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'venue': venue, 'date': date};
}
