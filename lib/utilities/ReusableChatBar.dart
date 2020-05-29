import 'package:annonymouschatv2/screens/ChatScreen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

//class ChatUserDisplayed extends StatelessWidget {
//  final username;
//  final onPress;
//  ChatUserDisplayed({@required this.username, this.onPress});
//
//  @override
//  Widget build(BuildContext context) {
//    return
//  }
//}

class ReusableCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Column chatUserDisplayed(String usernameClicked, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () {
          print(username.asMap());
          print(username.indexOf(usernameClicked));
          clickedIndex = username.indexOf(usernameClicked);
          print(phoneNumber[clickedIndex]);
          Navigator.pushNamed(context, ChatScreen.id);
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 30, 8),
          child: Material(
            color: Color(0xFF0D1E26),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: Color(0xFFe06969),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Container(
                      child: Text(
                        usernameClicked,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(fontSize: 30, fontFamily: 'Hind'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 10,
        child: Divider(
          thickness: 1,
          color: kAppBlue,
        ),
      )
    ],
  );
}
