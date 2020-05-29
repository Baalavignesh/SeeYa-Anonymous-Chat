import 'dart:async';

import 'package:annonymouschatv2/screens/HomeScreen.dart';
import 'package:annonymouschatv2/screens/NewUserScreen.dart';
import 'package:annonymouschatv2/services/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class OTPScreen extends StatefulWidget {
  static const String id = 'OTPScreen';
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _auth = FirebaseAuth.instance;
  String otp;
  int state = 0;
  String verificationId;
  bool codeSent;
  bool user;
  String warningMessage = 'Wrong OTP';
  Color buttonColor = Color(0xFF06BDC6);
  final otpTextController = TextEditingController();

  Future<void> verifyPhone() async {
    setState(() {
      _start = 59;
      otpResend = true;
    });
    startTimer();
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeReSend]) {
      setState(() {
        codeSent = true;
        state = 0;
      });
      this.verificationId = verId;
      print(verificationId);
    };

    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
      print('verified');
      Navigator.pushNamed(context, NewUserScreen.id);
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException exception) {
      print('too many times');
      if (exception.message ==
          'We have blocked all requests from this device due to unusual activity. Try again later.') {
        setState(() {
          warningMessage = 'Too Many Login Attempts, try after sometime.';
          otpResend = false;
          wrongOTP = true;
        });
      }
      print('${exception.message}');
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: sNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  Timer timer;
  int _start = 59;
  bool otpResend;
  bool wrongOTP = false;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            setState(() {
              otpResend = false;
            });
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  String savedNumber;

  setPhoneNumber() async {
    print('setPhoneNumber');
    print(sNumber);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedNumber = (prefs.getString('sPhonenumber'));
    print('Saved Number : $savedNumber');
    if (savedNumber == null) {
      await prefs.setString('sPhonenumber', sNumber);
      print('Phone Number is set $sNumber');

      return sNumber;
    } else {
      await prefs.setString('sPhonenumber', sNumber);
      print('Phone Number is set $sNumber');

      return sNumber;
    }
  }

  @override
  void initState() {
    super.initState();
    try {
      verifyPhone();
    } catch (e) {
      print('got em');
    }
    setPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/picture.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 50, 0, 80),
                          child: Hero(
                            tag: 'logo',
                            child: Container(
                              width: 100,
                              height: 100,
                              child: Image.asset(
                                'images/seeya.png',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Column(
                          children: <Widget>[
                            Text(
                              'Almost Done',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Hind',
                                fontSize: 40,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Enter the 6 digit OTP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Hind',
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Column(
                            children: [
                              Container(
                                width: 350,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  child: TextField(
                                    controller: otpTextController,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.phone,
                                    decoration: kInputDecoration.copyWith(
                                      hintText: 'OTP Here',
                                      contentPadding: EdgeInsets.all(20),
                                      hintStyle: TextStyle(
                                        color: Colors.white70,
                                      ),
                                      fillColor: Color(0xFF2E2E2E),
                                      filled: true,
                                    ),
                                    onChanged: (value) {
                                      otp = value;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                          child: Container(
                            child: PhysicalModel(
                              color: buttonColor,
                              elevation: 5,
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                width: 50,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0.0),
                                  child: childButton(),
                                  onPressed: () async {
                                    await setPhoneNumber();

                                    setState(() {
                                      state = 1;
                                    });
                                    result = await AuthService()
                                        .signInWithOTP(otp, verificationId);
                                    print(result);
                                    if (result == true) {
                                      print('calling check user page');

//                                      Navigator.pushNamed(
//                                          context, CheckUser.id);
                                    } else {
                                      print('Wrong OTP');
                                      otpTextController.clear();
                                      setState(() {
                                        state = 0;
                                        wrongOTP = true;
                                        otpResend = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        wrongOTP
                            ? Text(
                                warningMessage,
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 20,
                                ),
                              )
                            : Text(
                                ' ',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 20,
                                ),
                              )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Entered Number : $sNumber',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Hind',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, HomeScreen.id);
                                },
                                child: Text(
                                  'Edit',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Hind',
                                    fontSize: 20,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          otpResend == true
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Resend OTP : ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Hind',
                                        fontSize: 25,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '00:$_start',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Hind',
                                        fontSize: 25,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  ],
                                )
                              : GestureDetector(
                                  onTap: () {
                                    verifyPhone();
                                  },
                                  child: Text(
                                    'Resend',
                                    style: TextStyle(
                                      fontFamily: 'Hind',
                                      fontSize: 25,
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: missing_return
  Widget childButton() {
    if (state == 0) {
      setState(() {
        buttonColor = Color(0xFF06BDC6);
      });
      return Icon(FontAwesomeIcons.arrowCircleRight);
    } else if (state == 1) {
      return CircularProgressIndicator(
        value: null,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else if (state == 2) {
      return Icon(FontAwesomeIcons.check);
    } else if (state == 3) {
      return Icon(FontAwesomeIcons.timesCircle);
    }
  }
}
