class User {
  //final String _id;
  final String fullName;
  final String phoneNumber;
  final String type;

  User({this.fullName, this.phoneNumber, this.type});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'fullName': fullName, 'phoneNumber': phoneNumber, 'type': type};
}
