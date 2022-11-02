import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  FirebaseAuth authInstance = FirebaseAuth.instance;

  static final AuthenticationService instance =
      AuthenticationService._internal();

  factory AuthenticationService() {
    return instance;
  }

  AuthenticationService._internal();

  Future<String> register(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return e.code;
    } catch (e) {
      print(e);
      return 'something went wrong';
    }
    return 'success';
  }

  Future<String> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return 'something went wrong';
    }
    return 'success';
  }
}
