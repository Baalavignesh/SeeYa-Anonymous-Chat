import 'package:annonymouschatv2/screens/ChatScreen.dart';
import 'package:annonymouschatv2/screens/HomeScreen.dart';
import 'package:annonymouschatv2/screens/MessageRequestScreen.dart';
import 'package:annonymouschatv2/screens/NewUserScreen.dart';
import 'package:annonymouschatv2/screens/OTPScreen.dart';
import 'package:annonymouschatv2/screens/ExistingUserScreen.dart';
import 'package:annonymouschatv2/screens/StartupPage.dart';
import 'package:annonymouschatv2/services/AuthService.dart';
import 'package:annonymouschatv2/services/CheckUser.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: AuthService().handleAuth(),
      routes: {
        StartUp.id: (context) => StartUp(),
        AuthService.id: (context) => AuthService().handleAuth(),
        HomeScreen.id: (context) => HomeScreen(),
        OTPScreen.id: (context) => OTPScreen(),
        CheckUser.id: (context) => CheckUser(),
        ExistingUserScreen.id: (context) => ExistingUserScreen(),
        NewUserScreen.id: (context) => NewUserScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        MessageRequestScreen.id: (context) => MessageRequestScreen(),
      },
    );
  }
}
