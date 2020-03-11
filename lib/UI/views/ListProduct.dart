import 'package:app_zooq/UI/views/productdetails.dart';
import 'package:app_zooq/UI/widgets/AutoText.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ListProd extends StatefulWidget {
  @override
  _ListProdState createState() => _ListProdState();
}

class _ListProdState extends State<ListProd> {

  @override
  Widget build(BuildContext context) {
    double heightProd= MediaQuery.of(context).size.height/4;
    double widthProd= MediaQuery.of(context).size.width/3;
    return  Container(
        height:heightProd,
        child:  StreamBuilder<QuerySnapshot>(

          stream: Firestore.instance.collection('Product').snapshots(),
         builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
    if (snapshot.hasError)
    return new Text('Error: ${snapshot.error}');
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return Center(child: CircularProgressIndicator(),);
      default:
        return ListView(
            scrollDirection: Axis.horizontal,

            children: snapshot.data.documents.map((DocumentSnapshot document) {
              return Container(
                width: widthProd,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(color: Colors.grey, width: .5))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Product(document)));
                      },
                      child: Container(
                        height: heightProd * (2 / 3) - 20,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: (document['images'] != null)
                                  ? NetworkImage(document['images'][2],)
                                  : null),

                        ),
                      ),
                    ),
                    Container(
                      height: heightProd * (1 / 3),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 3.0, left: 3),
                            child: Container(
                                height: heightProd * (1 / 3) / 2,
                                child: AutoText(text: document['title'],
                                  size: 25,
                                  fontWeight: FontWeight.bold,)

                            ),
                          ),


                          Container(

                              height: heightProd * (1 / 3) / 2,
                              child: AutoText(text: "${document['price']} ريال",
                                color: Theme
                                    .of(context)
                                    .accentColor,
                                size: heightProd*.90,

                              )

                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              );
            }).toList()
        );
    }

                })
    );
          }

}
