import 'package:annonymouschatv2/utilities/MessageBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MessageStream extends StatelessWidget {
  final _store = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _store
          .collection('Chats')
          .document(documentID)
          .collection('Messages')
          .orderBy('day', descending: true)
          .snapshots(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.purpleAccent,
            ),
          );
        }
        List<Column> messageBox = [];
        final messages = snapshot.data.documents;
        for (var message in messages) {
          final messageText = message.data['message'];
          final messageTime = message.data['time'];
          final messageDay = message.data['day'];
          final messageSender = message.data['sender'];
          final box = Column(
//                            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              MessageBubble(
                message: messageText,
                time: messageTime,
                isMe: sNumber == messageSender,
              ),
            ],
          );
          messageBox.add(box);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.all(10),
//                          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: messageBox,
          ),
        );
      },
    );
  }
}
