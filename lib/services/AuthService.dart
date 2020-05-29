import 'package:annonymouschatv2/constants.dart';
import 'package:annonymouschatv2/screens/HomeScreen.dart';
import 'package:annonymouschatv2/services/CheckUser.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static const String id = 'AuthService';
  final _auth = FirebaseAuth.instance;
  bool check;
  handleAuth() {
    return StreamBuilder(
        stream: _auth.onAuthStateChanged,
        // ignore: missing_return
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
//            print('still has data');
//            Navigator.pushNamed(context, OldUser.id);
            if (firstTime == true) {
              print('STREAM WORKING');
              return CheckUser();
            } else {
              print('STREAM WORKING, BUT NOT INSIDE');
            }
          } else {
            return HomeScreen();
          }
        });
  }

  // SignOut
  signOut() {
    _auth.signOut();
    print('called');
    AuthService().handleAuth();
  }

  //SignIn
  signIn(AuthCredential authCreds) async {
    try {
      print('SignIn Auth');
      await _auth.signInWithCredential(authCreds);
      check = true;
    } catch (e) {
      print('sign in failed');
      check = false;
      print(e);
    }
  }

  signInWithOTP(smsCode, verId) async {
    try {
      print('SignIn with OTP Auth');
      AuthCredential authCreds = PhoneAuthProvider.getCredential(
          verificationId: verId, smsCode: smsCode);
      await signIn(authCreds);
      return check;
    } catch (e) {
      print('Problem with SignIn with OTP');
      print(e);
    }
  }
}
