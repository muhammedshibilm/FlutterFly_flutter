import 'package:flutter/material.dart';
import 'package:flutter_project/pages/aboutpage.dart';
import 'package:flutter_project/pages/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Pagerouter extends StatefulWidget {
  const Pagerouter({super.key});

  @override
  State<Pagerouter> createState() => _PagerouterState();
}

class _PagerouterState extends State<Pagerouter> {
  int _selectedIndex = 0;

  //update selected index
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print(_selectedIndex);
  }

  final List _pages = [HomePage(), Aboutpage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black,
        onTap: (value) => _navigateBottomBar(value),
        items: const [
          //home page
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          //Aboutpage
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.circleInfo), label: "About")
        ],
      ),
    );
  }
}
