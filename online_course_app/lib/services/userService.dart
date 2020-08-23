import 'package:online_course_app/models/userModel.dart';
import 'package:online_course_app/services/firebaseBaseAPIService.dart';
import 'dart:async';

class UserService {
  FirebaseBaseAPIService _api = FirebaseBaseAPIService("clients");

  final StreamController<List<User>> _usersStreamController =
      StreamController<List<User>>.broadcast();

  Stream fetchAllUsersStream() {
    _api.ref.snapshots().listen((usersSnapshot) {
      if (usersSnapshot.documents.isNotEmpty) {
        var users = usersSnapshot.documents
            .map(
                (snapshot) => User.fromJson(snapshot.data, snapshot.documentID))
            .where((userItem) => userItem.username != null)
            .toList();
        _usersStreamController.add(users);
      }
    });
    return _usersStreamController.stream;
  }

  Future<void> deleteUser(String id) async {
    await _api.removeDocumentById(id);
  }

  Future<User> fetchUser(String id) async {
    var user = await _api.getDocumentById(id);
    if (!user.exists) return null;
    return User.fromJson(user.data, user.documentID);
  }

  Future<void> updateUser(User user, String id) async {
    await _api.updateDocument(user.toJson(), id);
  }

  Future<User> createUser(User user) async {
    var newUserRef = await _api.addDocument(user.toJson());
    var newUser = await newUserRef.get();
    return User.fromJson(newUser.data, newUser.documentID);
  }

  Future<void> createUserWithCustomId(User user) async {
    await _api.addDocumentWithCustomId(user.toJson(), user.id);
  }


}
