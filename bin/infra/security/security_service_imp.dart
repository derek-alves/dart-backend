import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../utils/utils.dart';
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
    try {
      return JWT.verify(token, SecretKey(secretKey));
    } on JWTInvalidError {
      return null;
    } on JWTExpiredError {
      return null;
    } on JWTNotActiveError {
      return null;
    } on JWTUndefinedError {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request request) async {
        String? authorizationHeader = request.headers['Authorization'];
        JWT? jwt;

        if (authorizationHeader?.startsWith('Bearer ') == true) {
          String token = authorizationHeader!.substring(7);
          jwt = await validateJWT(token);
        }

        return handler(request.change(context: {'jwt': jwt}));
      };
    };
  }

  @override
  Middleware get verifyJwt => createMiddleware(
        requestHandler: (Request request) {
          if (request.context['jwt'] == null) {
            return Response.forbidden("Not Authorized");
          }
          return null;
        },
      );
}
