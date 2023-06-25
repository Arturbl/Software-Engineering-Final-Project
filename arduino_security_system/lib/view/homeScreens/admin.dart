import 'package:arduino_security_system/controller/user/userController.dart';
import 'package:arduino_security_system/model/User.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../model/UserApiResponse.dart';

class AdminPage extends StatefulWidget {
  final User currentUser;
  final List<UserApiResponse>? users;
  const AdminPage({Key? key, required this.users, required this.currentUser}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String _error = "";
  final TextEditingController _passwordController = TextEditingController();
  String selectedUser = '';

  void _openModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _passwordController,
                onChanged: null,
                decoration: const InputDecoration(
                  labelText: 'Update password',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  String response = await UserController.updateUserPassword(selectedUser, _passwordController.text, widget.currentUser.token);
                  if (response == "done") {
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      msg: "Password updated for $selectedUser",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                    _passwordController.text = "";
                  } else {
                    // setState(() {
                    //   // Add an error message to display in the bottom sheet
                    //   errorMessage = "Failed to update password. Please try again.";
                    // });
                  }
                },
                child: const Text('Save'),
              ),

              Text(_error, style: const TextStyle(
                color: Colors.red
              ))

            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.users?.length,
        itemBuilder: (context, index) {

          final user = widget.users![index];

          return ListTile(
            title: Text(user.username ?? " "),
            onTap: () {
              setState(() {
                selectedUser = user.username!;
              });
              _openModalBottomSheet(context);
            },
          );
        },
      ),
    );
  }
}
