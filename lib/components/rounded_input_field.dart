import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {

  final String labelText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final Icon icon;
  final bool isPasswordField;

  const RoundedInputField({Key? key,required this.labelText,required this.textEditingController,required this.textInputType,required this.icon,required this.isPasswordField}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20,top: 15),
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
        child: TextFormField(
          controller: textEditingController,
          obscureText: isPasswordField!=null?isPasswordField:false,
          keyboardType: textInputType!=null?textInputType:TextInputType.text,
          decoration: InputDecoration(
              icon: icon!=null?icon:null,
              border: InputBorder.none,
              labelText: labelText
          ),
        ),
      ),
    );
  }
}
