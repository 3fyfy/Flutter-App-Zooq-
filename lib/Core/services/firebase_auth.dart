import 'package:firebase_auth/firebase_auth.dart';


class FirebaseAuthintication{

  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;


 Future<FirebaseUser> login(String email,String password)async{
  AuthResult authResult=await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  return authResult.user;

  }

 Future<FirebaseUser> register(String email,String password)async{
  AuthResult authResult= await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

  return authResult.user;
  }

  Future<FirebaseUser>getCurrenUser()async{

    FirebaseUser user =await _firebaseAuth.currentUser();
    return user;


  }

  signOut()async{
    await _firebaseAuth.signOut();
  }

}