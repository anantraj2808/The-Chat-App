import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_chat_app/services/auth.dart';
import 'package:the_chat_app/widgets/widgets.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();

  AuthMethods authMethods = AuthMethods();
  signIn(){
    if (_formKey.currentState.validate()){
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailTEC,
                        validator: (value){
                          return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)
                              ? null
                              : "Please enter valid Email ID";
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: textFieldInputDecoration("Email ID"),
                      ),
                      SizedBox(height: 16.0,),
                      TextFormField(
                        controller: passwordTEC,
                        style: TextStyle(color: Colors.white),
                        decoration: textFieldInputDecoration("Password"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0,),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Text("Forgot Password?",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                    ),
                  ),
                ),
                SizedBox(height: 30.0,),
                GestureDetector(
                  child: Container(
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
                    child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 17.0),textAlign: TextAlign.center,),
                  ),
                ),
                SizedBox(height: 20.0,),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text("Sign In with Google",style: TextStyle(color: Colors.black,fontSize: 17.0),textAlign: TextAlign.center,),
                  ),
                ),
                SizedBox (height: 30.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                    GestureDetector(
                      onTap: (){
                        widget.toggleView();
                      },
                        child: Text("Create One",style: TextStyle(color: Colors.white,fontSize: 16.0,decoration: TextDecoration.underline),)
                    ),
                  ],
                ),
                SizedBox(height: 50.0,)
              ],
            ),
          ),
        ),
    );
  }
}
