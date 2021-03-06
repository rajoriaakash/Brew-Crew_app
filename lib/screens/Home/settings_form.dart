import 'package:brew_crew/Models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = [ '0','1','2','3','4','5'];

  //form values
  String _currentName;
  String _currentsugars;
  int _currentstrength;
  @override
  Widget build(BuildContext context) {

    Userc user = Provider.of<Userc>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      // ignore: missing_return
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;

          return Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                        'Update your brew settings',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.brown[900],
                      ),
                    ),
                    SizedBox(height: 30.0),
                    //TextFiled for name
                    TextFormField(
                      initialValue: userData.name,
                        decoration: InputDecoration(
                          hintText: 'Enter your name',
                        ),
                        validator: (val) => val.isEmpty? 'Please enter a name' : null,
                        onChanged: (val) {
                          setState(() {
                            _currentName = val;
                          });
                        }
                    ),
                    SizedBox(height: 20.0),
                    //dropdown for sugars
                    DropdownButtonFormField(
                      value: _currentsugars ?? '0',
                      items: sugars.map((sugar){
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text("$sugar sugars"),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _currentsugars = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0,),
                    //slider for strength
                    Slider(
                      value: (_currentstrength ?? userData.strength).toDouble()  ,
                      activeColor: Colors.brown[_currentstrength ?? userData.strength ],
                      inactiveColor: Colors.brown[_currentstrength ?? userData.strength ],
                      min: 100,
                      max: 900,
                      divisions: 8,
                      onChanged: (val) {
                        setState(() {
                          _currentstrength = val.round();
                        });
                      },
                    ),
                    SizedBox(height: 30.0),
                    //update button
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.brown[900].withOpacity(0.03),
                        padding: EdgeInsets.all(15.0)
                      ),
                      onPressed: () async{
                        if(_formkey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name,
                            _currentsugars ?? userData.sugars,
                            _currentstrength ?? userData.strength,
                          );
                        }
                        Navigator.pop(context);
                      },
                      child: Text(
                          'Update',
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 20.0,
                        ),
                      ),

                    )

                  ],
                ),
              ),

          );
        }else{
          return Loading();
        }

      }
    );
  }
}
