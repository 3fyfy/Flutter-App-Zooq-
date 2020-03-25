import 'package:app_zooq/Core/constants/app_contstant.dart';
import 'package:app_zooq/Core/services/userProvider.dart';
import 'package:app_zooq/Core/services/user_controller.dart';
import 'package:app_zooq/UI/widgets/BuildTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  UserController userController=UserController();


  @override

  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("التسجيل",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,

            ),),
          centerTitle: true,
          leading:Image(image:AssetImage('images/icon-logo3.png')) ,
          actions: <Widget>[

            IconButton(icon: Icon(Icons.arrow_back_ios,textDirection: TextDirection.ltr
              ,), onPressed: (){
              Navigator.of(context).pop();
            }),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              width: width,
              height: height,
              color: Theme.of(context).accentColor,

              child: Padding(
                padding: const EdgeInsets.only(top:30,bottom:120,right: 20,left: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.all(Radius.circular(6))

                  ),
                  child: ListView(
                    children: <Widget>[
                      BuildTextFieldicon(hintText:"اسم المستخدم او البريد الالكتروني" ,icon:Icons.person ,secure: false,controller: userProvider.emailControllerReg,type: TextInputType.emailAddress,),
                      BuildTextFieldicon(hintText:"كلمة المرور" ,icon:Icons.lock ,secure: true,controller: userProvider.passwordControllerReg,type:TextInputType.visiblePassword),


                  Padding(
                    padding: const EdgeInsets.only(top: 10,right: 25,left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: InkWell(
                              onTap: ()async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();

                              String  email=userProvider.emailControllerReg.text;
                              String  password= userProvider.passwordControllerReg.text;
                              await userController.registerController(email, password);
                                prefs.setString('name', email.split('@')[0]);
                                Firestore.instance.collection('Token').document().setData({
                                  'token':prefs.get('token'),
                                  'email':email,
                                  'date':DateTime.now()
                                });
                                userProvider.emailControllerReg=null;
                              userProvider.passwordControllerReg=null;
                              Navigator.of(context).pushReplacementNamed(RoutePaths.NavBar);
                              },
                              child: Container(
                                  width: 140,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      border: Border.all(color: Theme.of(context).accentColor,style: BorderStyle.solid),
                                      borderRadius: BorderRadius.all(Radius.circular(50))

                                  ),
                                  child: Container(
                                    width: 130,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        border: Border.all(color: Colors.white,style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(Radius.circular(50))


                                    ),
                                    child: Center(

                                        child: Text("تسجيل",style: TextStyle(fontSize: 20,color: Colors.white),)),
                                  ))),
                        )
                      ],
                    ),

                  )
                    ],
                  ),

                ),
              ),
            )
          ],
        ),

      ),
    );
  }

}
