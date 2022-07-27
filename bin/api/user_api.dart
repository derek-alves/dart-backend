import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/models.dart';
import '../services/user/user_service.dart';
import 'api.dart';

class UserApi extends ApiHandler {
  final UserService _userService;

  UserApi(this._userService);
  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    final router = Router();

    router.post('/user', (Request request) async {
      var body = await request.readAsString();

      if (body.isEmpty) return Response(400);

      var user = User.fromRequest(
        jsonDecode(
          body,
        ),
      );
      return await _userService.save(user) ? Response(201) : Response(500);
    });

    return createHandler(
      handler: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}
