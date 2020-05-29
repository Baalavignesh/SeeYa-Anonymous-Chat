import 'package:annonymouschatv2/constants.dart';
import 'package:annonymouschatv2/screens/ExistingUserScreen.dart';
import 'package:annonymouschatv2/services/CheckUser.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewUserScreen extends StatefulWidget {
  static const String id = "NewUser";
  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  int i = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('New User Welcome Page is Called');
    setState(() {
      newUser = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kDarkBackground,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 45, 0, 30),
                        child: Hero(
                          tag: 'logo',
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Image.asset(
                              'images/seeya.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(
                          kInitialScreenHeading[i - 1],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontFamily: 'Hind',
                          ),
                        ),
                        Text(
                          kInitialScreenInformation[i - 1],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontFamily: 'Hind',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      i == 1
                          ? Text(
                              '.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                              ),
                            )
                          : Text(
                              '.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 50,
                              ),
                            ),
                      i == 2
                          ? Text(
                              '.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                              ),
                            )
                          : Text(
                              '.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 50,
                              ),
                            ),
                      i == 3
                          ? Text(
                              '.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                              ),
                            )
                          : Text(
                              '.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 50,
                              ),
                            ),
                      i == 4
                          ? Text(
                              '.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                              ),
                            )
                          : Text(
                              '.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 50,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('left');
                          setState(() {
                            i--;
                          });
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 150,
                          child: i > 1
                              ? Icon(
                                  FontAwesomeIcons.arrowAltCircleLeft,
                                  size: 40,
                                  color: Colors.white,
                                )
                              : Text(' '),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('right');
                          setState(() {
                            if (i < 4) {
                              i++;
                            } else {
                              Navigator.pushNamed(
                                  context, ExistingUserScreen.id);
                            }
                          });
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 150,
                          child: Icon(
                            FontAwesomeIcons.arrowAltCircleRight,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
