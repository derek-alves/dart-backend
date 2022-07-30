import 'dart:developer';

import 'package:password_dart/password_dart.dart';

import '../../transfer_object/transfer_object.dart';
import '../services.dart';

class LoginService {
  final UserService _userService;

  LoginService(this._userService);

  Future<int> authenticate(AuthTransferObject to) async {
    try {
      var user = await _userService.findByEmail(to.email);
      if (user == null) return -1;
      return Password.verify(to.password, user.password!) ? user.id! : -1;
    } catch (e) {
      log('[ERROR] -> Autennticate method');
    }
    return -1;
  }
}
