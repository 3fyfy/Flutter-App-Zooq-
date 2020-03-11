import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {

  final String name;
 final  Widget route;
  ButtonLogin(this.name,this.route);
  @override
  Widget build(BuildContext context) {
      return  Padding(
        padding: const EdgeInsets.only(top: 10,right: 25,left: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: InkWell(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>route));
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

                            child: Text(name,style: TextStyle(fontSize: 20,color: Colors.white),)),
                      ))),
            )
          ],
        ),

      );


  }
}
