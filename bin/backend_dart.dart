import 'package:shelf/shelf.dart';

import 'api/api.dart';
import 'infra/infra.dart';
import 'services/services.dart';
import 'utils/utils.dart';

void main() async {
  CustomEnv.fromFile('.env');

  var cascadeHandler = Cascade()
      .add(
        LoginApi().handler,
      )
      .add(
        PublicationApi(PublicationService()).handler,
      )
      .handler;

  var handler = Pipeline()
      .addMiddleware(
        logRequests(),
      )
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
