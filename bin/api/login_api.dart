import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/infra.dart';
import '../services/services.dart';
import '../transfer_object/transfer_object.dart';
import 'api.dart';

class LoginApi extends ApiHandler {
  final SecurityService _securityService;
  final LoginService _loginService;

  LoginApi(this._loginService, this._securityService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post("/login", (Request req) async {
      var body = await req.readAsString();
      var userTO = AuthTransferObject.fromRequest(body);

      var userID = await _loginService.authenticate(userTO);
      if (userID > 0) {
        var jwt = await _securityService.generateJWT(userID.toString());
        return Response.ok(jsonEncode({'token': jwt}));
      } else {
        return Response(401);
      }
    });

    return createHandler(
      handler: router,
      middlewares: middlewares,
    );
  }
}
