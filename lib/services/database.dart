import 'package:brew_crew/Models/brew.dart';
import 'package:brew_crew/Models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String name, String sugars,  int strength) async{
    return await brewCollection.doc(uid).set({
      'name' : name,
      'sugars' : sugars,
      'strength' : strength,
    });
  }

  //brew list from snapshot
  List<Brew> _brewListfromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
        name: doc.data()['name'] ?? '',
        sugars: doc.data()['sugars'] ?? 0,
        strength: doc.data()['strength'] ?? '0',

      );

    }).toList();

  }
  //user data from snapshot
  UserData _userDatafromsnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      sugars: snapshot.data()['sugars'],
      strength: snapshot.data()['strength'],


    );
  }
  //get brews stream
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots()
    .map(_brewListfromSnapshot);
}

  //get user doc stream
  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots()
    .map(_userDatafromsnapshot);
  }
}
