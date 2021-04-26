import 'package:brew_crew/Models/brew.dart';
import 'package:brew_crew/screens/Home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          height: 1000.0,
          padding: EdgeInsets.symmetric(vertical: 20.0 , horizontal: 30.0),
          child: SettingsForm(),
        );

      });
    }
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: Text('Brew Crew'),
              actions: <Widget>[
                TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.03),
                    ),
                    onPressed: () async{
                      await _auth.signOut();
                    },
                    icon: Icon(
                        Icons.person,
                      color: Colors.black,
                    ),
                    label: Text(
                        'Logout',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.03),
                  ),
                  onPressed: () {
                    _showSettingsPanel();
                  },
                  icon: Icon(
                      Icons.settings,
                  color: Colors.black,),
                  label:Text(
                      'Settings',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                )
              ]
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              )
            ),
              child: BrewList()
          ),
      ),
    );
  }
}
