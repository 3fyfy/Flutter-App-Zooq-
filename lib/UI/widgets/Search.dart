import 'package:app_zooq/Core/constants/app_contstant.dart';
import 'package:app_zooq/UI/views/SearchResults.dart';
import 'package:flutter/material.dart';



class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {

      return Container(
        height: 50,
        child: TextFormField(
          decoration: InputDecoration(
            hintText: "بحث عن منتج",
            suffixIcon: IconButton(icon: Icon(Icons.search,color: Theme.of(context).accentColor,size: 30,),
              onPressed: (){
                Navigator.of(context).pushNamed(RoutePaths.SerachResults);
              },),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey,width: 1),

            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color:Theme.of(context).accentColor ,width: 1),

            ),

          ),
          cursorColor: Theme.of(context).accentColor,
        ),
      );
    }



}
