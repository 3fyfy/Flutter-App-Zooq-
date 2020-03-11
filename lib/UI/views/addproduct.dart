import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class addproduct extends StatefulWidget {
  @override
  _addproductState createState() => _addproductState();
}

class _addproductState extends State<addproduct> {
var item=  {
  'name':'عطر اجنر اكس',
  'price': 130.0,
  'image':'images/1.jpg',
  'favourite':false,
  'cart':false,
  'brand':'اجنر',
  'description':'عطر اجنر اكس عطر اجنر اكس عطر اجنر اكس عطر 100%',
  'type':'5189-رجالي'
};
List<String> images=['https://static.corinedefarme.fr/media/catalog/product/cache/2/image/9df78eab33525d08d6e5fb8d27136e95/l/e/leparfum_face.1559569146.jpg','https://m.xcite.com/media/catalog/product/cache/5/thumbnail/550x400/9df78eab33525d08d6e5fb8d27136e95/182927/Lalique_Amethyst_by_Lalique_for_Women_100_mL_Eau_de_parfum_1.jpg','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRure9UWDTjJ42d9I4JemQnsu7LBFhJAaFBDPDFEoqfqUGi76Gv'];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(

                child: RaisedButton(
                  onPressed: (){
                    Firestore.instance.collection('Product').document().setData({
                      'title':'عطر اجنر اكس عطر ',
                      'price': 190.0,
                      'favourite':false,
                      'cart':false,
                      'brand':'اجنر',
                      'description':'عطر اجنر اكس عطر اجنر اكس عطر اجنر اكس عطر 100%',
                      'type':'5189-رجالي',
                      'images':images
                    });
                  },
                  child: Text("data"),)
        ),
        Container(

            child: RaisedButton(
              onPressed: (){
                Firestore.instance.collection('Product').document().setData({
                  'title':'عطر ',
                  'price': 190.0,
                  'favourite':false,
                  'cart':false,
                  'brand':'هوجو',
                  'description':'عطر اجنر اكس عطر اجنر اكس عطر اجنر اكس عطر 100%',
                  'type':'5189-رجالي',
                  'images':images
                });
              },
              child: Text("data"),)
        ),
        Container(

            child: RaisedButton(
              onPressed: (){
                Firestore.instance.collection('Product').document().setData({
                  'title':'ريتاج ',
                  'price': 190.0,
                  'favourite':false,
                  'cart':false,
                  'brand':'هوجو',
                  'description':'عطر اجنر ريتاج عطر اجنرريتاج اجنر اكس ريتاج 100%',
                  'type':'5189-عطر',
                  'images':images
                });
              },
              child: Text("data"),)
        ),
      ],
    );
  }
}
