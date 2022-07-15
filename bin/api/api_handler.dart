import 'package:shelf/shelf.dart';

import '../infra/infra.dart';

abstract class ApiHandler {
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  });

  Handler createHandler({
    required Handler handler,
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    middlewares ??= [];

    if (isSecurity) {
      var _securityService = DependencyInjector().get<SecurityService>();
      middlewares.addAll([
        _securityService.authorization,
        _securityService.verifyJwt,
      ]);
    }

    var pipeline = Pipeline();
    for (var middleware in middlewares) {
      pipeline = pipeline.addMiddleware(middleware);
    }

    return pipeline.addHandler(handler);
  }
}
