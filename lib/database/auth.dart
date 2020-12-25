import 'package:bmsapp/classes/user.dart';
import 'package:bmsapp/database/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class authentication {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  HandleFirestore _handleFirestore = HandleFirestore();


  Future<bool> isSignedIn() async {
    return (await _firebaseAuth.currentUser()!=null);
  }
  Future<String> userID () async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }
  Future<void> delete () async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    await user.delete();
  }
  Future<String> email () async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.email;
  }

  Future<AppUser> signInEmail(String email, String password) async
  {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password); //Sign in with email and password
    FirebaseUser user = result.user; 
    String uid = user.uid;
    return await _handleFirestore.getAppUserInfo(uid);
  }
  Future<void> signOut () async {
    await _firebaseAuth.signOut();
  }

}

