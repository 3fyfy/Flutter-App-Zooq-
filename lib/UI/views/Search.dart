import 'package:app_zooq/UI/views/Mainnavbar.dart';
import 'package:app_zooq/UI/views/SearchResults.dart';
import 'package:app_zooq/UI/widgets/ButtonLogin.dart';
import 'package:flutter/material.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {


  Widget _buildBodyLogin(){
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return  ListView(
      children: <Widget>[
        Container(
          width: width,
          height: height,
          color: Theme.of(context).accentColor,

          child: Padding(
            padding: const EdgeInsets.only(top:30,bottom:150,right: 20,left: 20),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.all(Radius.circular(6))

              ),
              child: ListView(
                children: <Widget>[

              Padding(
              padding: const EdgeInsets.only(top: 20,right: 25,left: 15),
              child: TextFormField(
                obscureText: false,

                decoration: InputDecoration(
                    hintText: "عن ماذا تبحث",

                    border:UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid,),),

                    //OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Colors.white)),
                    hintStyle: TextStyle(fontSize: 16),


              ),
                cursorColor: Theme.of(context).accentColor,

              )
              ),

              ButtonLogin("بحث",SerachResults() ),






                ],
              ),

            ),
          ),
        )
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text("بحث",
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

              }),
            ],
          ),


          body:_buildBodyLogin()

      ),
    );
  }
}
