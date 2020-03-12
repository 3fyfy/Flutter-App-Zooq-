import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MainProvider  with ChangeNotifier{

  AsyncSnapshot<QuerySnapshot> _snapshot;
   String _collectionName='';

  bool _loading=false;
  bool _cartIsEmpty=true;

  bool get cartIsEmpty=>_cartIsEmpty;

  set cartIsEmpty(value){

    _cartIsEmpty=value;
    notifyListeners();


  }

  bool get loading=>_loading;

  set loading(value){

    _loading=value;
    notifyListeners();


  }

  AsyncSnapshot<QuerySnapshot> get snapshot =>_snapshot;

  set snapshot (value){

    _snapshot=value;
    notifyListeners();

  }


  String get collectionName=>_collectionName;

  set collectionName(value){
    _collectionName=value;
    notifyListeners();
  }

}