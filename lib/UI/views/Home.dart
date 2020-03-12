import 'package:app_zooq/Core/services/mainProvider.dart';
import 'package:app_zooq/UI/widgets/AutoText.dart';
import 'package:app_zooq/UI/widgets/Search.dart';
import 'package:app_zooq/UI/widgets/bghome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ListProduct.dart';
import 'men3tor.dart';





class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {





  Widget _buildImageBottom(String image,String title) {
    return Padding(
      padding: const EdgeInsets.only(top:5.0,bottom: 5),
      child: InkWell(
        onTap: (){
          final mainProvider = Provider.of<MainProvider>(context);
          mainProvider.collectionName='Product';
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopMen(title)));
        },
        child: Container(
          child: Image(image: AssetImage(image)),
        ),
      ),
    );

  }


  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      //padding: EdgeInsets.all(0),
      child: ListView(

        children: <Widget>[
          BgHome(),

          Padding(
            padding: const EdgeInsets.only(top:15.0,right: 20,left: 20,bottom: 10),
            child: Search(),
          ),

          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10,left: 10,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AutoText(text:"عطور مميزة" ,size: 20,color:Theme.of(context).accentColor,),

                InkWell(child:
                AutoText(text:"عرض الكل" ,size: 20,),
                  onTap: (){
                    setState(() {
                      final mainProvider = Provider.of<MainProvider>(context);
                      mainProvider.collectionName='Product';
                    });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopMen("عطور مميزة")));

                },),


              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),

      Padding(
        padding: const EdgeInsets.only(right:10.0,left: 10),
         child: ListProd(),
      ),


          SizedBox(
            height: 50,
          ),

          _buildImageBottom('images/bg-Home-men3tor.png',"عطور رجالي"),
          _buildImageBottom("images/bg-Home-women3tor.png","عطور نسائي"),
          _buildImageBottom("images/childimg.png","عطور اطفال")


        ],
      ),
    );
  }
}
