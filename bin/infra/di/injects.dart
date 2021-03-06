import '../../api/api.dart';
import '../../api/user_api.dart';
import '../../models/models.dart';
import '../../repositories/publication_repository.dart';
import '../../repositories/repostories.dart';
import '../../services/services.dart';
import '../infra.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<DBConnection>(() => MySqlDbConfiguration());

    di.register<SecurityService>(() => SecurityServiceImp());

    di.register<PublicationRepository>(() => PublicationRepository(di.get()));
    di.register<GenericService<Publication>>(
        () => PublicationService(di.get()));

    di.register<PublicationApi>(() => PublicationApi(di.get()));

    di.register<UserRepository>(() => UserRepository(di.get()));
    di.register<UserService>(() => UserService(di.get()));
    di.register<UserApi>(() => UserApi(di.get()));

    di.register<LoginService>(() => LoginService(di.get()));
    di.register<LoginApi>(() => LoginApi(di.get(), di.get()));

    return di;
  }
}
