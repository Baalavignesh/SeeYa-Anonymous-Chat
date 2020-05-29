import 'dart:math';

import 'package:annonymouschatv2/screens/ExistingUserScreen.dart';
import 'package:annonymouschatv2/screens/NewUserScreen.dart';
import 'package:annonymouschatv2/utilities/ReusableChatBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_hero/super_hero.dart';

import '../constants.dart';
import 'package:flutter/material.dart';

final _store = Firestore.instance;
bool exist = false;
bool newUser = false;

class CheckUser extends StatefulWidget {
  static const String id = 'CheckUser';

  @override
  _CheckUserState createState() => _CheckUserState();
}

@override
Duration get transitionDuration => const Duration(milliseconds: 1000);

class _CheckUserState extends State<CheckUser> {
  Future checkUser() async {
    setState(() {
      username = [];
      phoneNumber = [];
      userData = [];
      allUser = [];
      friendUser = [];
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    sNumber = (prefs.getString('sPhonenumber'));
    print('Number we got is $sNumber');

    final QuerySnapshot result = await _store
        .collection('Users')
        .where('Number', isEqualTo: sNumber)
        .limit(1)
        .getDocuments();
    print(sNumber);

    final List<DocumentSnapshot> documents = result.documents;
    if (documents.length == 1) {
      print('*****************Already Existing User********************');
      getUserData();
    } else {
      print('*****************Welcome new User*****************');
      setState(() {
        newUser = true;
      });
      newData();
    }
  }

  Future newData() async {
    var rng = new Random();
    int nameId;
    String ranName;
    String yourName;
    nameId = rng.nextInt(100);
    ranName = SuperHero.random();
    yourName = ranName + ' #' + nameId.toString();

    final docRef = await _store.collection('Users').add(
      {
        'Number': sNumber,
        'UniqueName': yourName,
        'accountCreatedTime': DateTime.now(),
        'Friends': friends,
        'Request': request,
      },
    );
    sDocumentID = docRef.documentID;

    getUserData();
  }

  Future getUserData() async {
    print('getUserData Function');

    await _store.collection('Users').getDocuments().then((value) {
      for (var i in value.documents) {
        userData.add(i.data);
        if (i.data['Number'] == sNumber) {
          sDocumentID = i.documentID;
          sUsername = i.data['UniqueName'];
        }
      }
    });

    getUsernameNumber();
    await createUserList();
    await messageRequest();

    if (newUser == true) {
      Navigator.pushNamed(context, NewUserScreen.id);
    } else {
      Navigator.pushNamed(context, ExistingUserScreen.id);
    }
  }

  getUsernameNumber() {
    print('Get Username and Number Function');
    for (var i = 0; i < userData.length; i++) {
      username.add(userData[i]['UniqueName']);
      phoneNumber.add(userData[i]['Number']);
    }
  }

  createUserList() async {
    print('Create User List Function');
    setState(() {
      allUser = [];
      friendUser = [];
    });

    // ALL USERS
    for (var i = 0; i < username.length; i++) {
      if (username[i] != sUsername) {
        Column oneChat = chatUserDisplayed(username[i], context);
        allUser.add(oneChat);
      }
    }

    //FRIEND USERS
    List<dynamic> myFriend;
    await _store.collection('Users').document(sDocumentID).get().then((value) {
      myFriend = value.data['Friends'];
    });
    for (var i = 0; i < username.length; i++) {
      for (var j = 0; j < myFriend.length; j++) {
        if (userData[i]['Number'] == myFriend[j]) {
          friendUserData.add(userData[i]);
        }
      }
    }
    print(friendUserData);
//    print(myFriend[i]);
    for (var i = 0; i < friendUserData.length; i++) {
      Column oneChat =
          chatUserDisplayed(friendUserData[i]['UniqueName'], context);
      friendUser.add(oneChat);
    }
  }

  messageRequest() async {
    print('Message Request Function');
    await _store.collection('Users').document(sDocumentID).get().then((value) {
      request = value.data['Request'];
      print(request);
      print(request.length);
      print(friendUserData.length);
      if (friendUserData.length > 0 && request.length > 0) {
        for (var i = 0; i < friendUserData.length; i++) {
          print('inside loop');
          print(request.length);
          for (var j = 0; j < request.length; j++) {
            print('hello');
            if (friendUserData[i]['Number'] == request[j]) {
              print('Already a Friend');
              setState(() {
                request = [];
              });
            } else {
              print('Go to Request Section');
            }
          }
        }
      } else if (request.length > 0) {
        print('No Friend, but having request');
        for (var i = 0; i < userData.length; i++) {
          for (var j = 0; j < request.length; j++) {
            if (userData[i]['Number'] == request[j]) {
              Column oneChat =
                  chatUserDisplayed(userData[i]['UniqueName'], context);
              requestUser.add(oneChat);
            }
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    print('Check User Screen');

    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Hero(
              tag: 'logo',
              child: Container(
                width: 200,
                height: 200,
                child: Image.asset(
                  'images/seeya.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
