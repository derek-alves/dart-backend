import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../../utils/custom_env.dart';
import 'security_service.dart';

class SecurityServiceImp extends SecurityService<JWT> {
  @override
  Future<String> generateJWT(String userID) async {
    var jwt = JWT({
      'iat': DateTime.now().millisecondsSinceEpoch,
      'userID': userID,
    });
    String secretKey = await CustomEnv.get(key: 'jwt_key');
    return jwt.sign(SecretKey(secretKey));
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    String secretKey = await CustomEnv.get(key: 'jwt_key');
    return JWT.verify(token, SecretKey(secretKey));
  }
}
