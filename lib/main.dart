import 'package:flutter/material.dart';
import 'package:flutter_project/db/service/authentication_service.dart';
import 'package:flutter_project/db/model/user.dart';
import 'package:flutter_project/pages/login_page.dart';
import 'package:flutter_project/routers/pagerouter.dart';
import 'package:flutter_project/pages/signup_page.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await AuthenticationService().openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Loginpage(),
      //router section
      routes: {
        "/loginpage": (context) => const Loginpage(),
        "/signuppage": (context) => const SignupPage(),
        "/pagerouter": (context) => const Pagerouter(),
      },
    );
  }
}
