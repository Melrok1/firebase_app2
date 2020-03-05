import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_2/models/user2.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // Colections reference
  final CollectionReference usersCllection = Firestore.instance.collection('users');

  Future updateUserData(String sugars, String name, int strength) async {
    return await usersCllection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }

  // user list from snapshot
  List<UserRegister> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserRegister(
        sugar: doc.data['sugar'] ?? '0',
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 100,
      );
    }).toList();
  }

  // get users stream
  Stream<List<UserRegister>> get users {
    return usersCllection.snapshots()
      .map(_userListFromSnapshot);
  }

}