import 'package:app_zooq/Core/services/firebase_auth.dart';



class UserController {
static  FirebaseAuthintication   _firebaseAuthintication=FirebaseAuthintication();

  loginController(String email,String password)async{
   var user= await _firebaseAuthintication.login(email, password);
   return user;
  }

  currentUserController()async{
    var user= await _firebaseAuthintication.getCurrenUser();

    return user;

  }
  static currentUserEmailController()async{
    var user= await _firebaseAuthintication.getCurrenUser();
    String email =user.email.toString();
    List <String>name=email.split('@');

    return name[0];

  }

  registerController(String email,String password)async{

    var user=await _firebaseAuthintication.register(email, password);

  }

  logOutController(){

    _firebaseAuthintication.signOut();


  }



}