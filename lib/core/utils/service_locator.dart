import 'package:fruity_app/features/auth/data/repositries/auth_repo_impl.dart';
import 'package:fruity_app/features/auth/domain/repositries/auth_repo.dart';
import 'package:get_it/get_it.dart';

final GetIt servicesLocator = GetIt.instance;

class ServicesLocator {
  void setupServiceLocator() {
    servicesLocator.registerLazySingleton<AuthRepo>(() {
      return AuthRepoImpl();
    });
  }
}
