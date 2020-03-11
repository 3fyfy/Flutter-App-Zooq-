import 'package:app_zooq/UI/views/GridViewProd.dart';
import 'package:flutter/material.dart';



class SerachResults extends StatefulWidget {

  @override
  _SerachResultsState createState() => _SerachResultsState();
}

class _SerachResultsState extends State<SerachResults> {



  @override
  Widget build(BuildContext context) {
;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('نتائج البحث',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,

              ),),
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
