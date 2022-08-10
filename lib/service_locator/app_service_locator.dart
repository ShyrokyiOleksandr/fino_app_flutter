import 'package:fino/service_locator/app_service_locator_blocs.dart';
import 'package:fino/service_locator/app_service_locator_local_storages.dart';
import 'package:fino/service_locator/app_service_locator_repositories.dart';
import 'package:fino/service_locator/app_service_locator_use_cases.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;


class AppServiceLocator {
  /// Initializes all dependencies declared inside the [AppServiceLocator].
  /// Should only be called before the [runApp] method
  static Future<void> setup() async {
    await AppServiceLocatorBlocs.setup(instance: GetIt.instance);
    await AppServiceLocatorLocalStorages.setup(instance: GetIt.instance);
    await AppServiceLocatorRepositories.setup(instance: GetIt.instance);
    await AppServiceLocatorUseCases.setup(instance: GetIt.instance);

  }

  /// Sets the application general context so instances with context dependency can use it.
  /// Should be called with context under the [MaterialApp] (from the first parent's build method)
  static void registerAppContext(BuildContext context) {
    if (!GetIt.I.isRegistered<BuildContext>()) {
      GetIt.I.registerSingleton<BuildContext>(context);
    }
  }
}