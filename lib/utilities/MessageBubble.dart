import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({this.message, this.time, this.isMe});
  final message;
  final time;
  final isMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 5, 8),
          child: Container(
            child: Row(
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: BubbleData(
                    isMe: isMe,
                    message: message,
                    time: time,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BubbleData extends StatelessWidget {
  final isMe;
  final message;
  final time;
  BubbleData({this.isMe, this.message, this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
//      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: isMe ? kAppBlue : kAppOrange,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(7),
                    bottomLeft: Radius.circular(7),
                    bottomRight: Radius.circular(7),
                    topRight: Radius.circular(0))
                : BorderRadius.only(
                    topLeft: Radius.circular(0),
                    bottomLeft: Radius.circular(7),
                    bottomRight: Radius.circular(7),
                    topRight: Radius.circular(7)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              message,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Hind',
              ),
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          time,
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
