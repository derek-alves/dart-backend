import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/publication.dart';
import '../services/services.dart';
import 'api.dart';

class PublicationApi extends ApiHandler {
  final GenericService<Publication> _service;

  PublicationApi(
    this._service,
  );

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    router.get("/noticias", (Request req) async {
      List<Publication> publications = await _service.findAll();
      return Response.ok(
        jsonEncode(publications.map((e) => e.toJson()).toList()),
      );
    });

    router.post("/noticias", (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(Publication.fromMap(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.put("/noticias", (Request req) {
      String? id = req.url.queryParameters['id'];

      return Response.ok('Choveu hoje');
    });

    router.delete("/noticias", (Request req) {
      _service.delete(2);
      return Response.ok('Choveu hoje');
    });

    return createHandler(
      handler: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}
