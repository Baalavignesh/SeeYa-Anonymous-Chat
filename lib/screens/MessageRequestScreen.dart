import 'package:annonymouschatv2/constants.dart';
import 'package:flutter/material.dart';

class MessageRequestScreen extends StatefulWidget {
  static const String id = 'MessageRequestScreen';
  @override
  _MessageRequestScreenState createState() => _MessageRequestScreenState();
}

class _MessageRequestScreenState extends State<MessageRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0x0003353E),
        title: Text(
          'Message Requests',
          style: TextStyle(fontSize: 30, fontFamily: 'Hind'),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 30, 10),
            child: GestureDetector(
              onTap: () {},
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
      ),
      backgroundColor: Color(0xFF13181a),
      body: Column(
        children: requestUser,
      ),
    );
  }
}
