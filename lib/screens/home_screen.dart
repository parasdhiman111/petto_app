import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
          logout();
          Navigator.pushNamedAndRemoveUntil(
              context, '/', ModalRoute.withName('/'));
          }, icon: Icon(Icons.exit_to_app))
        ],
      ),
        body:Container(
      child: Center(
        child: Text("Welcome to Petto"),
      ),
    )
    );
  }

  logout()async
  {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
