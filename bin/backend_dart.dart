import 'package:shelf/shelf.dart';

import 'api/api.dart';
import 'infra/di/dependency_injector.dart';
import 'infra/infra.dart';
import 'services/services.dart';
import 'utils/utils.dart';

void main() async {
  CustomEnv.fromFile('.env');
  SecurityService _securityService = SecurityServiceImp();

  final _di = DependencyInjector();

  _di.register<SecurityService>(() => SecurityServiceImp(), isSingleton: true);

  var cascadeHandler = Cascade()
      .add(LoginApi(_securityService).getHandler(middlewares: []))
      .add(PublicationApi(PublicationService()).getHandler(middlewares: [
        _securityService.authorization,
        _securityService.verifyJwt,
      ]))
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
