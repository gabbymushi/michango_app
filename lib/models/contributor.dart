class Contributor {
  final String id;
  final String fullName;
  final String event;
  final String title;
  final String phoneNumber;
  final String email;
  final num pledgedAmount;
  final num paidAmount;

  Contributor(
      {this.id,
      this.fullName,
      this.event,
      this.title,
      this.phoneNumber,
      this.email,
      this.pledgedAmount,
      this.paidAmount});

  factory Contributor.fromJson(Map<String, dynamic> json) {
    return Contributor(
      id: json['_id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      event: json['event'],
      title: json['title'],
      email: json['email'],
      pledgedAmount: json['pledgedAmount'],
      paidAmount: json['paidAmount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'event': event,
        'title': title,
        'email': email,
        'pledgedAmount': pledgedAmount,
        'paidAmount': paidAmount
      };
}
