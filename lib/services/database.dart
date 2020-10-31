import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  uploadData(userInfoMap){
    FirebaseFirestore.instance.collection("Users").add(userInfoMap);
  }

  getUserByUsername(String fullName) async{
    return await FirebaseFirestore.instance.collection("Users").where(
      "fullName" , isEqualTo: fullName
    ).get();
  }
}