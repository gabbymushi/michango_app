class Contributor {
  final String id;
  final String fullName;
  final String event;
  final String title;
  final String phoneNumber;
  final String email;
  final int amount;
  final int balance;

  Contributor(
      {this.id,
      this.fullName,
      this.event,
      this.title,
      this.phoneNumber,
      this.email,
      this.amount,
      this.balance});

  factory Contributor.fromJson(Map<String, dynamic> json) {
    return Contributor(
      id: json['_id'],
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
        'id': _d,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'event': event,
        'title': title,
        'email': email,
        'amount': amount,
        'balance': balance
      };
}
