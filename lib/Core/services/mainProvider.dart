import 'dart:io';

import 'package:app_zooq/Core/services/user_controller.dart';
import 'package:app_zooq/UI/widgets/GridViewProd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MainProvider  with ChangeNotifier{


  AsyncSnapshot<QuerySnapshot> _snapshot;
   String _collectionName='';

  bool _loading=false;
  bool _cartIsEmpty=true;
  bool _gridOne=true;
  String _order='more';
  File _image;

  File get image=>_image;

  set image(value){
    _image=value;
    notifyListeners();
  }


  String get order=>_order;

  set order(value){

    _order=value;
    notifyListeners();
  }


  bool get gridOne=>_gridOne;

  set gridOne(value){

    _gridOne=value;
    notifyListeners();


  }


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