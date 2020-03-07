import 'package:firebase_app_2/services/auth.dart';
import 'package:firebase_app_2/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app_2/shared/constances.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_app_2/models/user.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {

  // konštruktor pre import class z authenticate.dart
  final Function toggleView;
  SignIn({ this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  // !text field state
  String email = '';
  String password = '';
  String error = '';

  // !text style
  double fontSizeSignUp = 17.0; 


  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in app'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              // namiesto this.toggleView sa použije widget.toggleView
              // odkazuje to na konštruktor vyšie.
              widget.toggleView();
            }, 
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Column(
            children: <Widget>[
              Text(error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18.0,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30.0,),
                    TextFormField(
                      decoration: inpotFieldStyle.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter valid email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: inpotFieldStyle.copyWith(hintText: 'Password'),
                      validator: (val) => val.length < 6 ? 'Enter password contain 6+ chars' : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0,),
                    RaisedButton(
                      child: Text('Sign in',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          letterSpacing: 0.9,
                        ),
                      ),
                      color: Colors.pink,
                      onPressed: () async{
                        if(_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                           if(result == null) {
                            setState(() { 
                              error = 'Wrong email or password';
                              loading = false;
                            });
                           }
                        }
                    }),
                    SizedBox(height: 45.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
// !GOOGLE SIGN IN ****************************************************************

                        RaisedButton.icon(
                          icon: Icon(FontAwesomeIcons.google, color: Colors.red[800]),
                          label: Text('Sign up using Google',
                            style: TextStyle(
                              fontSize: fontSizeSignUp,
                              letterSpacing: 0.7,
                            ),
                          ),
                          onPressed: () {
                            dynamic result = _auth.signInWithGoogle();
                            setState(() => loading = true);
                            if(result == null) {
                              error = 'Error in google login';
                              loading = false;
                            }
                          },
                        ),

// !GOOGLE SIGN IN ****************************************************************
                        RaisedButton.icon(
                          icon: Icon(FontAwesomeIcons.facebookF, color: Colors.deepPurple[900]),
                          label: Text('Sign up using Facebook',
                            style: TextStyle(
                              fontSize: fontSizeSignUp,
                              letterSpacing: 0.7,
                            ),
                          ),
                          onPressed: () {}
                        ),
                        RaisedButton.icon(
                          icon: Icon(Icons.person),
                          label: Text('Sign in anonymously',
                            style: TextStyle(
                              fontSize: fontSizeSignUp,
                              letterSpacing: 0.7,
                            ),
                          ),
                          onPressed: () async {
                            dynamic result = await _auth.signInAnon();
                            if (result == null){
                              print('sign_in.dart >> error sign in');
                            }else {
                              print('sign_in.dart >> log in');
                              print('sign_in.dart >> uid: ' + result.uid);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}