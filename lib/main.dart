import 'package:flutter/material.dart';
import 'package:petto_app/screens/home_screen.dart';
import 'package:petto_app/screens/landing_screen.dart';
import 'package:petto_app/screens/login_screen.dart';
import 'package:petto_app/screens/my_pets_screen.dart';
import 'package:petto_app/screens/signup_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      routes: {
        '/': (context) => Landing(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        "/signup" : (context) => SignUpScreen(),
        "/mypets":  (context) => MyPetsScreen()
      },
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
    );
  }
}
