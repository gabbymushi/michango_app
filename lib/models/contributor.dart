import 'dart:ffi';

class Contributor {
  final String _id;
  final String fullName;
  final String event;
  final String title;
  final String phoneNumber;
  final String email;
  final Float amount;
  final Float balance;

  Contributor(this._id,
      {this.fullName,
      this.event,
      this.title,
      this.phoneNumber,
      this.email,
      this.amount,
      this.balance});

  factory Contributor.fromJson(Map<String, dynamic> json) {
    return Contributor(
      json['_id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      event: json['event'],
      title: json['title'],
      email: json['email'],
      amount: json['amount'],
      balance: json['balance'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'event': event,
        'title': title,
        'email': email,
        'amount': amount,
        'balance': balance
      };
}
