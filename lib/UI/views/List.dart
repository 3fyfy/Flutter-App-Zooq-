import 'dart:io';

import 'package:app_zooq/Core/constants/app_contstant.dart';
import 'package:app_zooq/Core/services/mainProvider.dart';
import 'package:app_zooq/Core/services/user_controller.dart';
import 'package:app_zooq/UI/views/men3tor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_zooq/Core/services/user_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ListDrawer extends StatefulWidget {

  final String name;

  ListDrawer(this.name);

  @override
  _ListDrawerState createState() => _ListDrawerState();
}

class _ListDrawerState extends State<ListDrawer> {

  UserController userController=UserController();
  File _image;

  Future getImage(bool cam) async {
    final mainProvider = Provider.of<MainProvider>(context);


    var image = await ImagePicker.pickImage(source:cam?ImageSource.camera:ImageSource.gallery);

    setState(() {
      mainProvider.image=image;
      _image = image;
    });
  }

  Widget _buildItem(String name){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top:10.0,bottom: 10,right: 40),
          child: InkWell(child: Text(name,style: TextStyle(fontSize: 15,color:Colors.white )),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopMen(name)));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 40,left: 40),
          child: Divider(color: Color(0xff31050f),height: 2,),
        )
      ],
    );
  }

  void _showDialoge(){
     showDialog(context: context,
    builder: (context){
      double height=MediaQuery.of(context).size.height;
      return AlertDialog(

        title: Text("Image Profile"),
        content: Container(
          height:height*.3 ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
          Container(
          height: height*.2,
            child: Column(
            children: <Widget>[
              InkWell(
                child: Text("Camera"),
                onTap: (){
                  getImage(true);
                },
              ),
              InkWell(
                child: Text("Gallary"),
                onTap: (){
                  getImage(false);
                },
              ),
              ]
          ),
          ),

            Container(
                  height: height*.1,
                  child:  InkWell(
                    child: Text("Close"),
                    onTap: (){
                      Navigator.of(context).pop();
                    },

                ),
              )
            ],
          ),
        ),

        contentPadding: EdgeInsets.only(top: 5,bottom: 5),
        titlePadding:EdgeInsets.only(top: 5,bottom: 5,left:10) ,

      );

    }
    );
  }


  @override
  Widget build(BuildContext context) {

    final mainProvider = Provider.of<MainProvider>(context);

//    double height=MediaQuery.of(context).size.height;
    return  Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Color(0xff98021D)
      ),
      child: ListView(
          
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                    //width: 60,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff8F011B),
                    ),
                    child: ListTile(
                      leading:  CircleAvatar(
                        backgroundColor: Colors.transparent,
                       backgroundImage: mainProvider.image == null
                           ? null:FileImage( mainProvider.image),
                        child: InkWell(
                          onTap: (){

                            _showDialoge();
                          },

                            child: mainProvider.image == null
                                ? Icon(Icons.camera_enhance)
                                : null,
                        ),
                      ),
                      title: Text("مرحبا بك  ${widget.name} "),

                    ),
                  ),
            ),

            _buildItem("عطور رجالي"),
            _buildItem("عطور نسائي"),
            _buildItem("عطور اطفال"),
            _buildItem("عطور مميزة"),
            _buildItem("عطور فاخرة"),
            _buildItem("عطور شبابي"),
            _buildItem("عطور كلاسيكي"),
            _buildItem("عطور العود"),


  userController.currentUserController()!=null?Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Padding(
    padding: const EdgeInsets.only(top:10.0,bottom: 10,right: 40),
    child: InkWell(child: Text("تسجيل الخروج",style: TextStyle(fontSize: 15,color:Colors.white )),
    onTap: ()async{
     await userController.logOutController();
     Navigator.of(context).pushReplacementNamed(RoutePaths.Login);
    },
    ),
    ),
    Padding(
    padding: const EdgeInsets.only(right: 40,left: 40),
    child: Divider(color: Color(0xff31050f),height: 2,),
    )
    ],
    ):null

    ],
      )

    );
  }
}
