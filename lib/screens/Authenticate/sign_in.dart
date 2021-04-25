
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function Toggle;
  SignIn({this.Toggle});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  bool loading = false;
  String email='';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.03),
            ),
            onPressed: (){
              widget.Toggle();
            },
            label: Text(
                'Register',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            icon: Icon(
                Icons.person_add,
              color: Colors.black,
            ),
          )
        ],
        backgroundColor: Colors.brown[800],
        title: Text('Sign In to Brew Crew'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Form(
            key:_formkey,
            child: Column(
              children: [
                SizedBox(height: 10.0),
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
                SizedBox(height:30.0),
                TextButton(
                  onPressed: () async{
                    if(_formkey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInwithEmailandPassword(email, password);
                      if(result==null){
                        setState(() {
                          error='The email or password(or both) you entered is incorrect';
                          loading = false;
                        });
                      }
                    }

                  },
                  style: TextButton.styleFrom(
                      primary: Colors.brown,
                    backgroundColor: Colors.white.withOpacity(0.2),
                  ),
                  child: Text('Sign In'),

                ),
                SizedBox(height: 20.0,),
                Text(
                  error,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
