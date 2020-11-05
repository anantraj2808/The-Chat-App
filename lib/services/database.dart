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

  getUserByEmail(String email) async{
    return await FirebaseFirestore.instance.collection("Users").where(
        "email" , isEqualTo: email
    ).get();
  }

  createChatRoom(String chatRoomId,chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).set(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }

  addMessage(String chatRoomId, messageMap){
    FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).collection("chats").add(messageMap);
  }

  getMessages(chatRoomId) async {
    return FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).collection("chats").orderBy("time").snapshots();
  }

  getChatRooms(String username) async {
    return FirebaseFirestore.instance.collection("ChatRoom").where("users", arrayContains: username).snapshots();
  }
}