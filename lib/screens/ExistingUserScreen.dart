import 'package:annonymouschatv2/constants.dart';
import 'package:annonymouschatv2/screens/AllUserScreen.dart';
import 'package:annonymouschatv2/screens/ChatHomeScreen.dart';
import 'package:annonymouschatv2/screens/NewUserScreen.dart';
import 'package:annonymouschatv2/services/AuthService.dart';
import 'package:annonymouschatv2/utilities/ReusableChatBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class ExistingUserScreen extends StatefulWidget {
  static const String id = "OldUser";
  @override
  _ExistingUserScreenState createState() => _ExistingUserScreenState();
  Duration get transitionDuration => const Duration(milliseconds: 1000);
}

class _ExistingUserScreenState extends State<ExistingUserScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;
  String user;
  final _store = Firestore.instance;

  @override
  void initState() {
    super.initState();
    print('Existing User Screen');
    controller = TabController(vsync: this, length: 2);
    print('Username : $sUsername');
    print('Phone Number : $sNumber');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Color(0x0003353E),
              title: Text(
                'SeeYa',
                style: TextStyle(fontSize: 30, fontFamily: 'Hind'),
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 30, 10),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) => Dialog(
                          backgroundColor: Colors.black,
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                            shadowColor: Colors.grey,
                            child: Container(
                              height: 200,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    'Anonymous Chat',
                                    style: TextStyle(
                                        fontSize: 26, fontFamily: 'Hind'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () async {
                                          print('menu button');
                                          Navigator.pushNamed(
                                              context, NewUserScreen.id);
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.info,
                                                color: Colors.greenAccent,
                                                size: 30,
                                              ),
                                            ),
                                            Text(
                                              'About',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Hind',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          print('Logout');
                                          await AuthService().signOut();
                                          Navigator.pushNamed(
                                              context, HomeScreen.id);
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.exit_to_app,
                                                color: Colors.redAccent,
                                                size: 30,
                                              ),
                                            ),
                                            Text(
                                              'Logout',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Hind',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Material(
                      elevation: 20,
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(20),
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                          child: Image.asset(
                            'images/seeya.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              bottom: TabBar(
                unselectedLabelColor: kAppOrange,
                labelColor: kAppBlue,
                controller: controller,
                tabs: <Tab>[
                  new Tab(icon: new Icon(Icons.chat)),
                  new Tab(icon: new Icon(Icons.people)),
                ],
              ),
            ),
            backgroundColor: Color(0xFF13181a),
            body: TabBarView(
              controller: controller,
              children: [
                ChatHomeScreen(),
                AllUserScreen(),
              ],
            )),
      ),
    );
  }
}
