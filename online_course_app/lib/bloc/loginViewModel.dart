import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/userModel.dart';
import 'package:online_course_app/services/authService.dart';
import 'package:online_course_app/services/navigationService.dart';
import 'package:online_course_app/services/userService.dart';

class LoginViewModel extends BaseModel {
  LoginViewModel() {
    fetchCurrentUser();
  }
  final AuthenticationService _authService = locator<AuthenticationService>();
  final UserService _userService = locator<UserService>();

  Stream<User> get onAuthStateChange =>
      _authService.onAuthStateChange.asyncMap(_fetchUser);

  Future<User> _fetchUser(User user) async {
    if (user == null) return null;
    _currentUser = await _userService.fetchUser(user.id);
    notifyListeners();
    return _currentUser;
  }

  Future<User> fetchCurrentUser() async {
    isLoading = true;
    print("Inside current user fetcher");

    final res = await FirebaseAuth.instance.currentUser();
    if (res == null) {
      _currentUser = null;
      isLoading = false;
      notifyListeners();
      return null;
    }
    final user = await _userService.fetchUser(res.email);
    _currentUser = user;
    isLoading = false;
    notifyListeners();
  }

  User _currentUser;
  bool _isLoading = true;

  User get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  // setCurrentUser() async {
  //   isLoading = true;
  //   final user = await _authService.auth.currentUser();
  //   if (user == null) {
  //     _currentUser = null;
  //     isLoading = false;
  //     return;
  //   }
  //   final User fetchedUser = await _userService.fetchUser(user.email);
  //   _currentUser = fetchedUser;
  //   isLoading = false;
  // }

  Future<User> login() async {
    final res = await _authService.signIn();
    print("inside login");
    _currentUser = res;
    notifyListeners();
    return res;
  }

  Future logout() async {
    await _authService.signOut();
    _currentUser = null;
    notifyListeners();
  }
}
