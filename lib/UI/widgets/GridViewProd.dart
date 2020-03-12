import 'package:app_zooq/Core/services/cart_controller.dart';
import 'package:app_zooq/Core/services/mainProvider.dart';
import 'package:app_zooq/UI/views/productdetails.dart';
import 'package:app_zooq/UI/widgets/AutoText.dart';
import 'package:app_zooq/UI/widgets/HeaderGridView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class GridViewProd extends StatefulWidget {

  @override
  _GridViewProdState createState() => _GridViewProdState();
}

class _GridViewProdState extends State<GridViewProd> {
  final CartController cartController=CartController();

  @override
  Widget build(BuildContext context) {

    final mainProvider = Provider.of<MainProvider>(context);

    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    double heightItem=height*.4;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        children: <Widget>[
          Header(),
          Container(
            width: width,
            height: height-kBottomNavigationBarHeight-kToolbarHeight,
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection(mainProvider.collectionName)
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

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                          childAspectRatio: (width/2)/heightItem,) ,


                        children:snapshot.data.documents.map((DocumentSnapshot document){
                          return  (document.data!=null)?Padding(
                              padding:  EdgeInsets.all(3.0),

                              child: Container(
                                  height: heightItem,
                                  width: width/2,

                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red, width: 1),
                                      borderRadius: BorderRadius.all(Radius.circular(5))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: (MediaQuery.of(context).size.width/2),
                                        height: heightItem-8,
                                        child: Stack(
                                          alignment:Alignment.center,
                                          children: <Widget>[
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
                                            ),

                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  height: heightItem/3,
                                                  padding: EdgeInsets.only(top: heightItem*.01),
                                                  child: InkWell(
                                                    onTap: ()async{
                                                      await Navigator.push(context, MaterialPageRoute(builder: (context)=>Product(document)));
                                                    },
                                                    child: Container(
                                                      child: Image(image: ( document['images'] != null )?NetworkImage( document['images'][2],):null,fit: BoxFit.cover,),
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  height: heightItem/3,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Expanded(child: Text('${document['title']}',maxLines: 1, )),

                                                      Expanded(child: Text("${document['price']} ريال",maxLines: 1,)),
                                                    ],
                                                  ),
                                                ),

                                                Container(
                                                  height: heightItem/5,
                                                  child: InkWell(
                                                      onTap: ()async{
                                                        cartController.addCart.add(document['price']);


                                                        await Firestore.instance.collection('Product').document(document.documentID).updateData({'cart':!document['cart']});


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
                                                            alignment: Alignment.center,
                                                            padding: EdgeInsets.only(left: 5,right: 5),
                                                            decoration: BoxDecoration(
                                                                color: Theme.of(context).accentColor,
                                                                border: Border.all(color: Colors.white,style: BorderStyle.solid),
                                                                borderRadius: BorderRadius.all(Radius.circular(20))),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Image(image: AssetImage("images/logo-shopcar.png"),width: 20,fit: BoxFit.cover,),
                                                                SizedBox(width: 3,),
                                                                Expanded(child: Text((!document['cart'])?"اضف للسلة":"ازالة من السلة" ,style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),maxLines: 1,textAlign: TextAlign.center,)),
                                                              ],
                                                            ),
                                                          ))),
                                                )

                                              ],
                                            ),
                                          ],
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





