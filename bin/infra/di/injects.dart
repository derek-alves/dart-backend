import '../../api/api.dart';
import '../../api/user_api.dart';
import '../../models/models.dart';
import '../../repositories/repostories.dart';
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

    di.register<UserRepository>(() => UserRepository(di.get()));
    di.register<UserService>(() => UserService(di.get()));
    di.register<UserApi>(() => UserApi(di.get()));

    return di;
  }
}
