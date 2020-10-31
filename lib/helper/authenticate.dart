import 'package:flutter/cupertino.dart';
import 'package:the_chat_app/screens/sign_in.dart';
import 'package:the_chat_app/screens/sign_up.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool isSignIn = true;

  void toggleView(){
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSignIn ? SignIn(toggleView) : SignUp(toggleView);
  }
}
