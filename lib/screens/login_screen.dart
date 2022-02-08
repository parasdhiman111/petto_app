import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petto_app/components/rounded_button.dart';
import 'package:petto_app/components/rounded_input_field.dart';
import 'package:petto_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();

  bool _isLoading=false;

  @override
  void initState() {
    super.initState();

  }


  _login(String email,String password) async
  {
    print("$email $password ");
    const Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var response=await http.post(
        Uri.parse(SERVICE_URL+"/api/auth/login"),
        headers: headers,
        body: jsonEncode({"email": email, "password": password}));

    if(response.statusCode==200)
    {
      setState(() {
        _isLoading=false;
      });

      var decoded=jsonDecode(response.body);
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences.setString("token", decoded['token']);
      sharedPreferences.setString("userId", decoded['userId']);
      Navigator.pushNamedAndRemoveUntil(
          context, '/home', ModalRoute.withName('/home'));

    }
    else
    {
      setState(() {
        _isLoading=false;
      });
      print(response.body);
    }
  }



  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _isLoading?Center(child: CircularProgressIndicator(backgroundColor: accentColor,)):Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset("assets/images/darklogo.png",
              //   height: size.height * 0.45,
              // ),
              SizedBox(height: 30.0,),
              Center(child: Text("Petto")),
              SizedBox(height: 10.0,),
              RoundedInputField(icon:Icon(Icons.email),labelText: "Email",textEditingController: _emailController,textInputType: TextInputType.emailAddress, isPasswordField: false,),
              RoundedInputField(icon:Icon(Icons.security),labelText: "Password",textEditingController: _passwordController,isPasswordField: true, textInputType: TextInputType.text,),
              RoundedButton(color: primaryColor,text: "LOGIN",press: attemptLogin),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    FlatButton(onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/signup', ModalRoute.withName('/signup'));  },
                        child: Text("Don't have an account?Sign Up",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  attemptLogin()
  {
    if(_emailController.text!=null && _passwordController.text!=null){
      setState(() {
        _isLoading=true;
      });
      _login(_emailController.text.trim(), _passwordController.text.trim());
    }
  }
}
