import 'package:app_zooq/Core/constants/app_contstant.dart';
import 'package:app_zooq/Core/services/mainProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonLogin extends StatefulWidget {
  final String title;
  final String route;

  ButtonLogin(this.title, this.route);

  @override
  _ButtonLoginState createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()async{
        final mainProvider = Provider.of<MainProvider>(context);
        mainProvider.collectionName='Product';
        Navigator.of(context).pushNamed(widget.route);                          },
      child: Padding(
        padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width/4,right:MediaQuery.of(context).size.width/4,top: 30 ),
        child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                border: Border.all(color: Theme.of(context).accentColor,style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(50))

            ),
            child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    border: Border.all(color: Colors.white,style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(50))


                ),
                child: Center(
                  child: Text(widget.title,style: TextStyle(fontSize: 20,color: Colors.white),),
                )
            )
        ),
      ),
    );
  }
}
