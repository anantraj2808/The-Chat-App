import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
    title: Text("The Chat App"),
    centerTitle: true,
  );
}

InputDecoration textFieldInputDecoration(String hint){
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      color: Colors.white54
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white)
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white)
    )
  );
}