import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_app/core/utils/app_constants.dart';
import 'package:doctor_app/core/utils/cashe_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

import '../models/user_model.dart';

abstract class RemoteDataSource {
  Future<Unit> logout();
  Future<Unit> signInWithEmail(
      {required String email, required String password});
  Future<Unit> signInWithGoogle();
  Future<Unit> signInWithFacebook(
      {required String email, required String password});
  Future<Unit> signUp(
      {required String email, required String password,        required String phoneNumber,
        required String name});
  Future<Unit> forgotPassword({required String email});
  Future<Unit> saveUsersData(
      {required String uid,
      required String email,
        required String phoneNumber,

        required String name});
  Future<UserModel> getUsersData({required String id});
}

class RemoteDataSourceImp extends RemoteDataSource {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Unit> forgotPassword({required String email}) {
    firebaseAuth.sendPasswordResetEmail(email: email);
    return Future.value(unit);
  }

  @override
  Future<Unit> saveUsersData(
      {required String uid,

        required String email,
        required String phoneNumber,
      required String name}) async {
    final url= Uri.parse(
      'https://doctorapp-de549-default-rtdb.asia-southeast1.firebasedatabase.app/users/$uid.json',
    );
    print("user is "+uid.toString());
    final response = await http.put(
        url,
    body: json.encode({'name': name, 'email': email, 'uid': uid,'phoneNumber':phoneNumber}));

    if (response.statusCode == 200) {
      print('user saved!');
    } else {
      print('Failed to save user: ${response.body}');
    }

    return Future.value(unit);
  }

  @override
  Future<Unit> signInWithEmail(
      {required String email, required String password}) async {

    UserCredential userCredential = await
    firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    if (user != null) {
      CasheHelper.putData(key: 'uid', value: user.uid);

      //saveUsersData(uid: user.uid, email: user.email!, name:user.displayName!);

    }

    return Future.value(unit);
  }

  @override
  Future<Unit> signInWithFacebook(
      {required String email, required String password}) {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<Unit> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
   var authResult =
       await firebaseAuth.signInWithCredential(credential);
       User user =   authResult.user!;

    return Future.value(unit);
  }

  @override
  Future<Unit> signUp(
      {required String email,
      required String password,
        required String phoneNumber,

        required String name}) async {
    // try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      if (userCredential.user != null) {
        CasheHelper.putData(key: 'name', value: userCredential.user!.displayName);

        CasheHelper.putData(key: 'uid', value: userCredential.user!.uid);

        saveUsersData(uid: userCredential.user!.uid, email: email, name: name,phoneNumber: phoneNumber);}

    return Future.value(unit);
  }

  @override
  Future<UserModel> getUsersData({required String id}) async {
    final url = Uri.parse( 'https://doctorapp-de549-default-rtdb.asia-southeast1.firebasedatabase.app/users/$id.json',
    );

    final response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      var data =json.decode(response.body);

      UserModel userModel= UserModel.fromJson(data);

      return Future.value(userModel);

    }else {
      throw Exception('Failed to load doctors');
    }

  }

  @override
  Future<Unit> logout() async {

    await FirebaseAuth.instance.signOut();
    return Future.value(unit);
  }
}
