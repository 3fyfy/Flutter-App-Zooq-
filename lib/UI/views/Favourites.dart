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

  bool flag=false;
  static String _selection;


  void _onItemTapped(String value) {
    final mainProvider = Provider.of<MainProvider>(context);

    _selection = value;
    setState(() {
      mainProvider.order=value;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>Favourite() ,));


    });

  }

  Widget popUP(){
    final mainProvider = Provider.of<MainProvider>(context);

    return  PopupMenuButton<String>(
      enabled: true,
      onSelected: _onItemTapped,

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(image: AssetImage("images/icon-popover.png"),),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'more',
          child: Text('الاعلى سعرا'),
        ),
        const PopupMenuItem<String>(
          value: 'less',
          child: Text('الاقل سعرا'),
        ),
      ],

    );
  }

  Widget Header(){
    final mainProvider = Provider.of<MainProvider>(context);
    mainProvider.collectionName='Favourite';

    return Container(
      height: 30,
      color: Theme.of(context).accentColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          popUP(),
          IconButton(icon:Image(image: AssetImage("images/icon-menu.png")),onPressed: (){
            mainProvider.gridOne=!mainProvider.gridOne;
          },),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context);
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

            body: Container(
              height: height,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ListView(
                  children: <Widget>[
                    Header(),
                    GridViewProd(mainProvider.order,'Favourite'),

                  ],
                ),
              ),
            )


        )

    );
  }
}