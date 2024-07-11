import 'package:flutter_project/db/model/user.dart';
import 'package:hive_flutter/adapters.dart';

class AuthenticationService {
  Box<User>? _users;

  Future<void> openBox() async {
    if (!Hive.isBoxOpen('users')) {
      _users = await Hive.openBox<User>('users');
    } else {
      _users = Hive.box('users');
    }
  }

  Future<void> closeBox() async {
    await _users?.close();
  }

  Future<void> singUP(User user) async {
    await openBox();
    if (await usernameExist(user.username)) {
      throw Exception("Username already exists");
    } else if (_users!.containsKey(user.email)) {
      throw Exception("Email already exists");
    } else {
      await _users!.put(user.email, user);
      await closeBox();
    }
  }

  Future<void> login({required String email, required String password}) async {
    await openBox();
    if (_users!.containsKey(email)) {
      var storedPassword = _users!.get(email);
      if (storedPassword!.password == password) {
        await closeBox();
        return null;
      } else {
        throw Exception("Password is incorrect");
      }
    } else {
      throw Exception("User Does not exisit");
    }
  }

  Future<bool> usernameExist(String username) async {
    await openBox();
    return _users!.values.any((user) => user.username == username);
  }
}
