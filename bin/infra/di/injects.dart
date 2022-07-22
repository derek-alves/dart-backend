import '../../api/api.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../infra.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<DBConnection>(() => MySqlDbConfiguration());

    di.register<SecurityService>(() => SecurityServiceImp());

    di.register<LoginApi>(() => LoginApi(di.get()));

    di.register<GenericService<Publication>>(() => PublicationService());

    di.register<PublicationApi>(() => PublicationApi(di.get()));

    return di;
  }
}
