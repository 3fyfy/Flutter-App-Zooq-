import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  bool flag=false;
String _selection;

  Widget popUP(){
    return  PopupMenuButton<String>(
        enabled: true,
        onSelected: (String value) {
          setState(() {
            _selection = value;
          });
        },

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(image: AssetImage("images/icon-popover.png"),),
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'Value1',
            child: Text('الاعلى سعرا'),
          ),
          const PopupMenuItem<String>(
            value: 'Value2',
            child: Text('الاقل سعرا'),
          ),
        ],

    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: Theme.of(context).accentColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          popUP(),
          IconButton(icon:Image(image: AssetImage("images/icon-menu.png")),onPressed: (){},),
        ],
      ),
    );
  }
}
