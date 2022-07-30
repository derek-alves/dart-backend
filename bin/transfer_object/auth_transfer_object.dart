import 'dart:convert';

class AuthTransferObject {
  final String email;
  final String password;

  AuthTransferObject(this.email, this.password);

  factory AuthTransferObject.fromRequest(String body) {
    var map = jsonDecode(body);
    return AuthTransferObject(map['email'], map['password']);
  }
}
