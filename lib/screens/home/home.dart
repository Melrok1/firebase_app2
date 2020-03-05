import 'package:firebase_app_2/screens/home/userList.dart';
import 'package:firebase_app_2/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_app_2/models/user.dart';
import 'package:firebase_app_2/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_2/models/user2.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {


    // ?First bottom sheet START /////////////////////////////////////////

    void _showSetingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
          child: Text('Bottom sheet :-o', style: TextStyle(fontSize: 25.0,)),
        );
      });
    }

    // ?First bottom sheet END /////////////////////////////////////////


    return StreamProvider<List<UserRegister>>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async{
                await _auth.sigOut(); 
              }, 
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: (){
                _showSetingsPanel();
              },
            ),
          ],
        ),
        body: UserList(),
      ),
    );
  }
}