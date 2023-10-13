import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  static  getUser(uid){
    return FirebaseFirestore.instance.collection('users').where('id', isEqualTo: uid).snapshots();
  }
}