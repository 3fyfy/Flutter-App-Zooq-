import 'file:///E:/Flutter/IntelliJIDEAProjects/app_zooq/app_zooq/lib/UI/widgets/GridViewProd.dart';
import 'package:app_zooq/Core/services/cart_controller.dart';
import 'package:app_zooq/Core/services/mainProvider.dart';
import 'package:app_zooq/UI/views/productdetails.dart';
import 'package:app_zooq/UI/widgets/AutoText.dart';
import 'package:app_zooq/UI/widgets/HeaderGridView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




//Screens


class ShopMen extends StatefulWidget {
  final String title;
  ShopMen(this.title);
  @override
  _ShopMenState createState() => _ShopMenState(this.title);
}

class _ShopMenState extends State<ShopMen> {
  final String title;
  _ShopMenState(this.title);
  final CartController cartController=CartController();



  @override
  Widget build(BuildContext context) {


    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
        appBar: AppBar(
        title:AutoText(text:title ,size: 20,color: Colors.black),

    centerTitle: true,
    leading:Image(image:AssetImage('images/icon-logo3.png')) ,
    actions: <Widget>[
    IconButton(icon: Icon(Icons.shopping_cart), onPressed:(){
      Navigator.of(context).pushNamed('/cart');
    }),
    IconButton(icon: Icon(Icons.arrow_back_ios,textDirection: TextDirection.ltr
    ,), onPressed: (){Navigator.of(context).pop();}),
    ],
    ),


          body: GridViewProd()


        )

    );
  }
}
