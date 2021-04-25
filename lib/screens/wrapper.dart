import 'package:brew_crew/Models/user.dart';
import 'package:brew_crew/screens/Authenticate/authenticate.dart';
import 'package:brew_crew/screens/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userc>(context);
    if (user == null) {
      return Authenticate();
    }
    else {
      return Home();
    }
  }
}
