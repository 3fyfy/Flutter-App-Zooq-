import 'package:app_zooq/UI/views/GridViewProd.dart';
import 'package:app_zooq/UI/widgets/AutoText.dart';
import 'package:flutter/material.dart';




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

  @override
  Widget build(BuildContext context) {

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
        appBar: AppBar(
        title:AutoText(text:title ,size: 20,),

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

          body:GridViewProd('Product')

        )

    );
  }
}
