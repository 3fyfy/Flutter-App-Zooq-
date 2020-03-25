
import 'package:app_zooq/Core/constants/app_contstant.dart';
import 'package:app_zooq/Core/services/userProvider.dart';
import 'package:app_zooq/Core/services/user_controller.dart';
import 'package:app_zooq/UI/widgets/BuildTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';





class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UserController userController=UserController();


  Widget _buildBodyLogin(){

    final userProvider = Provider.of<UserProvider>(context);
    final mainprovider=Provider.of<UserProvider>(context);


    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return  ListView(
      children: <Widget>[
        Container(
          width: width,
          height: height,
          color: Theme.of(context).accentColor,

          child: Padding(
            padding: const EdgeInsets.only(top:30,bottom:120,right: 20,left: 20),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.all(Radius.circular(6))

              ),
              child: ListView(
                children: <Widget>[
                  BuildTextFieldicon(hintText:"اسم المستخدم او البريد الالكتروني" ,icon:Icons.person ,secure: false,controller: userProvider.emailControllerLog,type: TextInputType.emailAddress,),
                  BuildTextFieldicon(hintText:"كلمة المرور" ,icon:Icons.lock ,secure: true,controller: userProvider.passwordControllerLog,),


                  Padding(
                    padding: const EdgeInsets.only(top: 10,right: 25,left: 15),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                            onTap: (){},
                            child: Text("نسيت كلمة المرور",style: TextStyle(fontSize: 15),))
                      ],
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,right: 25,left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: InkWell(
                              onTap: ()async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();

                                String  email=userProvider.emailControllerLog.text;
                                String  password=userProvider.passwordControllerLog.text;
                                if(!(email.isEmpty&&password.isEmpty)){
                                  userProvider.loading=true;
                                }
                                await userController.loginController(email,password);
                                prefs.setString('name', email.split('@')[0]);
                                Firestore.instance.collection('Token').document().setData({
                                  'token':prefs.get('token'),
                                  'email':email,
                                  'date':DateTime.now()
                                });
                                //email.split('@')[0]
                                userProvider.loading=false;
                                userProvider.emailControllerLog=null;
                                userProvider.passwordControllerLog=null;
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

                                        child: (userProvider.loading)?CircularProgressIndicator(backgroundColor: Colors.white,):Text("دخول الان",style: TextStyle(fontSize: 20,color: Colors.white),),
                                      )
                                  )
                              ),
                            )
                        )
                      ],
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("لا امتلك حساب",style: TextStyle(fontSize: 15),),

                        SizedBox(
                          width: 10,
                        ),

                        InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(RoutePaths.SignUp);
                          },
                          child: Text("سجل الان",style: TextStyle(fontSize: 15,color: Theme.of(context).accentColor),),
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
    );
  }

  @override
  Widget build(BuildContext context) {


    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text("تسجيل الدخول",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,

              ),),
            centerTitle: true,
            leading:Image(image:AssetImage('images/icon-logo3.png')) ,

          ),


          body:_buildBodyLogin()

      ),
    );
  }
}