import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authservice {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signup(String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      debugPrint('Error during sign-up: $e');
    }
    return null;
  }

  Future<User?> signin(String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      debugPrint('Error during sign-in: $e');
    }
    return null;
  }

  Future<void> storeUserData(String uid,String firstname,String  lastname
  , String email, String password, )async{
  await FirebaseFirestore.instance.collection('users').doc(uid).set({
'email':email,
'firstname':firstname,
'lastname':lastname,
'password':password,

  });
  }
}
