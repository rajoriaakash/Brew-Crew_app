import 'package:brew_crew/Models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create user object based on firebase user
  Userc _userfromFirebaseUser(User user) {
    return user != null ? Userc(uid : user.uid) : null;
  }

  //auth change user stream
  Stream<Userc> get user{
    return _auth.authStateChanges()
    .map ((User user) =>_userfromFirebaseUser(user));
  }

  // sign in anonymously
  Future signInAnon() async {
  try{
    UserCredential result = await _auth.signInAnonymously();
    User user = result.user;
    return _userfromFirebaseUser(user);

  }
  catch(e) {
    print(e.toString());
    return null;

  }
  }

  //sign in with email and password
  Future signInwithEmailandPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userfromFirebaseUser(user);

    }catch(e) {
      print(e.toString());
      return null;

    }
  }

  //register with email and password
  Future registerInwithEmailandPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      //Create a new document for the user with uid
      await DatabaseService(uid: user.uid).updateUserData('2', 'Akash ', 100);
      return _userfromFirebaseUser(user);

    }catch(e) {
      print(e.toString());
      return null;

    }
  }

  //sign out
Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
}
}