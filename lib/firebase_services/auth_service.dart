import 'package:firebase_auth/firebase_auth.dart';
import 'package:products/models/user_model.dart';

class AuthenticationService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User> get user{
    return auth.authStateChanges();
  }

  Future signIn(UserModel user) async {
    try{
      await auth.signInWithEmailAndPassword(email: user.email, password: user.password);
      return "success";
    }
    catch(e){
      if(e.code == 'wrong-password') {
        return "wrong pass";
      }
      return e.message;
    }
  }

  Future signUp(UserModel user) async {
    try{
      await auth.createUserWithEmailAndPassword(email: user.email, password: user.password);
      return "success";
    }
    catch(e) {
      print(e.code);
      if (e.code == "email-already-in-use") {
        return "email in use";
      }
      return e.message;
    }
  }

  Future signOut() async {
    try{
      return await auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}