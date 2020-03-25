import 'dart:async';

import 'package:app_zooq/Core/services/cart_controller.dart';
import 'package:app_zooq/Core/services/mainProvider.dart';
import 'package:app_zooq/UI/views/productdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


class GridViewProd extends StatefulWidget {

final String order;
final String nameCollection;


GridViewProd(this.order,this.nameCollection);

@override
  _GridViewProdState createState() => _GridViewProdState();
}

class _GridViewProdState extends State<GridViewProd> {

  bool loading=true;


  final CartController cartController=CartController();
  ScrollController _scrollController = ScrollController();
List<DocumentSnapshot> _products=[];
  DocumentSnapshot _lastDocument;
  int morelimit=5;

bool _loadingProducts=true;
bool loading_more=true;
bool _moreProductsAvailable=true;




  Future favoriteCondition(DocumentSnapshot document)async{

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

    setState(() {
    });
  }

  Future cardCondition(DocumentSnapshot document)async{


    cartController.addCart.add(document['price']);
    if(document['cart']){
//
      await Firestore.instance.collection('Cart').document(document.documentID).delete();
      await Firestore.instance.collection('Product').document(document.documentID).updateData({'cart':false});

      final snackBar = SnackBar(
        content: Text('تمت ازالة ${document['title']}  من السلة',style: TextStyle(color: Colors.white),),
        action: SnackBarAction(
          label: '',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
        backgroundColor: Theme.of(context).accentColor,

      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
    else{
      await Firestore.instance.collection('Product').document(document.documentID).updateData({'cart':true});
      Firestore.instance.collection('Cart').document(document.documentID).setData(document.data);
      Firestore.instance.collection('Cart').document(document.documentID).updateData({'quantity':1,'total_price':document['price'],'cart':true});

      final snackBar = SnackBar(
        content: Text(' تمت اضافة${document['title']} الى السلة ',style: TextStyle(color: Colors.white),),
        action: SnackBarAction(
          label:'',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
        backgroundColor: Theme.of(context).accentColor,

      );

      Scaffold.of(context).showSnackBar(snackBar);
    }

  }

//Widget Item(DocumentSnapshot document,int index){
//
//  double width=MediaQuery.of(context).size.width;
//  double height=MediaQuery.of(context).size.height;
//  double heightItem=height*.5;
//
//  bool fav=_products[index]['favourite'];
//
//  return Stack(
//      alignment:Alignment.center,
//      children: <Widget>[
//        Positioned(
//            left: 0,
//            top: 0,
//            child: IconButton(icon:(fav)?Icon(Icons.favorite):Icon(Icons.favorite_border),color:(fav)?Theme.of(context).accentColor:Colors.grey ,iconSize: 15,
//                onPressed: (){
//
//                  setState(() async{
//                    favoriteCondition(document);
//                    _products[index]=await Firestore.instance.collection('Product').document(document.documentID).get();
//                   print(_products[index]['favourite']);
//
//                  });
//                })
//        ),
//
//        Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Container(
//              height: heightItem/3,
//              padding: EdgeInsets.only(top: heightItem*.01),
//              child: InkWell(
//                onTap: ()async{
//                  await Navigator.push(context, MaterialPageRoute(builder: (context)=>Product(document)));
//                },
//                child: Container(
//                  child: Image(image: ( document['images'] != null )?NetworkImage( document['images'][2],):null,fit: BoxFit.cover,),
//                ),
//              ),
//            ),
//
//            Container(
//              height: heightItem/3,
//              child: Column(
//                children: <Widget>[
//                  Expanded(child: Text('${document['title']}',maxLines: 1, )),
//
//                  Expanded(child: Text("${document['price']} ريال",maxLines: 1,)),
//                ],
//              ),
//            ),
//
//            Container(
//              height: heightItem/5,
//              child: InkWell(
//                  onTap: ()async{
//
//                    await cardCondition(document);
//
//                  },
//                  child: Container(
//
//                      width: MediaQuery.of(context).size.width/3,
//                      decoration: BoxDecoration(
//                          color: Theme.of(context).accentColor,
//                          border: Border.all(color: Theme.of(context).accentColor,style: BorderStyle.solid),
//                          borderRadius: BorderRadius.all(Radius.circular(20))
//
//                      ),
//                      child: Container(
//                        width:  (MediaQuery.of(context).size.width/3),
//                        alignment: Alignment.center,
//                        padding: EdgeInsets.only(left: 5,right: 5),
//                        decoration: BoxDecoration(
//                            color: Theme.of(context).accentColor,
//                            border: Border.all(color: Colors.white,style: BorderStyle.solid),
//                            borderRadius: BorderRadius.all(Radius.circular(20))),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Image(image: AssetImage("images/logo-shopcar.png"),width: 20,fit: BoxFit.cover,),
//                            SizedBox(width: 3,),
//                            Expanded(child: Text((!document['cart'])?"اضف للسلة":"ازالة من السلة" ,style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),maxLines: 1,textAlign: TextAlign.center,)),
//                          ],
//                        ),
//                      ))),
//            )
//
//          ],
//        ),
//      ],
//    );
//}


  getData()async{

     Query q= (widget.order=='more')?Firestore.instance.collection(widget.nameCollection).orderBy('price',descending: true).limit(5):Firestore.instance.collection(widget.nameCollection).orderBy('price').limit(5);
    setState(() {

      _loadingProducts=true;

    });

     QuerySnapshot querySnapshot=await q.getDocuments();


    _products=querySnapshot.documents;
    if(_products.length==0){
      setState(() {
        loading=false;
        print(loading);

      });
    }
     _lastDocument=querySnapshot.documents.last;
    setState(() {
      loading=false;
      print(loading);

      _loadingProducts=false;
    });
  }

  getMoreData()async{

    if(!_moreProductsAvailable){
      print("No data available");
      return;
    }

    AsyncSnapshot<QuerySnapshot> snapshot;

    Query q= (widget.order=='more')?Firestore.instance.collection(widget.nameCollection).orderBy('price',descending: true).startAfterDocument(_lastDocument).limit(morelimit):Firestore.instance.collection(widget.nameCollection).orderBy('price').startAfterDocument(_lastDocument).limit(morelimit);

    QuerySnapshot querySnapshot=await q.getDocuments();

    if(querySnapshot.documents.length<morelimit){
      _moreProductsAvailable=false;
    }

    _lastDocument=querySnapshot.documents.last;

    _products.addAll(querySnapshot.documents);

    setState(() {});
  }


  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    print(widget.order);
    _products=[];
    getData();
    _scrollController.addListener(() {
      double maxScroll=_scrollController.position.maxScrollExtent;
      double currentScroll=_scrollController.position.pixels;
      double delta=MediaQuery.of(context).size.height*.25;
       if (_scrollController.position.pixels ==
      _scrollController.position.maxScrollExtent){
        getMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final mainProvider = Provider.of<MainProvider>(context);

    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    double heightItem=height*.5;

    return (loading)?Center(
      child:CircularProgressIndicator(),
    ):
    Container(
      width: width,
      height: height-kBottomNavigationBarHeight-kToolbarHeight,
      child:(mainProvider.gridOne)? AnimationLimiter(
        child: GridView.builder(
        controller: _scrollController,
        itemCount: _products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          childAspectRatio: (width/2)/heightItem,) ,
        itemBuilder:(context, index) {
          return AnimationConfiguration.staggeredGrid(
    position: index,
    duration: const Duration(milliseconds: 375),
    columnCount: 2,
    child: Padding(
    padding: EdgeInsets.all(3.0),
    child: ScaleAnimation(
    scale: 0.5,
    child: FadeInAnimation(
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
    child:Stack(
      alignment:Alignment.center,
      children: <Widget>[
        Positioned(
            left: 0,
            top: 0,
            child: IconButton(icon:(_products[index]['favourite'])?Icon(Icons.favorite):Icon(Icons.favorite_border),color:(_products[index]['favourite'])?Theme.of(context).accentColor:Colors.grey ,iconSize: 15,
                onPressed: ()async{

                  setState(() {
                    favoriteCondition(_products[index]);
                  });
                  _products[index]=await Firestore.instance.collection('Product').document(_products[index].documentID).get();
                  setState(() {
                 if(widget.nameCollection=='Favourite'){
                   _products.removeAt(index);
                 }
                  });


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
                  await Navigator.push(context, MaterialPageRoute(builder: (context)=>Product(_products[index])));
                },
                child: Container(
                  child: Image(image: ( _products[index]['images'] != null )?NetworkImage( _products[index]['images'][2],):null,fit: BoxFit.cover,),
                ),
              ),
            ),

            Container(
              height: heightItem/3,
              child: Column(
                children: <Widget>[
                  Expanded(child: Text('${_products[index]['title']}',maxLines: 1, )),

                  Expanded(child: Text("${_products[index]['price']} ريال",maxLines: 1,)),
                ],
              ),
            ),

            Container(
              height: heightItem/5,
              child: InkWell(
                  onTap: ()async{

                    setState(() {
                      cardCondition(_products[index]);
                    });
                    _products[index]=await Firestore.instance.collection('Product').document(_products[index].documentID).get();
                    setState(() {
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
                            Expanded(child: Text((!_products[index]['cart'])?"اضف للسلة":"ازالة من السلة" ,style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),maxLines: 1,textAlign: TextAlign.center,)),
                          ],
                        ),
                      ))),
            )

          ],
        ),
      ],
    ),
    ),
    ],
    )
    ),
    ),
    ),
    ),
    );
    }
    )
      ):ListView.builder(
        controller: _scrollController,
        itemCount: _products.length,
          itemBuilder: (context, index) {
           return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 150),
                child: SlideAnimation(
                  horizontalOffset: 20,
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Container(
                        height: heightItem,
                        width: width,
                        padding:  EdgeInsets.all(3.0),
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: (MediaQuery.of(context).size.width),
                                height: heightItem-8,
                                child: Stack(
                                  alignment:Alignment.center,
                                  children: <Widget>[
                                    Positioned(
                                        left: 0,
                                        top: 0,
                                        child: IconButton(icon:(_products[index]['favourite'])?Icon(Icons.favorite):Icon(Icons.favorite_border),color:(_products[index]['favourite'])?Theme.of(context).accentColor:Colors.grey ,iconSize: 15,
                                            onPressed: ()async{

                                              setState(() {
                                                favoriteCondition(_products[index]);
                                              });
                                              _products[index]=await Firestore.instance.collection('Product').document(_products[index].documentID).get();
                                              setState(() {
                                              });


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
                                              await Navigator.push(context, MaterialPageRoute(builder: (context)=>Product(_products[index])));
                                            },
                                            child: Container(
                                              child: Image(image: ( _products[index]['images'] != null )?NetworkImage( _products[index]['images'][2],):null,fit: BoxFit.cover,),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          height: heightItem/3,
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(child: Text('${_products[index]['title']}',maxLines: 1, )),

                                              Expanded(child: Text("${_products[index]['price']} ريال",maxLines: 1,)),
                                            ],
                                          ),
                                        ),

                                        Container(
                                          height: heightItem/5,
                                          child: InkWell(
                                              onTap: ()async{

                                                setState(() {
                                                  cardCondition(_products[index]);
                                                });
                                                _products[index]=await Firestore.instance.collection('Product').document(_products[index].documentID).get();
                                                setState(() {
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
                                                        Expanded(child: Text((!_products[index]['cart'])?"اضف للسلة":"ازالة من السلة" ,style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),maxLines: 1,textAlign: TextAlign.center,)),
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
                    ),
                  ),
                ));
          },
      )
    );

}
}