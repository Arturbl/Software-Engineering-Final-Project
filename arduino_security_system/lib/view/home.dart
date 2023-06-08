import 'package:arduino_security_system/view/homeScreens/historyScreen.dart';
import 'package:arduino_security_system/view/homeScreens/home.dart';
import 'package:arduino_security_system/view/homeScreens/profileScreen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int index = 0; // keep track of current displayed page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Safebox', style: TextStyle(
            color: Colors.black
        ),),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: index,
        children: [
          HistoryScreen(),
          HomeScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar:  BottomNavigationBar(
        currentIndex: index,
        onTap: (int newIndex) {
          setState(() => index = newIndex);
        },
        items: const [
          
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: "History",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile"
          ),
          
        ],
      ),
    );
  }
}
