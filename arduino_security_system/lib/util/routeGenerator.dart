import 'package:arduino_security_system/view/createAccount.dart';
import 'package:arduino_security_system/view/home.dart';
import 'package:arduino_security_system/view/login.dart';
import 'package:flutter/material.dart';

class RouteGenerator{

  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch(settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (context) => Login());
      case '/createAccount':
        return MaterialPageRoute(builder: (context) => CreateAccount());
      case '/home':
        return MaterialPageRoute(builder: (context) => const Home());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context){
      return Scaffold(
          appBar: AppBar(
            title: const Text('Route not found.'),
          ),
          body: const Center(
              child: Text("Route not found", style: TextStyle(color: Colors.red))
          )
      );
    });
  }

}