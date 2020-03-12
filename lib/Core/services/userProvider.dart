import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserProvider with ChangeNotifier {

  TextEditingController _emailControllerLog=TextEditingController();
  TextEditingController _passwordControllerLog=TextEditingController();
  TextEditingController _emailControllerReg=TextEditingController();
  TextEditingController _passwordControllerReg=TextEditingController();
  bool _loading=false;

  bool get loading=>_loading;

  set loading(value){

    _loading=value;
    notifyListeners();


  }


  TextEditingController get emailControllerLog=>_emailControllerLog;
  TextEditingController get passwordControllerLog=>_passwordControllerLog;

  TextEditingController get emailControllerReg=>_emailControllerReg;
  TextEditingController get passwordControllerReg=>_passwordControllerReg;



  set emailControllerLog(value){
    _emailControllerLog=value;
    notifyListeners();

  }


  set passwordControllerLog(value){
    _passwordControllerLog=value;
    notifyListeners();
  }

  set emailControllerReg(value){
    _emailControllerReg=value;
    notifyListeners();

  }

  set passwordControllerReg(value){
    _passwordControllerReg=value;
    notifyListeners();

  }


  @override
  void dispose(){
    _emailControllerLog.dispose();
     _passwordControllerLog.dispose();
     _emailControllerReg.dispose();
     _passwordControllerReg.dispose();


    super.dispose();

  }
}