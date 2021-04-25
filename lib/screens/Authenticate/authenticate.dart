import 'package:brew_crew/screens/Authenticate/register.dart';
import 'package:brew_crew/screens/Authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void Toggle() {
    setState(() {
      showSignIn = !showSignIn;
    });

  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn==true) {
      return SignIn(Toggle: Toggle,);
    }
    else{
      return Register(Toggle: Toggle,);
    }
  }
}
