import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'login_screen.dart';
import 'login_screen.dart';
import 'login_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {

  static  const String id ="WelcomeScreen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

      AnimationController animationController;
  Animation animation;
      @override
      void initState() {
        animationController=AnimationController(
          duration: Duration(seconds: 1),vsync: this


        );
        animation=CurvedAnimation(parent: animationController,curve: Curves.decelerate);
        animationController.forward();
        animationController.addListener((){
          print(animationController.value);
          setState(() {

          });
        });
      }
      @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animation.value*95,
                  ), tag: 'logo',
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(title: 'Log In',color: Colors.lightBlueAccent,onPressed: (){
               Navigator.pushNamed(context,LoginScreen.id );

            },),

            RoundedButton(title: 'Register',color:Colors.blueAccent,onPressed: (){
              Navigator.pushNamed(context, RegistrationScreen.id);

            },)

          ],
        ),
      ),
    );
  }
}



