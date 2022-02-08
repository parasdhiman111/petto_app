import 'package:flutter/material.dart';

class UploaderScreen extends StatefulWidget {
  const UploaderScreen({Key? key}) : super(key: key);

  @override
  _UploaderScreenState createState() => _UploaderScreenState();
}

class _UploaderScreenState extends State<UploaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Upload"),
        ),
        body:Container(
          child: Center(
            child: Text("Upload Screen"),
          ),
        )
    );
  }
}
