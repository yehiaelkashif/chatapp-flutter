import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {

  static const String id="RegistrationScreen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String  email;
  String  password;
  final _auth=FirebaseAuth.instance;
  bool  showSpanner=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpanner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ), tag: 'hero',
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //Do something with the user input.
                  email=value;
                },
                  decoration: kTextFieldDecoration.copyWith(hintText: "Enter your  email"),

              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                  password=value;
                },

                decoration: kTextFieldDecoration.copyWith(hintText: "Enter your  password"),
              ),
              SizedBox(
                height: 15.0,
              ),
              RoundedButton(title: 'Register',color:Colors.blueAccent,
                    onPressed: () async{

                      setState(() {
                        showSpanner=true;

                      });
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (newUser != null) {
                    showSpanner=false;
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    showSpanner=false;

                  });
                }catch(e){

                  print(e);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
