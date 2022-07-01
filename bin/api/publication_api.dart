import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/publication.dart';
import '../services/services.dart';

class PublicationApi {
  final GenericService _service;

  PublicationApi(this._service);
  Handler get handler {
    Router router = Router();

    router.get("/blog/noticias", (Request req) {
      _service.findAll();
      return Response.ok('Choveu hoje');
    });

    router.post("/blog/noticias", (Request req) {
      _service.save(
        Publication(
          id: 0,
          title: "titulo",
          body: "descrição",
          image: 'aaaaa',
          publicationDate: DateTime.now(),
        ),
      );
      return Response.ok('Choveu hoje');
    });

    router.put("/blog/noticias", (Request req) {
      String? id = req.url.queryParameters['id'];
      _service.save(
        Publication(
          id: 0,
          title: "titulo",
          body: "descrição",
          image: 'aaaaa',
          publicationDate: DateTime.now(),
        ),
      );
      return Response.ok('Choveu hoje');
    });

    router.delete("/blog/noticias", (Request req) {
      _service.delete(2);
      return Response.ok('Choveu hoje');
    });

    return router;
  }
}
