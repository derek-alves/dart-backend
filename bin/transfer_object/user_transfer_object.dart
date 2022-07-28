import 'dart:convert';

class UserTransferObject {
  final String email;
  final String password;

  UserTransferObject(this.email, this.password);

  factory UserTransferObject.fromRequest(String body) {
    var map = jsonDecode(body);
    return UserTransferObject(map['email'], map['password']);
  }
}
