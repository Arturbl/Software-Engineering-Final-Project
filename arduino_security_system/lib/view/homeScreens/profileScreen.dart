import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = 'John Doe';
  String password = '********';
  bool isAdmin = false;
  bool isEditingUsername = false;
  bool isChangingPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // TODO: Implement profile picture editing logic
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey,
                    backgroundImage:  null//AssetImage('assets/profile_picture.png'), // Placeholder image
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Implement profile picture editing logic
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Username:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
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
            Text(
              'Password:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
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
