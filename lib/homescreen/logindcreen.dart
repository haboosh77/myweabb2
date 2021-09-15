

import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:watersupplyadmin/homescreen/homescreen.dart';
import 'package:watersupplyadmin/services/firebase_services.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _formkey=GlobalKey<FormState>();
  FirebaseServices _services=FirebaseServices();

  String? username;
  String? password;
  @override
  Widget build(BuildContext context) {

    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0xff23babf),
        animationDuration: Duration(milliseconds: 500));

   Future<void> _login()async{
      progressDialog.show();
      _services.getAdminCredentials().then((value) {
        value!.docs.forEach((doc) async {
          if(doc.get('username')==username){
            if(doc.get('password')==password){
              UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();

              progressDialog.dismiss();
              if(userCredential.user!.uid!=null){

                Navigator.pushReplacement (
                  context,
                  MaterialPageRoute (
                    builder: (BuildContext context) =>  HomeScreen(),
                  ),
                );
                return ;
              }else{

                _showMyDialog(
                  title: 'Login',
                  message: 'Login faild',
                );
              }

            }else{
              progressDialog.dismiss();
              _showMyDialog(
                  title: 'Incorrect Password',
                  message: 'password you entered is incorrect,Please  try again'
              );}

          }else{
            progressDialog.dismiss();

            _showMyDialog(
                title: 'Invalid UserName',
                message: 'Username you entered is not vaild,Please  try again'
            );
          }

        });

      });

    }
    return Scaffold(
      appBar: AppBar(


        title: Text('Salsabil Admin Dash',style: TextStyle(color:Colors.white),),centerTitle: true,
      ),
      body:  FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(child:Text('Connection Failed'));
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff23babf),
                    Colors.white,
                  ],

                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Container(
                  width: 300,height: 400,
                  child: Card(
                    elevation: 6,
                    shape: Border.all(color: Colors.lightBlueAccent,width: 2),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [Container(child: Column(
                            children: [
                              Image.asset('assets/images/OIP.jpg',width: 90,height: 90,),
                              Text('Salsbil App Admin ' ,style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15),),
                              SizedBox(height: 10.0,),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){

                                    return 'Enter Username';
                                  }
                                  setState(() {
                                    username=value;
                                  });
                                  return null;
                                },
                                decoration:InputDecoration(
                                  labelText: 'UserName',
                                  prefixIcon: Icon(Icons.person),

                                  focusColor: Theme.of(context).primaryColor,
                                  contentPadding: EdgeInsets.only(left:20,right: 20),
                                  border: OutlineInputBorder( ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:Theme.of(context).primaryColor,
                                      width: 2,
                                    ),
                                  ),


                                ) ,),
                              SizedBox(height: 20.0,),
                              TextFormField
                                (obscureText: true,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Enter Password';
                                  }if(value.length<6){
                                    return 'Minimum 6 characters';
                                  }
                                  setState(() {
                                    password=value;
                                  });
                                  return null;
                                },
                                decoration:InputDecoration(
                                  labelText: 'Minimum 6 Characters',
                                  prefixIcon:Icon( Icons.vpn_key_outlined),
                                  hintText: 'Password',
                                  focusColor: Theme.of(context).primaryColor,
                                  contentPadding: EdgeInsets.only(left:20,right: 20),
                                  border: OutlineInputBorder( ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:Theme.of(context).primaryColor,
                                      width: 2,
                                    ),
                                  ),


                                ) ,),
                            ],),),

                            Row(
                              children: [
                                Expanded(child: MaterialButton(onPressed: (){
                                  if(_formkey.currentState!.validate()){
                                  _login();
                                  }
                                },
                                  child: Text('Login',style: TextStyle(color:Colors.white),),color:Theme.of(context).primaryColor,)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ) ;
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return CircularProgressIndicator();
        },
      ),
    );
  }
  Future<void> _showMyDialog({title,message}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
                Text('Please try again'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



}
