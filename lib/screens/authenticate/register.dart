import 'package:firebase_app_2/services/auth.dart';
import 'package:firebase_app_2/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app_2/shared/constances.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override

    final AuthService _auth = AuthService();
    final _formKey = GlobalKey<FormState>();

    bool loading = false;

    // !text field state
    String email = '';
    String password1 = '';
    String password2 = '';
    String error = '';

  Widget build(BuildContext context) {


    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register account'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign in'),
            onPressed: () {
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
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0,),
                    TextFormField(
                      decoration: inpotFieldStyle.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter valid email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      decoration: inpotFieldStyle.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) => val.length < 6 ? 'Enter password contain 6+ chars' : null,
                      onChanged: (val) {
                        setState(() => password1 = val);
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      decoration: inpotFieldStyle.copyWith(hintText: 'Confirm password'),
                      obscureText: true,
                      validator: (val) => val != password1 ? 'Heslo nieje rovnaké' : null,
                      onChanged: (val) {
                        setState(() => password2 = val);
                      },
                    ),
                    SizedBox(height: 20.0,),
                    RaisedButton(
                      child: Text('Register',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          letterSpacing: 0.9,
                        ),
                      ),
                      color: Colors.pink,
                      onPressed: () async{

                        // _formKey je kluc od formulára zadaný vyšie sledujúci momentalne stavy
                        // .curentState je momentálny stavy vyplnenia formulára
                        // .validate() - metóda kontrolujúca či su stavy validator: vo formulare v "true"

                        if(_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password1);
                          if(result == null) {
                            setState(() {
                              error = 'Email is not valid';
                              loading = false;
                            }); 
                          }
                        }
                    }),
                    SizedBox(height: 10.0),
                    Text(error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 22.0,
                      ),
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