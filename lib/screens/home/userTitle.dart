import 'package:flutter/material.dart';
import 'package:firebase_app_2/models/user2.dart';

class UserTitle extends StatelessWidget {

    final UserRegister user;
    UserTitle({ this.user });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0,),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[user.strength],
          ),
          title: Text(user.name),
          subtitle: Text('Takes ${user.sugar} sugar(s)'),
        ),
      ),
    );
  }
}