import 'package:firebase_app_2/screens/authenticate/authenticate.dart';
import 'package:firebase_app_2/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_app_2/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print('Wrapper.dart >> user: ' + user.toString());

    // return either home or authenticate widget

    if( user == null) {
      return Authenticate();
    }else {
      return Home();
    }
  }
}