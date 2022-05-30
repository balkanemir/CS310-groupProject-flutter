import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterui/models/User.dart';
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser

  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ?  UserModel(
        profile_image:
        'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
        id: user.uid,
        name: 'Jeniffer',
        surname: 'Lawrance',
        username: 'Jeniffer123',
        email: 'Jan@example.com',
        MBTI_type: 'ESFP',
        following: 34,
        followers: 126) : null ;
  }

  // auth change user stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges()
    //.map((User? user) => _userFromFirebaseUser(user));
    .map(_userFromFirebaseUser);

  }

  // login with email & password
  Future<dynamic> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found') {
        return e.message ?? 'E-mail and/or Password not found';
      }
      else if(e.code == 'wrong-password') {
        return e.message ?? 'Password is not correct';
      }
    }
    catch(e) {
      return e.toString();
    }
  }


  // register with email & password
  Future<dynamic> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }
    on FirebaseAuthException catch (e) {
      print(e.toString());
      if(e.code == 'email-already-in-use') {
        return e.message ?? 'E-mail already in use';
      } else if (e.code == 'weak-password') {
        return e.message ?? 'Ypur password is weak';
      }
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }
}