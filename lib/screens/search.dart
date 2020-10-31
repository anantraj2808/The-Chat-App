import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_chat_app/services/database.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController _searchController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();
  QuerySnapshot querySnapshot;

  void initiateSearch(){
    databaseMethods.getUserByUsername(_searchController.text).then((val){
      setState(() {
        querySnapshot = val;
      });
    });
  }

  createChatRoomAndStartConversation(){

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
                    keyboardType: TextInputType.name,
                    onChanged: (String text){

                    },
                    controller: _searchController,
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
        child: querySnapshot != null ? ListView.builder(
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
                      Text(querySnapshot.docs[index].data()["email"],style: TextStyle(color: Colors.white,fontSize: 16.0),)
                    ],
                  ),
                  GestureDetector(
                    onTap: createChatRoomAndStartConversation(),
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
