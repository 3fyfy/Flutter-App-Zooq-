import 'package:app_zooq/Core/services/user_controller.dart';
import 'package:app_zooq/UI/views/Favourites.dart';
import 'package:app_zooq/UI/views/Home.dart';
import 'package:app_zooq/UI/views/Search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


//Screen navbar

//import 'navpages/Profile.dart';
import 'List.dart';





class Mainnavbar extends StatefulWidget {
  @override
  _MainnavbarState createState() => _MainnavbarState();
}

class _MainnavbarState extends State<Mainnavbar> {


  final scaffoldKey=GlobalKey<ScaffoldState>();

  static var name='';



  int _selectedIndex=3;
  Widget body= Home();
  List <Widget> pages=[
    ListDrawer(name.toString()),
    Search(),
    Favourite(),
    Home()
 ];



  void _onItemTapped(int index) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      if(index == 0) {
      name=prefs.get('name');
        scaffoldKey.currentState.openDrawer();

      }
      else {
        _selectedIndex = index;
        body= pages[_selectedIndex];
      }

    });
  }

  Widget build(BuildContext context) {

    return Directionality(

      textDirection: TextDirection.rtl,
      child: Scaffold(

key: scaffoldKey,

        drawer:Drawer(child:  ListDrawer(name.toString()),),

       body:body,
        bottomNavigationBar: BottomNavigationBar(
showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(color: Colors.black54),


          items: [
            BottomNavigationBarItem(

              icon: Icon(Icons.format_list_bulleted),
                title: Padding(padding: EdgeInsets.only(bottom: 10))

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
                title: Padding(padding: EdgeInsets.only(bottom: 10))
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
                title: Padding(padding: EdgeInsets.only(bottom: 10))
            ),


            BottomNavigationBarItem(
              icon: Icon(Icons.home),
                title: Padding(padding: EdgeInsets.only(bottom: 10))
            ),
          ],
          backgroundColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,

          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        )
      ),
    );
  }
}
