import 'package:app_zooq/Core/services/mainProvider.dart';
import 'package:app_zooq/UI/views/Mainnavbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/GridViewProd.dart';


class Favourite extends StatefulWidget {

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {



  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    mainProvider.collectionName='Favourite';
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("المفضلة",
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
                ,), onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Mainnavbar()));
              },)

            ],
          ),

          body:  GridViewProd()


        )

    );
  }
}
