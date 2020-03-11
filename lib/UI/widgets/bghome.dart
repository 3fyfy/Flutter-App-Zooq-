import 'package:app_zooq/UI/views/men3tor.dart';
import 'package:app_zooq/UI/widgets/AutoText.dart';
import 'package:flutter/material.dart';



class BgHome extends StatelessWidget {



 @override
  Widget build(BuildContext context) {
   double heightBgHome= MediaQuery.of(context).size.height/4;
   double widthBgHome= MediaQuery.of(context).size.width;
   print(widthBgHome);

    return Stack(
      alignment: Alignment.topCenter,

      children: <Widget>[
        Container(
          height: heightBgHome+120,
          color: Colors.white,
          width: widthBgHome,

        ),

        Container(
          height: (heightBgHome)+50,

          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("images/bg-Home-firstrow.png"),fit: BoxFit.cover)
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(193, 1, 52, .7),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right:8.0,left: 8,top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      AutoText(text:"تخفيضات" ,size: 15,color: Colors.black,fontWeight: FontWeight.bold,),
                      IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white,), onPressed: (){
                        Navigator.of(context).pushNamed('/cart');                      })

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right:8.0,left: 8,top: 5),
                  child: Row(
                    children: <Widget>[
                      AutoText(text:"هائلة على العطور الرجالي" ,size: 15,color: Colors.white,),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:8.0,left: 8,top: 5),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.arrow_back,textDirection: TextDirection.ltr,color: Colors.white,),
                      InkWell(child: AutoText(text:"تسوق الان" ,size: 15,color: Colors.white,),

                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopMen("عطور رجالي")));

                        },
                      ),
                    ],
                  ),
                ),


              ],
            ),

          ),
        ),

        Positioned(
            top: heightBgHome ,
            //left: (widthBgHome)-50,
            right: (widthBgHome/2)-50,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(.2, .3),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Center(
                child: Image(image: AssetImage("images/icon-logo3.png"),width: 50,),
              ),
            )),

      ],
    );
  }
}

