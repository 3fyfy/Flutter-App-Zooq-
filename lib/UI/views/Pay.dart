import 'package:app_zooq/UI/widgets/AutoText.dart';
import 'package:app_zooq/UI/widgets/rate.dart';
import 'package:flutter/material.dart';


class Pay extends StatefulWidget {
  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  int _radioValue1 = -1;
  double totalprice=0;


  void _showDialoge(){
    showDialog(context: context,

        builder: (context){
          return RateDialog();

        }
    );
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
  }


  Widget _buildItem(String txt1, String txt2, int val, String img) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ListTile(

       trailing :  Image.asset(img),
        title:AutoText(text:txt1,lines: 2,) ,
        subtitle: AutoText(text: txt2,lines: 2,),
      leading:  new Radio(
                activeColor: Colors.black,
                value: val,
                groupValue: _radioValue1,
                onChanged: _handleRadioValueChange1,
              ),

      )

    );
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:  AppBar(
          title: Text(
            'خيارات الدفع',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,

          ),),
        centerTitle: true,
        leading:Image(image:AssetImage('images/icon-logo3.png')) ,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed:(){}),
          IconButton(icon: Icon(Icons.arrow_back_ios,textDirection: TextDirection.ltr
            ,), onPressed: (){Navigator.of(context).pop();}),
        ],
      ),
        backgroundColor:Color(0xffc01232),
        body: ListView(
          children: <Widget>[
            Center(
              child: Container(
                child: Column(
                  children: <Widget>[
                    _buildItem('الدفع ببطاقة الائتمان', 'فيزا او ماستر كارد', 0,
                        'images/visa.png'),
                    _buildItem('باي بال(payPal)',
                        'التكلفة الاضافية لهذه الخدمة هي 20 ر س', 1, 'images/paypal-logo.png'),
                    _buildItem('الدفع نقدا عند الاستلام',
                        'التكلفة الاضافية لهذه الخدمة هي 20 ر س', 2, 'images/WithMoney.png')
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),

                margin:
                    EdgeInsets.only(right: 20, left: 20, top: 40, bottom: 40),
              ),
            ),

          ],
        ),
        bottomNavigationBar: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Center(
              child:
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    InkWell(child: Text('تاكيد الدفع',style: TextStyle(color: Color(0xffc01232),fontWeight: FontWeight.bold),),onTap: (){
                      _showDialoge();


                      },),
                  ],),
              )
          ),
          //540
        ),
      ),
    );
  }
}