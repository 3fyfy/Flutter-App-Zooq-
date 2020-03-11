import 'package:app_zooq/Core/services/firebase_auth.dart';



class UserController {
  FirebaseAuthintication   _firebaseAuthintication=FirebaseAuthintication();

  loginController(String email,String password)async{
   var user= await _firebaseAuthintication.login(email, password);
   return user;
  }

  currentUserController()async{
    var user= await _firebaseAuthintication.getCurrenUser();

    return user;

  }
  registerController(String email,String password)async{

    var user=await _firebaseAuthintication.register(email, password);
    print("asasassasasasasasasas ${user.toString()}");

  }

  logOutController(){

    _firebaseAuthintication.signOut();


  }



}