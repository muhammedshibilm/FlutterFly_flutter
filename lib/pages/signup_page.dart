import 'package:flutter/material.dart';
import 'package:flutter_project/db/service/authentication_service.dart';
import 'package:flutter_project/db/model/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emaicontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final AuthenticationService _service = AuthenticationService();

  void _signup() async {
    String email = _emaicontroller.text;
    String password = _passwordcontroller.text;
    String username = _username.text;
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar("Please fill in all fields"),
      );
    } else {
      try {
        User user = User(username: username, email: email, password: password);
        await _service.singUP(user);
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/pagerouter',
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(e.toString()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Create Account",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.blueAccent),
                ),
                const Text("to get started now!",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _username,
                        hint: "Username",
                        icon: FontAwesomeIcons.user,
                        obsecure: false,
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: _emaicontroller,
                        hint: "Email Address",
                        icon: Icons.email_outlined,
                        obsecure: false,
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: _passwordcontroller,
                        hint: "Password",
                        icon: Icons.password_outlined,
                        obsecure: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent),
                          onPressed: () {
                            _signup();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Or",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle Google
                          print("Google  tapped");
                        },
                        child: _buildLoginButton(
                            iconData: FontAwesomeIcons.google),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle Facebook
                          print("Facebook  tapped");
                        },
                        child: _buildLoginButton(
                            iconData: FontAwesomeIcons.facebook),
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 19, color: Colors.blueAccent),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/loginpage',
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: const Text(
                          "Click me",
                          style: TextStyle(fontSize: 19),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

// Custom text field
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final bool obsecure;
  final TextInputType textInputType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hint,
    required this.obsecure,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecure,
      keyboardType: textInputType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 20),
        ),
      ),
    );
  }
}

// Custom Snackbar function
SnackBar customSnackBar(String message) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(
          color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 15),
    ),
    backgroundColor: Colors.white,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.all(10),
  );
}

//social media icons
Widget _buildLoginButton({required IconData iconData}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 40,
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}
