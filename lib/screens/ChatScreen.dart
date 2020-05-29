import 'package:annonymouschatv2/constants.dart';
import 'package:annonymouschatv2/services/AuthService.dart';
import 'package:annonymouschatv2/services/CheckUser.dart';
import 'package:annonymouschatv2/services/MessageStream.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String message;
  var controller = TextEditingController();
  final _store = Firestore.instance;
  bool isMe;
  bool meBlocked = false;
  String blockID;

  createDocumentId() {
    print('Create Document ID Function');
    print(sDocumentID);
    DateTime now = DateTime.now();
    messageDayDummy = DateFormat.yMd().add_jm().format(now);
    messageDay = DateTime.now();
//    print(messageDay);

    messageTime = messageDayDummy.substring(10);
    print(messageTime);
    String num1;
    String num2;
    num1 = sNumber.substring(3);
//    print(num1);
    num2 = phoneNumber[clickedIndex].substring(3);
//    print(num2);
    if (int.parse(num1) > int.parse(num2)) {
//      print('greater');
      setState(() {
        documentID = num1 + num2;
      });
//      print(documentID);
    } else {
      setState(() {
        documentID = num2 + num1;
      });
//      print(documentID);
//      print('lesser');
    }
  }

  blockedUser() async {
    print('Block User');
    await _store
        .collection('Chats')
        .document(documentID)
        .collection('Blocked')
        .getDocuments()
        .then((value) {
      for (var i in value.documents) {
        print('inside');
        blockID = i.documentID;
        print(i.data['block']);
        setState(() {
          meBlocked = i.data['block'];
        });
      }
    });

    print(blockID);
    if (blockID == null) {
      await _store
          .collection('Chats')
          .document(documentID)
          .collection('Blocked')
          .add({'block': block});
      await _store
          .collection('Chats')
          .document(documentID)
          .collection('Blocked')
          .getDocuments()
          .then((value) {
        for (var i in value.documents) {
          print('inside');
          blockID = i.documentID;
          print(i.data['block']);
          meBlocked = i.data['block'];
        }
      });
    }
    if (meBlocked == true) {
      print('You were Blocked');
    } else {
      print('You ain\'t Blocked');
    }
    print('bruh');
  }

  addFriend() async {
    String requestID;
    print('should i add friend');
    print(sDocumentID);
    await _store.collection('Users').document(sDocumentID).updateData({
      'Friends': FieldValue.arrayUnion([phoneNumber[clickedIndex]])
    });

    await _store.collection('Users').getDocuments().then((value) {
      for (var i in value.documents) {
        if (phoneNumber[clickedIndex] == i.data['Number']) {
          requestID = i.documentID;
        }
      }
    });

    await _store.collection('Users').document(requestID).updateData({
      'Request': FieldValue.arrayUnion([sNumber])
    });
  }

  @override
  void initState() {
    super.initState();
    createDocumentId();
    blockedUser();
  }

  deleteChat() async {
    print('delete chat function');
    await _store
        .collection('Chats')
        .document(documentID)
        .collection('Messages')
        .getDocuments()
        .then((value) {
      for (var i in value.documents) {
        i.reference.delete();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    AuthService().handleAuth();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: Color(0xFF13181a),
          appBar: AppBar(
            backgroundColor: Color(0x0003353E),
            title: Text(
              username[clickedIndex],
              style: TextStyle(fontSize: 30, fontFamily: 'Hind'),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 30, 10),
                child: GestureDetector(
                  onTap: () async {
                    await _store
                        .collection('Chats')
                        .document(documentID)
                        .collection('Blocked')
                        .document(blockID)
                        .updateData({'block': block});

                    print('Dialogue not working');
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  username[clickedIndex],
                                  style: TextStyle(
                                      fontSize: 26, fontFamily: 'Hind'),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () async {
                                        print('block person');
                                        await _store
                                            .collection('Chats')
                                            .document(documentID)
                                            .collection('Blocked')
                                            .document(blockID)
                                            .updateData({'block': true});
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.block,
                                              color: Colors.redAccent,
                                              size: 30,
                                            ),
                                          ),
                                          Text(
                                            'Block',
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
                                        print('delete chat');
                                        await deleteChat();
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.grey,
                                              size: 30,
                                            ),
                                          ),
                                          Text(
                                            'Clear Chat',
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
                    color: Color(0xFF13181a),
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
          body: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MessageStream(),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 19),
                          enabled: meBlocked ? false : true,
                          decoration: kInputDecoration.copyWith(
                            fillColor: Color(0xFFFFFFFF),
                            filled: true,
                            hintText: meBlocked ? 'BLOCKED' : 'Type a message',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 19,
                            ),
                          ),
                          controller: controller,
                          onChanged: (value) {
                            setState(() {
                              message = value;
                            });
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          controller.clear();
                          await createDocumentId();
                          await addFriend();
//                          setState(() {
//                            firstTime = false;
//                          });
                          print('sending');

                          await _store
                              .collection('Chats')
                              .document(documentID)
                              .collection('Messages')
                              .add({
                            'message': message,
                            'sender': sNumber,
                            'time': messageTime,
                            'day': messageDay,
                          });

                          await _store
                              .collection('Chats')
                              .document(documentID)
                              .collection('Blocked')
                              .document(blockID)
                              .updateData({'block': block});
                        },
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.blueGrey,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.send,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
