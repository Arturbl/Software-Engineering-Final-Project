import 'dart:async';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final TextEditingController _usernameController = TextEditingController(text: 'arturesmavc@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: '1234567956526');
  final TextEditingController _confirmPasswordController = TextEditingController(text: '1234567956526');
  String _error1 = '';
  bool _loading = false;



  void _validadeUsernameAndPassword() async {
    setState(() {
      _loading = true;
    });
    String username = _usernameController.text;
    String password = _passwordController.text;
    String confirmPassoword = _confirmPasswordController.text;
    if(username.isNotEmpty && password.isNotEmpty) {
      if(password == confirmPassoword) {
        // check username and passoword
        String response = "done";
        if(response == "done") {
          //Navigator.pop(context);
          // change pages
        } else {
          _setError(response);
        }
      } else {
        _setError('Passwords do not match');
      }
    } else {
      _setError('Check for missing fields');
    }
  }


  void _setError(String error) {
    setState(() {
      _error1 = error;
      _loading = false;
    });
    Timer(
        const Duration(seconds: 5),
            (){
          setState(() {
            _error1 = '';
          });
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Safebox', style: TextStyle(
              color: Colors.black
          ),),
          centerTitle: true,
          toolbarHeight: 70.0,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(30),
          child: Center(
              child: SizedBox(
                width:  MediaQuery.of(context).size.width * 0.65,// MediaQuery.of(context).size.width * 0.65,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      TextField(
                        controller: _usernameController,
                        autofocus: true,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Username',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(color: Colors.grey)
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: const Icon(Icons.person, color: Colors.black)
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(color: Colors.grey)
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              prefixIcon: const Icon(Icons.vpn_key, color: Colors.black)
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Confirm password',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(color: Colors.grey)
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              prefixIcon: const Icon(Icons.vpn_key, color: Colors.black)
                          ),
                        ),
                      ),

                      _error1 != null
                          ? Center(
                        child: Text(_error1, style: const TextStyle(color: Colors.red, fontSize: 14)),
                      )
                          : Container(),

                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(16)),
                          ),
                          onPressed: (){
                            _validadeUsernameAndPassword();
                          },
                          child:
                          _loading == false
                              ? const Text('Register', style: TextStyle(color: Colors.white),)
                              : const CircularProgressIndicator(color: Colors.black,),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: GestureDetector(
                          onTap: (){
                            String username = _usernameController.text;
                            Navigator.of(context).pushNamed('/login', arguments: username);
                          },
                          child: const Center(
                            child: Text('Already a member? Sign up', style: TextStyle(
                                color: Colors.blue
                            ),),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )
          ),
        )
    );
  }
}