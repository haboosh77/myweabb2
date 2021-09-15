import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:watersupplyadmin/homescreen/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Salsabil Admin Dash Board',
      theme: ThemeData(
        primaryColor: Color(0xff3ca7d0),
      ),
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            print("Error");
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return SplashScreen();
          }
          // Otherwise, show something whilst waiting for initialization to complete
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
