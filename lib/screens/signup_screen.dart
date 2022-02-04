import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petto_app/components/rounded_button.dart';
import 'package:petto_app/components/rounded_input_field.dart';
import 'package:petto_app/constants.dart';
import 'package:petto_app/models/signup_request.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isLoading=false;
  bool _allGood=true;

  final _firstNameController=TextEditingController();
  final _lastNameController=TextEditingController();
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _confirmPasswordController=TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List<String> genderList=['Male','Female'];
  String dropDownValue='Male';

  signUp(SignUpRequest request) async
  {
    const Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };


    var body={
      "firstName":request.firstName,
      "lastName":request.lastName,
      "email":request.email,
      "gender":request.gender,
      "password":request.password
    };

    var response =await http.post(Uri.parse(SERVICE_URL+"/api/auth/signup"),headers: headers,body:jsonEncode(body));

    if(response.statusCode==200)
    {
      setState(() {
        _isLoading=false;
      });

      showInSnackBar("User Registered Successfully",seconds: 3);
      _emailController.clear();
      _firstNameController.clear();
      _lastNameController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    }
    else
    {
      setState(() {
        _isLoading=true;
      });
      print("Bad Luck");
      showInSnackBar("Some error occured, Please try Again");

    }
  }


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColor,
      body: _isLoading?Center(child: CircularProgressIndicator(backgroundColor: accentColor,)):Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30.0,),
              Center(child: Text("Petto")),
              RoundedInputField(icon:Icon(Icons.person),labelText: "First Name", textEditingController: _firstNameController, textInputType: TextInputType.text, isPasswordField: false),
              RoundedInputField(icon:Icon(Icons.supervisor_account_sharp),labelText: "Last Name", textEditingController: _lastNameController, textInputType: TextInputType.text, isPasswordField: false),
              RoundedInputField(icon:Icon(Icons.email),labelText: "Email", textEditingController: _emailController,textInputType: TextInputType.emailAddress, isPasswordField: false),
              _dropDownForGender(size),
              RoundedInputField(icon:Icon(Icons.security),labelText: "Password", textEditingController: _passwordController,textInputType: TextInputType.text, isPasswordField: true),
              RoundedInputField(icon:Icon(Icons.security),labelText: "Confirm Password", textEditingController: _confirmPasswordController,textInputType: TextInputType.text, isPasswordField: true),
              RoundedButton(text: "SIGNUP",press: (){
                Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp=new RegExp(pattern.toString());
                if(_emailController.text.isEmpty || !regExp.hasMatch(_emailController.text))
                {
                  showInSnackBar("Please enter a valid email");
                  setState(() {
                    _allGood=false;
                  });
                }
                else if(_firstNameController.text.isEmpty)
                {
                  showInSnackBar("First name must not be empty");
                  setState(() {
                    _allGood=false;
                  });
                }
                else if(_lastNameController.text.isEmpty)
                {
                  showInSnackBar("Last name must not be empty");
                  setState(() {
                    _allGood=false;
                  });
                }
                else if(_passwordController.text.isEmpty || _passwordController.text.length<6)
                {
                  showInSnackBar("Password must not be less than 6 characters");
                  setState(() {
                    _allGood=false;
                  });
                }
                else if(_passwordController.text!= _confirmPasswordController.text)
                {
                  showInSnackBar("Password does not match");
                  setState(() {
                    _allGood=false;
                  });
                }

                if(_allGood)
                {
                  SignUpRequest request =SignUpRequest(
                      _firstNameController.text.trim(),
                      _lastNameController.text.trim(),
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                      dropDownValue);

                  setState(() {
                    _isLoading=true;
                  });
                  signUp(request);
                }
                setState(() {
                  _allGood=true;
                });

                // Navigator.pushNamedAndRemoveUntil(
                //     context, '/login', ModalRoute.withName('/login'));
                //
                //


              },color: accentColor,),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    FlatButton(onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', ModalRoute.withName('/login'));
                    },
                        child: Text("Aready have an account?Login",
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

  void showInSnackBar(String value, {int seconds = 1}) {
    _scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text(value),duration: Duration(seconds: seconds),));
  }


  Widget _dropDownForGender(Size size)
  {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(10.0),
      ),
      width: size.width,
      height: 60,
      margin: EdgeInsets.only(left: 20,right: 20,top: 10),
      padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
      alignment: Alignment.center,

      child: DropdownButton<String>(
        isExpanded: true,
        icon: Icon(Icons.arrow_circle_down_rounded),
        value: dropDownValue,
        hint:Text(
          "Please choose your gender",
        ),
        onChanged: (String? newValue){
          if(newValue!=null)
            {
              setState(() {
                dropDownValue=newValue;
              });

            }
        },
        items:genderList
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }


}
