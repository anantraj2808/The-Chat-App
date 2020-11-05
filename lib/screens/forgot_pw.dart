import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_chat_app/services/auth.dart';
import 'package:the_chat_app/widgets/widgets.dart';

class ForgotPwScreen extends StatefulWidget {
  @override
  _ForgotPwScreenState createState() => _ForgotPwScreenState();
}

class _ForgotPwScreenState extends State<ForgotPwScreen> {

  TextEditingController emailTEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthMethods _authMethods = AuthMethods();

  sendResetMail(){
    if(_formKey.currentState.validate()){
      _authMethods.resetPassword(emailTEC.text);
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("Reset Email has been sent!"),action: SnackBarAction(label: "OK",onPressed: (){
          Navigator.pop(context);
        },),)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        centerTitle: true,
      ),
      body: SafeArea(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
             child: Container(
               margin: EdgeInsets.symmetric(horizontal: 10.0),
               child: TextFormField(
                  controller: emailTEC,
                  validator: (value){
                    return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)
                        ? null
                        : "Please enter valid Email ID";
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: textFieldInputDecoration("Registered Email ID"),
                ),
             ),
            ),
            SizedBox(height: 30.0,),
            GestureDetector(
              onTap: (){

              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xff007EF4),
                        const Color(0xff2A75BC)
                      ],
                    )
                ),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text("Send Reset Email",style: TextStyle(color: Colors.white,fontSize: 17.0),textAlign: TextAlign.center,),
              ),
            ),
          ],
        ),
      ),),
    );
  }
}
