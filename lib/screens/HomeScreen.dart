import 'package:annonymouschatv2/screens/OTPScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int state = 0;
  String country = '+91';
  String phone;
  Color buttonColor = kAppBlue;
  final countryTextController = TextEditingController(text: '+91');
  final phoneTextController = TextEditingController();

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
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
                  Column(
                    children: <Widget>[
                      Text(
                        'Welcome',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Hind',
                          fontSize: 40,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Sign In to Chat with Anonymous Person',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Hind',
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    controller: countryTextController,
                                    keyboardType: TextInputType.phone,
                                    decoration: kInputDecoration.copyWith(
                                      hintText: '+',
                                      hintStyle: TextStyle(
                                        color: Colors.white70,
                                      ),
                                      fillColor: kLightBackground,
                                      filled: true,
                                    ),
                                    onChanged: (value) {
                                      country = value;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: TextField(
//                                    textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                      keyboardType: TextInputType.phone,
                                      decoration: kInputDecoration.copyWith(
                                        hintText: 'Enter your Phone Number',
                                        hintStyle: TextStyle(
                                          color: Colors.white70,
                                        ),
                                        fillColor: kLightBackground,
                                        filled: true,
                                      ),
                                      onChanged: (value) {
                                        phone = value;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                  if (country != null && phone != null) {
                                    setState(() {
                                      state = 1;
                                      sNumber = country + phone;
                                      print('In Home Screen : $sNumber');

                                      buttonColor = kAppBlue;
                                    });

                                    if (sNumber != null) {
                                      setState(() {
                                        state = 1;
                                      });

                                      Future.delayed(Duration(seconds: 1), () {
                                        setState(() {
                                          state = 2;
                                          buttonColor = Colors.green;
                                        });
                                        Future.delayed(Duration(seconds: 1),
                                            () {
                                          Navigator.pushNamed(
                                              context, OTPScreen.id);
                                        });
                                      });
                                    } else {
                                      setState(() {
                                        state = 3;
                                        buttonColor = Colors.redAccent;
                                      });
                                      Future.delayed(Duration(seconds: 1), () {
                                        setState(() {
                                          state = 0;
                                          buttonColor = kAppBlue;
                                          phoneTextController.clear();
                                        });
                                      });
                                      print('Enter a Number');
                                    }
                                  } else {
                                    print('enter Number');
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Enter Mobile Number with Country Code',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Hind',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Because, We don\'t access your Location',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Hind',
                          fontSize: 17,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ],
                  ),
                ],
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
      return Icon(FontAwesomeIcons.arrowCircleRight);
    } else if (state == 1) {
      return CircularProgressIndicator(
        value: null,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else if (state == 2) {
      setState(() {
        buttonColor = Colors.green;
      });
      return Icon(FontAwesomeIcons.check);
    } else if (state == 3) {
      return Icon(FontAwesomeIcons.timesCircle);
    }
  }
}
