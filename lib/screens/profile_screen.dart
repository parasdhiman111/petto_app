import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petto_app/constants.dart';
import 'package:petto_app/models/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late SharedPreferences sharedPreferences;
   UserDetails _userDetails=UserDetails("", "", "", "");
   bool isLoading=false;

  @override
  void initState() {
    super.initState();

    getUserData();
  }

  getUserData() async {

    setState(() {
      isLoading=true;
    });
    String authToken="Bearer ";
    sharedPreferences =await SharedPreferences.getInstance();
    String? token=sharedPreferences.getString("token");

    if(token!=null)
      {
        authToken=authToken+token;
      }

     Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization':authToken
    };

    var response=await http.get(
        Uri.parse(SERVICE_URL+"/api/auth/user"),
        headers: headers);

    if(response.statusCode==200) {
      setState(() {
        _userDetails=UserDetails.fromJson(jsonDecode(response.body));
        isLoading=false;
      });

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile Page"),
          actions: [
            IconButton(onPressed: (){
              logout();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/', ModalRoute.withName('/'));
            }, icon: Icon(Icons.exit_to_app))
          ],
        ),
        body:isLoading?Center(child: CircularProgressIndicator()):ListView(
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.grey,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                buildStatColumn("posts", 0),
                                buildStatColumn("followers", 0),
                                buildStatColumn("following",0),
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  buildFollowButton(title: "My Pets",function: addNewPet)
                                ]),


                          ],
                        ),

                      ),

                    ],
                  ),
                  Text("${_userDetails.firstName} ${_userDetails.lastName}"),
                  Text("${_userDetails.email}"),
                ],

              ),
            )
          ],
        )
    );
  }


  addNewPet()
  {
    Navigator.pushNamed(
        context, '/mypets');
  }


  Column buildStatColumn(String label, int number) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          number.toString(),
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Container(
            margin: const EdgeInsets.only(top: 4.0),
            child: Text(
              label,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400),
            ))
      ],
    );
  }

  Container buildFollowButton(
      {required String title,
        required VoidCallback function}) {
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      child: FlatButton(
          onPressed: function,
          child: Container(
            decoration: BoxDecoration(
                color: primaryColor,
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(5.0)),
            alignment: Alignment.center,
            child: Text(title,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            width: 200.0,
            height: 40.0,
          )),
    );
  }


  logout()async
  {
    sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
