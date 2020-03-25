import 'package:app_zooq/Core/constants/app_contstant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class RateDialog extends StatefulWidget {
  @override
  _RateDialogState createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


  @override
  initState() {
    super.initState();

    var Android =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(Android, IOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'تمت العملية بنجاح',
      'الذهاب الى الصفحة الرئيسية',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }



  Future onSelectNotification(String payload) async {

    Navigator.of(context).pushReplacementNamed(RoutePaths.NavBar);

  }

  double rating=0.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: Center(child: Text("قيم التطبيق")),

      content: Container(
          height: 100,
          child: Center(
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: SmoothStarRating(
                  color: Theme.of(context).accentColor,
                  borderColor: Colors.black,
                  rating: rating,
                  size: 25,
                  starCount: 5,
                  spacing: 5.0,
                  allowHalfRating: false,
                  onRatingChanged: (value) {
                    setState(() {
                      rating = value;
                    });
                  },

                )),
          )
      ),

      contentPadding: EdgeInsets.only(top: 5,bottom: 5),
      titlePadding:EdgeInsets.only(top: 5,bottom: 5,left:10) ,
      actions: <Widget>[
        FlatButton(onPressed: ()async{


        await  Firestore.instance.collection('Cart').getDocuments().then((snapshot) {
          for (DocumentSnapshot ds in snapshot.documents) {
             Firestore.instance.collection('Product').document().updateData({'cart':false});
            Firestore.instance.collection('Product').document(ds.documentID).updateData({'cart': false});
            if(ds['favourite'])
              Firestore.instance.collection('Favourite').document(ds.documentID).updateData({'cart': false});

             Firestore.instance.collection('Cart').document(ds.documentID).delete();
          }
        }
            );

        _showNotificationWithDefaultSound();

    }
    , child: Text("تقييم",textAlign: TextAlign.center,),
          color: Theme.of(context).accentColor,)
      ],


    );

  }
}