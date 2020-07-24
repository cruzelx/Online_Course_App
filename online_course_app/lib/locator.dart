import 'package:get_it/get_it.dart';
import 'package:online_course_app/services/authService.dart';
import 'package:online_course_app/services/navigationService.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthenticationService());
}
