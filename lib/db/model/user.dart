import 'package:hive_flutter/adapters.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  late String username;
  @HiveField(1)
  late String email;
  @HiveField(2)
  late String password;

  User({required this.username, required this.email, required this.password});
}
