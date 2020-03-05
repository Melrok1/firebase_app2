import 'package:firebase_app_2/models/user.dart';
import 'package:firebase_app_2/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  // !crease user object base on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null ;
  }

  // !auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user)); 
    .map(_userFromFirebaseUser);
  }

  // !sign in anon
  Future signInAnon() async {
    try{

      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    }catch (e){

      print('auth.dart >> Error in log in anon' + e.toString());
      return null;
    }
  }


  // !sign in email and password

  Future signInWithEmailAndPassword( String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print('auth.dart / signInWithEmailAndPassword >> ' + e.toString());
      return null;
    }
  }

  // !register with email and password

  Future registerWithEmailAndPassword( String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // create new document for the user by id
      await DatabaseService(uid: user.uid).updateUserData('0', 'Nový užívaťel', 100);


      return _userFromFirebaseUser(user);

    }catch(e){
      print('auth.dart / registerWithEmailAndPassword >> ' + e.toString());
      return null;
    }
  }


  // !sign out
  Future sigOut() async{
    try {
      return await _auth.signOut(); 
    }catch (e){
      print('auth.dart >> Error in log out' + e.toString());
      return null;
    }
  }

}
