import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AutoText extends StatelessWidget {
  final String text;
  final Color color;
   double size=10;
  final FontWeight fontWeight;
 int lines=1;

  AutoText({this.text,this.color,this.size,this.fontWeight,this.lines});
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight

      ),
      textAlign: TextAlign.start,
      overflow: TextOverflow.clip,

      maxLines: lines,
      maxFontSize: 20,
    );
  }
}
