import 'package:chat_app/core/services/auth_services.dart';
import 'package:get_it/get_it.dart';

import 'core/services/database_service.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerSingleton(AuthServices());
  locator.registerSingleton(DatabaseService());
}
