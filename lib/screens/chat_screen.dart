import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
FirebaseUser logedInUser;
class ChatScreen extends StatefulWidget {

    static const String id="ChatScreen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _auth=FirebaseAuth.instance;
  final _firestore=Firestore.instance;
  final textEditingController =TextEditingController();

   String message;

  void getCurrentUSer()async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        logedInUser = user;
        print (logedInUser.email);
      }

    }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUSer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                 _auth.signOut();
                 Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('massages').snapshots(),
                // ignore: missing_return
                builder: (context,snapshot){
                  if (!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(

                          backgroundColor: Colors.lightBlueAccent,
                        ),
                      );

                  }
                    final messages=snapshot.data.documents.reversed;
                     List<MessageBubble> messageWidgets =[];
                     for (var message in messages){
                        final messagetext=message.data['text'];
                        final messageSender=message.data['sender'];
                        final curentUser=  logedInUser.email;
                        final messageWidget= MessageBubble(messagetext,messageSender,curentUser==messageSender);

                        messageWidgets.add(messageWidget);
                     }
                     return Expanded(
                       child: ListView(

                         reverse:true,
                         padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                         children:messageWidgets,),
                     );

                },
              ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      onChanged: (value) {
                        //Do something with the user input.
                        message=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.

                      textEditingController.clear();
                      _firestore.collection("massages").add({
                        'text':message,
                        'sender':logedInUser.email
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {

  final String message;
  final  bool isMe;
  final  String sender;
  MessageBubble(this.message, this.sender, this.isMe);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:  isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: <Widget>[

          Text(
            sender
            ,style: TextStyle(
            fontSize: 12.0
                ,color: Colors.black45
          ),
          ),
          Material(
              borderRadius: isMe?BorderRadius.only(topLeft: Radius.circular(30.0),bottomLeft:Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0) ):BorderRadius.only(topLeft: Radius.circular(30.0),bottomLeft:Radius.circular(30.0),topRight:Radius.circular(30.0) )
              ,
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
                child: Text('$message'
                  ,style: TextStyle(
                      fontSize: 15.00
                      , color: isMe ?Colors.white:Colors.black45
                  ),

                ),
              ),

              color: isMe ?Colors.lightBlue:Colors.white

          ),

        ],

      ),
    );
  }
}


