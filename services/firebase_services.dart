


import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices{

  Future<QuerySnapshot?>getAdminCredentials() async {

var result =FirebaseFirestore.instance.collection('Admin').get();
return result;
  }
}