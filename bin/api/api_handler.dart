import 'package:shelf/shelf.dart';

abstract class ApiHandler {
  Handler getHandler({List<Middleware>? middlewares});

  Handler createHandler({
    required Handler handler,
    List<Middleware>? middlewares,
  }) {
    middlewares ??= [];
    var pipeline = Pipeline();

    for (var middleware in middlewares) {
      pipeline = pipeline.addMiddleware(middleware);
    }

    return pipeline.addHandler(handler);
  }
}
