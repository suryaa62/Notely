import 'package:get_it/get_it.dart';
import 'package:notes_app/core/Notifiers/loginPageNotifier.dart';
import 'package:notes_app/core/Notifiers/profilePageNotifier.dart';
import 'package:notes_app/core/services/FAuth.dart';

import 'core/services/Fstore.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<FAuthenticate>(() => FAuthenticate());
  locator.registerLazySingleton<Fstore>(() => Fstore());
  locator.registerLazySingleton(() => LoginPageNotifier());
  locator.registerFactory(() => ProfilePageNotifier());
}
