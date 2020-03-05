import 'package:firebase_app_2/screens/home/userTitle.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_app_2/models/user2.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<UserRegister>>(context);

    

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserTitle(user: users[index]);
      }
    );
  }
}