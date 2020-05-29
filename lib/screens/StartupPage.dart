import 'package:annonymouschatv2/services/AuthService.dart';
import 'package:flutter/material.dart';

class StartUp extends StatefulWidget {
  static const String id = "Startup";
  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthService().handleAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Error'),
    );
  }
}
