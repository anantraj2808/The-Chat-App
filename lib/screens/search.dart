import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_chat_app/helper/constants.dart';
import 'package:the_chat_app/helper/helper_methods.dart';
import 'package:the_chat_app/models/user.dart';
import 'package:the_chat_app/screens/convo_screen.dart';
import 'package:the_chat_app/services/database.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController _searchController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();
  HelperMethods _helperMethods = HelperMethods();
  QuerySnapshot querySnapshot;

  void initiateSearch(){
    databaseMethods.getUserByUsername(_searchController.text).then((val){
      setState(() {
        querySnapshot = val;
      });
    });
  }

  createChatRoomAndStartConversation(String fullName){
    List<String> users = [fullName, Constants.myName];
    String chatRoomId = getChatRoomId(fullName , Constants.myName);
    Map<String,dynamic> chatRoomMap = {
      "users" : users,
      "chatroomid" : chatRoomId
    };
    databaseMethods.createChatRoom(chatRoomId,chatRoomMap);
//    print("My Name______________${Constants.myName}");
//    print("Your Name____________$fullName");
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => ConvoScreen(fullName,chatRoomId)
    ));
  }

  String getChatRoomId(String a ,b){
    return (a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)) ? "$b\_$a" : "$a\_$b";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search for Friends"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12.0,bottom: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.circular(24.0)
                  ),
                  child: TextFormField(
                    onChanged: (String text){
                    },
                    controller: _searchController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        hintText: "Search for a person",
                        contentPadding: const EdgeInsets.only(left: 24.0),
                        border: InputBorder.none
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search,color: Colors.white,),
                onPressed: (){
                  initiateSearch();
                },
              )
            ],
          ),
        ),
      ),
      body: Container(
        child: _searchController.text.isNotEmpty && querySnapshot == null ? Container(child: Center(
          child: CircularProgressIndicator(),
        ),) : querySnapshot != null ? ListView.builder(
          shrinkWrap: true,
          itemCount: querySnapshot.docs.length,
          itemBuilder: (context,index){
            return Container(
              padding: EdgeInsets.only(right: 20.0,top: 16.0,bottom: 16.0,left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(querySnapshot.docs[index].data()["fullName"],style: TextStyle(color: Colors.white,fontSize: 16.0),),
                      SizedBox(height: 5.0,),
                      Text(querySnapshot.docs[index].data()["email"],style: TextStyle(color: Colors.white,fontSize: 15.0),)
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      if (querySnapshot.docs[index].data()["fullName"] == Constants.myName){
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Soliloquy is important but we don't do that here!"),));
                      }
                      else{
                        createChatRoomAndStartConversation(querySnapshot.docs[index].data()["fullName"]);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24.0)
                      ),
                      child: GestureDetector(
                        child: Text("Message",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ) : Container(),
      ),
    );
  }
}
