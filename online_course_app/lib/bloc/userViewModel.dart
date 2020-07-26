import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/userModel.dart';
import 'package:online_course_app/services/userService.dart';

class UserViewModel extends BaseModel {
  UserService _userService = locator<UserService>();

  List<User> _users;

  List<User> get users => _users;

  void listenToUsersStream() {
    _userService.fetchAllUsersStream().listen((data) {
      List<User> newUsers = data;
      if (newUsers != null && newUsers.isNotEmpty) {
        _users = newUsers;
        notifyListeners();
      }
    });
  }

  Future<void> deleteUser(int index) async {
    await _userService.deleteUser(_users[index].id);
  }

  Future<void> updateUser(User user, String id) async {
    await _userService.updateUser(user, id);
  }

  Future<User> createUser(User user) async {
    return await _userService.createUser(user);
  }

  Future<User> fetchUser(String id) async {
    return await _userService.fetchUser(id);
  }
}
