import 'package:flutter/material.dart';
import 'package:flutter_project/pages/login_page.dart';
import 'package:flutter_project/routers/pagerouter.dart';
import 'package:flutter_project/pages/signup_page.dart';

void main() {
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
      routes: {
        "/loginpage": (context) => const Loginpage(),
        "/signuppage": (context) => const SignupPage(),
        "/pagerouter": (context) => const Pagerouter(),
      },
    );
  }
}
