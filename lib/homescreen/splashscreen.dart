


import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watersupplyadmin/homescreen/logindcreen.dart';

import 'homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
  Timer(
    Duration(seconds: 2),(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement (
          context,
          MaterialPageRoute (
            builder: (BuildContext context) =>  LoginScreen(),
          ),
        );      } else {Navigator.pushReplacement (
        context,
        MaterialPageRoute (
          builder: (BuildContext context) =>  HomeScreen(),
        ),
      );

      }
    });

  }
  );


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
