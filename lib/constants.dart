import 'package:flutter/material.dart';

String sNumber;
String sUsername;
String sDocumentID;
String sFriendsID;
bool result = false;
Color kDarkBackground = Color(0xFF03353E);
Color kLightBackground = Color(0xFF2E2E2E);
Color kAppBlue = Color(0xFF06BDC6);
Color kAppOrange = Color(0xFFe06969);
List<Map<String, dynamic>> userData = [];
List<Map<String, dynamic>> friendUserData = [];
List<String> username = [];
List<String> phoneNumber = [];
List<dynamic> friends = [];
List<dynamic> request = [];
bool block = false;
bool firstTime = true;

String documentID;
String messageTime;
DateTime messageDay;
String messageDayDummy;
List<Column> allUser = [];
List<Column> friendUser = [];
List<Column> requestUser = [];
int clickedIndex = 0;

var kInputDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 5.0),
    borderRadius: BorderRadius.circular(5),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.circular(5),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
    borderRadius: BorderRadius.circular(5),
  ),
);

List<String> kInitialScreenHeading = [
  'Welcome to SeeYa Annonymous Chat',
  'Warning',
  'Motive?',
  'Last but not Least'
];
List<String> kInitialScreenInformation = [
  'We don\'t ask you for any information. This is truely Annonymous Chat.',
  'If you don\'t like the way how a person talks. You can Block that person Immedietly',
  'This app is made just for fun to talk to Strangers when you are Bored',
  'Sharing any of your Personal information to others is at your own Risk!'
];
