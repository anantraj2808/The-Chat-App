import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_chat_app/helper/authenticate.dart';
import 'package:the_chat_app/helper/constants.dart';
import 'package:the_chat_app/helper/helper_methods.dart';
import 'package:the_chat_app/screens/convo_screen.dart';
import 'package:the_chat_app/screens/search.dart';
import 'package:the_chat_app/services/auth.dart';
import 'package:the_chat_app/services/database.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  HelperMethods _helperMethods = HelperMethods();
  AuthMethods _authMethods = AuthMethods();
  DatabaseMethods _databaseMethods = DatabaseMethods();
  Stream chatRoomsStream;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Widget chatRoomsList(){
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context,index){
            return ChatRoomsTile(snapshot.data.documents[index].data()["chatroomid"].toString().replaceAll("_", "").replaceAll(Constants.myName, ""),
                snapshot.data.documents[index].data()["chatroomid"]);
          },
        ) : Container();
      },
    );
  }

  getUserInfo() async {
    Constants.myName = await _helperMethods.getFullNameSP();
    _databaseMethods.getChatRooms(Constants.myName).then((value){
      setState(() {
        chatRoomsStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Chat App"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              _authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Authenticate()
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                Icons.exit_to_app,color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: chatRoomsList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => Search()
          ));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {

  final String userName;
  final String chatRoomId;
  ChatRoomsTile(this.userName,this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ConvoScreen(userName,chatRoomId)
        ));
      },
      child: Container(
        color: Color(0xff1f1f1f),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(40)),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(userName.substring(0, 1),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w300)),
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300)
                ),
              ],
            ),
        ),
    );
  }
}

