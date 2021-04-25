import 'package:brew_crew/Models/brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.brown[brew.strength],
          backgroundImage: AssetImage('assets/coffee_icon.png'),
        ),
        title: Text(brew.name),
        subtitle: Text("Takes ${brew.sugars} sugars"),
      ),
    );
  }
}
