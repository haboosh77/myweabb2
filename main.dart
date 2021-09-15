
import 'package:flutter/material.dart';

import 'package:watersupplyadmin/homescreen/logindcreen.dart';

import 'homescreen/splashscreen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Salsabil Admin Dash Board',
      theme: ThemeData(

        primaryColor: Color(0xff3ca7d0),
      ),
      home:  SplashScreen(),
    );
  }
}

