import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class RateDialog extends StatefulWidget {
  @override
  _RateDialogState createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {


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

    );
  }
}
