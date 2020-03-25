import 'package:app_zooq/Core/constants/app_contstant.dart';
import 'package:app_zooq/UI/views/addproduct.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  void initState() {


    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), (){
     return  FirebaseAuth.instance.currentUser().then((currentUser)
        {
          if (currentUser == null) {
            Navigator.of(context).pushReplacementNamed(RoutePaths.Login);
          }
          else
            {
              Navigator.of(context).pushReplacementNamed(RoutePaths.NavBar);
              }

        }



          );
  });
}
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        //color:Theme.of(context).accentColor,
        image: DecorationImage(image: AssetImage("images/logobg.jpg"),fit: BoxFit.cover)


      ),
      child: Center(
        child: Image(image: AssetImage('images/logo-zooq.png'),width: 130,),
      ),
    );
  }
}
