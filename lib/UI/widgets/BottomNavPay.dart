import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final  route;
  BottomNav(this.route);
  @override
  Widget build(BuildContext context) {



    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor
      ),
      child: Padding(padding: const EdgeInsets.only(top:0,bottom:0,right: 30,left: 30),

        child: Row(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: <Widget>[
//            Row(
//              children: <Widget>[
//                Text("المجموع: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
//                Text("0ر.س",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
//              ],
//            ),

            InkWell(
              child: Text("متابعة الشراء",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),
              onTap: (){

                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>route));
              },
            )
          ],
        ),
      ),
    );
  }
}
