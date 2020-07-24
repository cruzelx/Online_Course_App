import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/services/authService.dart';
import 'package:online_course_app/services/navigationService.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authService = locator<AuthenticationService>();
  final NavigationService _navService = locator<NavigationService>();

  Future login() async {
    var user = await _authService.signIn();
    var isLoggedIn = await _authService.checkLogin();
    if (isLoggedIn) {
      setMessageVisibility(true);
    }
  }
}
