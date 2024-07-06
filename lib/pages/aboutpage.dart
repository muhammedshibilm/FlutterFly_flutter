import 'package:flutter/material.dart';

class Aboutpage extends StatelessWidget {
  const Aboutpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About page",
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "About page",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
