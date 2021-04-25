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
                  onPressed: () {
                    _showSettingsPanel();
                  },
                  icon: Icon(Icons.settings),
                  label:Text('Settings'),
                )
              ]
          ),
          body: BrewList(),
      ),
    );
  }
}
