import'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';

class Register extends StatefulWidget {
  final Function Toggle;
  Register({this.Toggle});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email='';
  String password = '';
  String error='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
          actions: [
          TextButton.icon(
          onPressed: (){
            widget.Toggle();
    },
      label: Text('Sign In'),
      icon: Icon(Icons.person),
          ),
        ],
        backgroundColor: Colors.brown[800],
        title: Text('Register to Brew Crew'),
      ),
      body: Container(
        child: Form(
          key:_formkey,
          child: Column(
            children: [
              SizedBox(height: 30.0),
              TextFormField(
                validator: (val) => val.isEmpty? "Enter a valid email " : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.length < 6? "Enter a password of more than 6 characters " : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });

                },
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                ),
              ),
              TextButton(
                onPressed: () async {
                  if(_formkey.currentState.validate()) {
                    dynamic result = await _auth.registerInwithEmailandPassword(email, password);
                    if(result==null){
                      setState(() {
                        error='Please Supply a valid email';
                      });
                    }
                  }
                },
                style: TextButton.styleFrom(
                  primary: Colors.brown,
                ),
                child: Text('Register'),

              ),
              SizedBox(height: 20.0,),
              Text(
                error,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
