import 'package:flutter/material.dart';
import 'package:arduino_security_system/model/User.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  ProfileScreen({required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  late String password;
  late bool isAdmin;
  bool isEditingUsername = false;
  bool isChangingPassword = false;

  @override
  void initState() {
    super.initState();
    username = widget.user.username ?? ''; // Initialize username from the User object
    password = '*********'; // Initialize password from the User object
    isAdmin = widget.user.admin ?? false; // Initialize isAdmin from the User object
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Username:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(width: 8.0),
                isEditingUsername
                    ? TextFormField(
                  initialValue: username,
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                )
                    : Text(
                  username,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: isAdmin,
                  onChanged: (value) {
                    setState(() {
                      isAdmin = value!;
                    });
                  },
                ),
                Text(
                  'Admin',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Password:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(width: 8.0),
                isChangingPassword
                    ? TextFormField(
                  initialValue: password,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                )
                    : Text(
                  password,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isEditingUsername || isChangingPassword) {
                    isEditingUsername = false;
                    isChangingPassword = false;
                  } else {
                    isEditingUsername = true;
                    isChangingPassword = true;
                  }
                });
              },
              child: Text(isEditingUsername || isChangingPassword ? 'Save' : 'Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
