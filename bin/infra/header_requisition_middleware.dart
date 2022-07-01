import 'package:shelf/shelf.dart';

class HeaderRequisitionMiddleware {
  Middleware get applicationJsonMiddleware => createMiddleware(
        responseHandler: (Response res) => res.change(
          headers: {'content-type': 'application/json'},
        ),
      );
}
