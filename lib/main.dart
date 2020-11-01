import 'package:flutter/material.dart';
import 'package:the_chat_app/helper/authenticate.dart';
import 'package:the_chat_app/helper/helper_methods.dart';
import 'package:the_chat_app/screens/chat_room.dart';
import 'package:the_chat_app/screens/sign_in.dart';
import 'package:the_chat_app/screens/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isUserLoggedIn;
  HelperMethods _helperMethods = HelperMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoggedInInfo();
  }

  getLoggedInInfo() async {
    await _helperMethods.getUserLoggedInStatusSP().then((value){
      setState(() {
        isUserLoggedIn  = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Chat App',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff1f1f1f),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isUserLoggedIn != null ? isUserLoggedIn ? ChatRoom() : Authenticate
          :
          Container(
            child: Center(
              child: Authenticate(),
            ),
          )
    );
  }
}

