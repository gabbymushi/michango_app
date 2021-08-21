class User {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String type;

  User({this.id, this.fullName, this.phoneNumber, this.type});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'type': type
      };
}
