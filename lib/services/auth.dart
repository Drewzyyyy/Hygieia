import 'package:firebase_auth/firebase_auth.dart';
import 'package:hygieia/models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user obj based on Firebase user
  AppUser _userFromFirebaseUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<AppUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Sign as Anonymous
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }

  // Sign in with email and password

  // Register with email and password

  // Sign out

}