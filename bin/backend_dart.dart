import 'package:shelf/shelf.dart';

import 'api/api.dart';
import 'infra/infra.dart';
import 'utils/utils.dart';

void main() async {
  CustomEnv.fromFile('.env');

  final _di = Injects.initialize();

  var cascadeHandler = Cascade()
      .add(_di.get<LoginApi>().getHandler(middlewares: []))
      .add(_di.get<PublicationApi>().getHandler(isSecurity: true))
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(HeaderRequisitionMiddleware().applicationJsonMiddleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
