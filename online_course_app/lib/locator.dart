import 'package:get_it/get_it.dart';
import 'package:online_course_app/services/authService.dart';
import 'package:online_course_app/services/categoryService.dart';
import 'package:online_course_app/services/courseService.dart';
import 'package:online_course_app/services/dialogService.dart';
import 'package:online_course_app/services/mediaService.dart';
import 'package:online_course_app/services/navigationService.dart';
import 'package:online_course_app/services/quizeService.dart';
import 'package:online_course_app/services/userService.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => CategoryService());
  locator.registerLazySingleton(() => CourseService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => QuizeService());
  locator.registerLazySingleton(() => MediaService());
  locator.registerLazySingleton(() => DialogService());
}
