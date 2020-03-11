import 'package:app_zooq/UI/widgets/AutoText.dart';
import 'package:app_zooq/UI/widgets/carousel.dart';
import 'package:flutter/material.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share/share.dart';

class Product extends StatefulWidget {
final DocumentSnapshot document;

 Product(this.document);

  @override
  _ProductState createState() => _ProductState(document);
}

class _ProductState extends State<Product> {
   DocumentSnapshot document;

  _ProductState(this.document);

  DocumentSnapshot documentSnapshot;

  Widget _buildTopCarousel(){

    return Padding(
        padding: const EdgeInsets.only(top:30,bottom:0,right: 20,left: 20),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.all(Radius.circular(6))

          ),

          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:10,bottom:0,right: 20,left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("${document['price']} ر.س",style: TextStyle(fontSize: 15,color:Theme.of(context).accentColor,fontWeight: FontWeight.bold )),
                    Row(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.share,size: 20,), onPressed: (){
                            Share.share('check out my website https://example.com');
                          },padding: EdgeInsets.all(2),alignment: Alignment.centerLeft,),
                          IconButton(icon:(document['favourite'])?Icon(Icons.favorite):Icon(Icons.favorite_border),color:(document['favourite'])?Theme.of(context).accentColor:Colors.grey ,iconSize: 15,
                              onPressed: ()async{

                                await Firestore.instance.collection('Product').document(document.documentID).updateData({'favourite': !document['favourite'],});
                                if(document['favourite']) {
                                  Firestore.instance.collection("Favourite").document(document.documentID).delete();
                                  await Firestore.instance.collection('Product').document(document.documentID)
                                      .updateData({'favourite': false,});

                                }
                                else {

                                  Firestore.instance.collection('Favourite').document(document.documentID).setData(document.data);
                                  await Firestore.instance.collection('Favourite').document(document.documentID).updateData({'favourite':true,});

                                }
setState(() {
  document.data['favourite']=!document.data['favourite'];

});
                              })
                        ],
                      ),

                  ],
                ),
              ),
            ],
          ),
        )
    );
  }


Widget _buildBottomCarousel(){
   double width=MediaQuery.of(context).size.width;
 return Container(
   alignment: Alignment.center,

      padding: const EdgeInsets.only(top:0,bottom:0,right: 40,left: 40),
      width:MediaQuery.of(context).size.width ,
      child: Column(
mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:0,bottom:0,right: 40,left: 40),
            child: Text("${document['description']}  ",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ),maxLines: 2),
          ),

          Padding(
            padding: const EdgeInsets.only(top:30,bottom:0,right: 0,left: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: <Widget>[
                Row(
                  children: <Widget>[
                    AutoText(text:"الماركة: " ,),
                    AutoText(text:"${document['brand']}",color:Theme.of(context).accentColor,fontWeight: FontWeight.bold ),

                  ],
                ),

                Row(
                  children: <Widget>[
                    AutoText(text:"النوع: " ,),
                    AutoText(text:"${document['type']}",color:Theme.of(context).accentColor,fontWeight: FontWeight.bold ),

                  ],
                )

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:30,bottom:0,right: 0,left: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: <Widget>[

                Container(child: AutoText(text:"100% اصلي " )),
                Container(child: AutoText(text:"الدفع عند الاستلام")),
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: _buildButton(),
          )
        ],
      ),

  );
}


  Widget _buildButton(){

    return Padding(
      padding: const EdgeInsets.only(top:10.0,bottom: 2),
      child: Padding(
      padding: const EdgeInsets.only(top:0.0,bottom: 2),
      child: InkWell(
      onTap: ()async{

      if(document['cart']){

      await Firestore.instance.collection('Cart').document(document.documentID).delete();
      await Firestore.instance.collection('Product').document(document.documentID).updateData({'cart':false});


      }
      else{
      await Firestore.instance.collection('Product').document(document.documentID).updateData({'cart':true});
      Firestore.instance.collection('Cart').document(document.documentID).setData(document.data);
      Firestore.instance.collection('Cart').document(document.documentID).updateData({'quantity':1,'total_price':document['price']});

      }
      setState(() {
        document.data['cart']=!document.data['cart'];
      });

      },
      child: Container(

      width: MediaQuery.of(context).size.width/3,
      decoration: BoxDecoration(
      color: Theme.of(context).accentColor,
      border: Border.all(color: Theme.of(context).accentColor,style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(20))

    ),
    child: Container(
    width:  (MediaQuery.of(context).size.width/3)-10,
    decoration: BoxDecoration(
    color: Theme.of(context).accentColor,
    border: Border.all(color: Colors.white,style: BorderStyle.solid),
    borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Center(
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,

    children: <Widget>[
    Image(image: AssetImage("images/logo-shopcar.png"),width:20,),
    SizedBox(width: 5,),
    AutoText(text:(!document['cart'])?"اضف للسلة":"ازالة من السلة" ,size:10,color:Colors.white ,),
    ],
    )),
    ))),
    ));
  }

  Widget _buildBody()
  {
    return ListView(
      children: <Widget>[
        Stack (
          children:<Widget>[

            Container(
                height:MediaQuery.of(context).size.height/2 ,
                color: Theme.of(context).accentColor,

            ),
            _buildTopCarousel(),


            Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(top:80.0,right: 20,left: 20),
                  child: Container(
                    height:(MediaQuery.of(context).size.height/2)-40 ,
                    child:CarouselImage(images: document['images'],),
                  ),
                ),
                _buildBottomCarousel()
              ],
            ),


          ]
        ),



      ],
    );

  }



  @override
  Widget build(BuildContext context) {




//  double width=MediaQuery.of(context).size.width;
//    double height=MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text(document['title'],
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
                ,), onPressed: (){  Navigator.pop(context);
              }),
            ],
          ),

          body:_buildBody()

      ),
    );

  }
}
