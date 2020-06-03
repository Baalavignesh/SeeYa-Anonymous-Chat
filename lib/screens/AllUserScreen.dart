import 'package:annonymouschatv2/services/AuthService.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'HomeScreen.dart';

class AllUserScreen extends StatefulWidget {
  @override
  _AllUserScreenState createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: [
            Divider(
              height: 1,
              thickness: 2,
              color: kAppOrange,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: allUser,
          ),
        )
      ],
    );
  }
}
