import 'package:arduino_security_system/model/User.dart';
import 'package:arduino_security_system/view/homeScreens/admin.dart';
import 'package:arduino_security_system/view/homeScreens/historyScreen.dart';
import 'package:arduino_security_system/view/homeScreens/home.dart';
import 'package:arduino_security_system/view/homeScreens/profileScreen.dart';
import 'package:flutter/material.dart';

import '../controller/user/userController.dart';
import '../model/UserApiResponse.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  late User user;

  List<UserApiResponse>? users = [];

  Future<void> fetchUsers() async {
    final userList = await UserController.getAllUsers(user.token);
    setState(() {
      users = userList;
    });
  }

  @override
  void initState() {
    super.initState();
    user = User.instance;
    print(user);
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Safebox',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: index,
        children: [
          HistoryScreen(user: user),
          HomeScreen(user: user),
          ProfileScreen(user: user),
          if(user.admin == true) AdminPage(users: users, currentUser: user), // Added AdminPage as a child
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int newIndex) {
          setState(() => index = newIndex);
        },
        showSelectedLabels: false, // Hide the labels
        showUnselectedLabels: false, // Hide the labels
        selectedItemColor: Colors.black, // Set the selected icon color
        unselectedItemColor: Colors.black.withOpacity(0.5), // Set the unselected icon color
        items:  [
          const BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: "History",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          if (user.admin == true)
              const BottomNavigationBarItem(
                icon: Icon(Icons.account_tree),
                label: "Admin",),
        ],
      ),
    );
  }
}
