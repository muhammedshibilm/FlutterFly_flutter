import 'package:flutter/material.dart';
import 'package:flutter_project/db/service/authentication_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _emaicontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final AuthenticationService _service = AuthenticationService();

  void _login() async {
    String email = _emaicontroller.text;
    String password = _passwordcontroller.text;
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar("Please fill in all fields"),
      );
    } else {
      try {
        await _service.login(email: email, password: password);
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
                  "Welcome,",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.blueAccent),
                ),
                const Text("Glad to see you!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    )),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  child: Column(
                    children: [
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                print("forgot pasword is pressed");
                              },
                              child: const Text(
                                "Forgot Password",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent),
                          onPressed: () {
                            _login();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "Login",
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
                          // Handle Google login
                          print("Google login tapped");
                        },
                        child: _buildLoginButton(
                            iconData: FontAwesomeIcons.google),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle Facebook login
                          print("Facebook login tapped");
                        },
                        child: _buildLoginButton(
                            iconData: FontAwesomeIcons.facebook),
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Dont't have an account?",
                      style: TextStyle(fontSize: 19, color: Colors.blueAccent),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/signuppage',
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: const Text(
                          "Click me",
                          style: TextStyle(
                            fontSize: 19,
                          ),
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
