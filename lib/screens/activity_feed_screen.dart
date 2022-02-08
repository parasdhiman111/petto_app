import 'package:flutter/material.dart';

class ActivityFeedScreen extends StatefulWidget {
  const ActivityFeedScreen({Key? key}) : super(key: key);

  @override
  _ActivityFeedScreenState createState() => _ActivityFeedScreenState();
}

class _ActivityFeedScreenState extends State<ActivityFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Activity"),
        ),
        body:Container(
          child: Center(
            child: Text("Activity Feed Screen"),
          ),
        )
    );
  }
}
