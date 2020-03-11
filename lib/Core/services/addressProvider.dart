import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AddressProvider with ChangeNotifier {

   TextEditingController _description = TextEditingController();
   TextEditingController _phone = TextEditingController();
   TextEditingController _notes = TextEditingController();
   TextEditingController _street = TextEditingController();
   String _city;
   bool _check=true;

  TextEditingController get description=>_description;
  TextEditingController get phone=>_phone;

  TextEditingController get notes=>_notes;
  TextEditingController get street=>_street;

  String get city=>_city;
  bool get check =>_check;

set city(value){
  _city=value;
  notifyListeners();
}

   set check(value){
     _check=value;
     notifyListeners();
   }


  set description(value){
    _description=value;
    notifyListeners();

  }


  set phone(value){
    _phone=value;
    notifyListeners();
  }

  set notes(value){
    _notes=value;
    notifyListeners();

  }

  set street(value){
    _street=value;
    notifyListeners();

  }


  @override
  void dispose(){
    _description.dispose();
    _notes.dispose();
    _phone.dispose();
    _street.dispose();


    super.dispose();

  }
}