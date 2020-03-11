import 'package:flutter/material.dart';
class BuildTextField extends StatefulWidget {
  final bool secure;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType  type;
  BuildTextField({this.controller,this.icon,this.secure,this.hintText,this.type});
  @override
  _BuildTextFieldState createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {

  @override
  Widget build(BuildContext context) {
   return
     Padding(
       padding: const EdgeInsets.only(top: 20,right: 5,left: 5),
       child: TextFormField(
         controller:widget.controller ,
         obscureText: widget.secure,
         keyboardType:widget.type,
         validator: (value) => value.isEmpty ? " لا يجب ان يكون فارغا " : null,
         decoration:InputDecoration(
           hintText: widget.hintText,

           border:UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid,)),
           hintStyle: TextStyle(fontSize: 16),

           focusedBorder: UnderlineInputBorder(
             borderSide: BorderSide(color: Theme.of(context).accentColor),
           ),
         ),
         cursorColor: Theme.of(context).accentColor,
       ),
     );
  }
}


class BuildTextFieldicon extends StatefulWidget {
  final bool secure;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final String Function(String) valid;
  final TextInputType  type;
  BuildTextFieldicon({this.controller,this.icon,this.secure,this.hintText,this.valid,this.type});
  @override
  _BuildTextFieldiconState createState() => _BuildTextFieldiconState();
}

class _BuildTextFieldiconState extends State<BuildTextFieldicon> {

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(top: 20,right: 25,left: 15),
        child: TextFormField(
          controller:widget.controller ,
          obscureText: widget.secure,
          keyboardType:widget.type,
          decoration:InputDecoration(
            hintText: widget.hintText,

            border:UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid,)),
            hintStyle: TextStyle(fontSize: 16),
            prefixIcon:Icon(widget.icon,color: Theme.of(context).accentColor,),

            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
            ),
          ),
          cursorColor: Theme.of(context).accentColor,
        ),
      );
  }
}
