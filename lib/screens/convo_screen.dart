import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_chat_app/helper/constants.dart';
import 'package:the_chat_app/services/database.dart';
import 'package:the_chat_app/widgets/widgets.dart';

class ConvoScreen extends StatefulWidget {

  final String talkingTo,chatRoomId;

  ConvoScreen(this.talkingTo,this.chatRoomId);

  @override
  _ConvoScreenState createState() => _ConvoScreenState();
}

class _ConvoScreenState extends State<ConvoScreen> {

  TextEditingController messageEditingController = TextEditingController();
  DatabaseMethods _databaseMethods = DatabaseMethods();
  Stream chatMessagesStream;

  Widget chatMessageList(){
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context,index){
            return MessageTile(snapshot.data.documents[index].data()["message"],snapshot.data.documents[index].data()["sentBy"] == Constants.myName);
          },
        ) : Container();
      },
    );
  }

  sendMessage(){
    if (messageEditingController.text.isNotEmpty){
      Map<String,dynamic> messageMap = {
        "message" : messageEditingController.text,
        "sentBy" : Constants.myName,
        "time" : DateTime.now().millisecondsSinceEpoch
      };
      _databaseMethods.addMessage(widget.chatRoomId, messageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  void initState() {
    _databaseMethods.getMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessagesStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Chat App"),
        centerTitle: true,
//        bottom: PreferredSize(
//          preferredSize: Size.fromHeight(50.0),
//          child: Container(
//            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
//            color: Colors.black,
//            child: Align(
//              alignment: Alignment.centerLeft,
//              child: Text(
//                widget.talkingTo,style: TextStyle(color: Colors.white,fontSize: 16.0),
//              ),
//            ),
//          ),
//        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height-190.0,
                    child: chatMessageList()),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 100.0,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    color: Colors.grey,
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                              style: TextStyle(color: Colors.white,fontSize: 18.0),
                              controller: messageEditingController,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                  hintText: "Message ${widget.talkingTo} ...",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none
                              ),
                            )),
                        SizedBox(width: 16,),
                        GestureDetector(
                          onTap: () {
                            sendMessage();
                          },
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        const Color(0x36FFFFFF),
                                        const Color(0x0FFFFFFF)
                                      ],
                                      begin: FractionalOffset.topLeft,
                                      end: FractionalOffset.bottomRight
                                  ),
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Center(child: Icon(Icons.send,color: Colors.white,size: 25.0,))),
                        ),
                      ],
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {

  final String messageText;
  final bool isSentByMe;
  MessageTile(this.messageText,this.isSentByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: isSentByMe ? 0 : 24,
          right: isSentByMe ? 24 : 0),
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: isSentByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: isSentByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: isSentByMe ? [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
              ]
                  : [
                const Color(0x1AFFFFFF),
                const Color(0x1AFFFFFF)
              ],
            )
        ),
        child: Text(messageText,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}

