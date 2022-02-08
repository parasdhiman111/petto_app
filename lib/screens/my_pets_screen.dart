import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petto_app/constants.dart';
import 'package:petto_app/models/add_pet_request.dart';
import 'package:petto_app/models/pet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class MyPetsScreen extends StatefulWidget {

  const MyPetsScreen({Key? key}) : super(key: key);

  @override
  _MyPetsScreenState createState() => _MyPetsScreenState();
}

class _MyPetsScreenState extends State<MyPetsScreen> {
  late SharedPreferences sharedPreferences;
  List<Pet> pets=[];
  final List<String> breedList=['LABRADOR','PUG','GERMAN_SHEPHARD'];
  String selectedBreed= 'LABRADOR';
  final List<String> petCategoryList=['DOG','CAT','BIRD','RABBIT','FISH'];
  String selectedPetCategory= 'DOG';
  final List<String> genderList=['MALE','FEMALE'];
  String selectedGender= 'MALE';
  bool isLoading=false;
  final _nameController=TextEditingController();
  final _bioController=TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    getAllPets();

  }


  getAllPets() async {
    setState(() {
      isLoading=true;
    });
    String authToken="Bearer ";
    String currentUserId="";
    sharedPreferences =await SharedPreferences.getInstance();
    String? token=sharedPreferences.getString("token");
    String? userId=sharedPreferences.getString("userId");
    if(token!=null)
    {
      authToken=authToken+token;
    }

    if(userId!=null)
    {
      currentUserId=userId;
    }


    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization':authToken
    };

    var response=await http.get(
        Uri.parse(SERVICE_URL+"/api/data/pet/user/$currentUserId"),
        headers: headers);

    if(response.statusCode==200) {
      Iterable l = json.decode(response.body);
      List<Pet> petList = List<Pet>.from(l.map((model)=> Pet.fromJson(model)));
      setState(() {
        pets = petList;
        print(pets.length);
        isLoading=false;
      });

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("My Pets"),
      ),
      body:isLoading?Center(
        child: CircularProgressIndicator(

        ),
      ): pets.length==0?Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Center(child: Text("No Pets Added")),
            OutlinedButton(onPressed: (){
              showDialogBox();
            }, child: Text("Add New Pet"))
          ],
        ),
      ):ListView.builder(
          itemCount: pets.length,
        itemBuilder: (BuildContext context,int index){
            return ListTile(
              leading: Image.network(pets[index].profileUrl),
              trailing: Text(pets[index].gender),
              title: Text(pets[index].name),
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Text("Add"),
        onPressed: () {
          showDialogBox();
        },

      ),
    );
  }



  showDialogBox()
  {
    return  showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
            builder:(context,setState){
              return  AlertDialog(
                scrollable: true,
                title: Text("Add New Pet"),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                              labelText: 'Name'
                          ),
                        ),
                        Container(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: selectedPetCategory,
                              hint:const Text(
                                "Please choose your pet Category",
                              ),
                              onChanged: (String? newValue){
                                if(newValue!=null)
                                {
                                  setState(() {
                                    selectedPetCategory=newValue;
                                    print(selectedPetCategory);
                                  });

                                }
                              },
                              items:petCategoryList
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          value: selectedBreed,
                          hint:const Text(
                            "Please choose your pet breed",
                          ),
                          onChanged: (String? newValue){
                            if(newValue!=null)
                            {
                              setState(() {
                                selectedBreed=newValue;
                                print(selectedBreed);
                              });

                            }
                          },
                          items:breedList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          value: selectedGender,
                          hint:const Text(
                            "Please choose your pet gender",
                          ),
                          onChanged: (String? newValue){
                            if(newValue!=null)
                            {
                              setState(() {
                                selectedGender=newValue;
                                print(selectedGender);
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

                        TextFormField(
                          controller: _bioController,
                          decoration: const InputDecoration(
                              labelText: 'Bio'
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                actions: [
                  OutlinedButton(onPressed: (){

                    if(_nameController.text.isEmpty || _bioController.text.isEmpty)
                      {
                        showInSnackBar("Please fill all details");
                      }
                    else
                      {
                        addNewPet(_nameController.text,_bioController.text);
                        Navigator.of(context, rootNavigator: true).pop('dialog');
                      }



                  }, child: Text("Add"))
                ],
              );

            },
          );
        }
    );
  }

  void showInSnackBar(String value, {int seconds = 1}) {
    _scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text(value),duration: Duration(seconds: seconds),));
  }

  addNewPet(String name,String bio) async
  {
    setState(() {
      isLoading=true;
    });
    AddPetRequest addPetRequest=AddPetRequest(name, selectedPetCategory, selectedBreed, selectedGender, bio);
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

    var response =await http.post(Uri.parse(SERVICE_URL+"/api/data/pet"),
        headers: headers,body:jsonEncode(addPetRequest.toJson()));

    if(response.statusCode==201)
      {
        setState(() {
          pets.add(Pet.fromJson(jsonDecode(response.body)));
          isLoading=false;
        });
      }



  }


}
