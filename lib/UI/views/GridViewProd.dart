import 'package:app_zooq/Core/services/cart_controller.dart';
import 'package:app_zooq/UI/views/productdetails.dart';
import 'package:app_zooq/UI/widgets/AutoText.dart';
import 'package:app_zooq/UI/widgets/HeaderGridView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class GridViewProd extends StatefulWidget {
  final String collectionName;
  GridViewProd(this.collectionName);
  @override
  _GridViewProdState createState() => _GridViewProdState(this.collectionName);
}

class _GridViewProdState extends State<GridViewProd> {
  final CartController cartController=CartController();

  final String collectionName;
  _GridViewProdState(this.collectionName);

//  Widget _buildButton(DocumentSnapshot document){
//    return ;
//  }


  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    double heightItem=height/3;

    return  Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        children: <Widget>[
          Header(),
          Container(
            width: width,
            height: height-kBottomNavigationBarHeight-kToolbarHeight,
            child: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(collectionName)
          .snapshots(),
      builder: (BuildContext context,
      AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError)
      return new Text('Error: ${snapshot.error}');

      switch (snapshot.connectionState) {
      case ConnectionState.waiting:
      return new Text('Loading...');
      default:
            return  GridView(

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1) ,


        children:
      snapshot.data.documents.map((DocumentSnapshot document){
            return  (document.data!=null)?Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
            height: heightItem,
            decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5))),

            child: Column(
        children: <Widget>[

        Container(
        width: (MediaQuery.of(context).size.width/2),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: heightItem/4,
            child: Stack(

              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:7.0),
                  child: InkWell(

                    onTap: ()async{
                      await Navigator.push(context, MaterialPageRoute(builder: (context)=>Product(document)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image:DecorationImage(image: ( document['images'] != null )?NetworkImage( document['images'][2],):null),


                      ),

                    ),
                  ),
                ),
                Positioned(
                    left: 0,
                    top: 0,
                    child: IconButton(icon:(document['favourite'])?Icon(Icons.favorite):Icon(Icons.favorite_border),color:(document['favourite'])?Theme.of(context).accentColor:Colors.grey ,iconSize: 15,
                        onPressed: ()async{
                          await Firestore.instance.collection('Product').document(document.documentID)
                              .updateData({'favourite': !document['favourite'],});
                          if(document['favourite']) {
                            Firestore.instance.collection("Favourite").document(document.documentID).delete();
                            await Firestore.instance.collection('Product').document(document.documentID)
                                .updateData({'favourite': false,});

                          }
                          else {

                            Firestore.instance.collection('Favourite').document(document.documentID).setData(document.data);
                            await Firestore.instance.collection('Favourite').document(document.documentID)
                                .updateData({'favourite':true,});

                          }
                          print(document['favourite']);
                        })
                )
              ],
            ),
          ),
        AutoText(text:document['title'] ,size: 20,lines: 1,),

        AutoText(text:"${document['price']} ريال",size: 15,color:Theme.of(context).accentColor,fontWeight: FontWeight.bold ,lines: 1,),
        //  )
        Padding(
          padding: const EdgeInsets.only(top:0.0,bottom: 0),
          child: InkWell(
              onTap: ()async{
                cartController.addCart.add(document['price']);


                await Firestore.instance.collection(collectionName).document(document.documentID).updateData({'cart':!document['cart']});


                if(document['cart']){
//
                  await Firestore.instance.collection('Cart').document(document.documentID).delete();
                  await Firestore.instance.collection('Product').document(document.documentID).updateData({'cart':false});

                }
                else{
                  await Firestore.instance.collection('Product').document(document.documentID).updateData({'cart':true});
                  Firestore.instance.collection('Cart').document(document.documentID).setData(document.data);
                  Firestore.instance.collection('Cart').document(document.documentID).updateData({'quantity':1,'total_price':document['price']});

                }

              },
              child: Container(

                  width: MediaQuery.of(context).size.width/3,
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      border: Border.all(color: Theme.of(context).accentColor,style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(20))

                  ),
                  child: Container(
                    width:  (MediaQuery.of(context).size.width/3),
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        border: Border.all(color: Colors.white,style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(image: AssetImage("images/logo-shopcar.png"),width: 10,),
                            SizedBox(width: 3,),
                            AutoText(text:(!document['cart'])?"اضف للسلة":"ازالة من السلة" ,size: 10,color:Colors.white,fontWeight: FontWeight.bold ,lines: 1,),
                          ],
                        )),
                  ))),
        )

        ],
        ),
        ),
        ),

       // BuildButton



        ],
        )
            )
            ):null ;

            }).toList()

      );
      }
      },
            ),
          ),

        ],
      ),
    );

}
}





