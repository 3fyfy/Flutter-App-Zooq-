import 'package:app_zooq/Core/services/addressProvider.dart';
import 'package:app_zooq/UI/widgets/BuildTextField.dart';
import 'package:app_zooq/UI/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MoreAdress.dart';

import 'package:cloud_firestore/cloud_firestore.dart';



class Address extends StatefulWidget {
  final String _adressId;


  Address(this._adressId);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {


  final _formKey = GlobalKey<FormState>();




  @override

  Widget build(BuildContext context) {

    final addressProvider = Provider.of<AddressProvider>(context);

    Widget dropDown(){
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          padding: const EdgeInsets.only(top: 0,bottom: 15),

          decoration: BoxDecoration(
              border: Border(bottom:BorderSide(style: BorderStyle.solid,color: Colors.grey))

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              (addressProvider.city==null)?Text("المدينة",style: TextStyle(color: Colors.grey),):Text(addressProvider.city),

              new PopupMenuButton(
                child:Icon(Icons.arrow_drop_down),


                itemBuilder: (_) =>   <String> ['القاهرة', 'الاسكندرية', 'المنصورة', 'اسوان'].map((String value){

                  return PopupMenuItem<String>(
                      value: value,

                      child:Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                            width: MediaQuery.of(context).size.width-80,
                            child: Text(value)),
                      ));

                }).toList(),
                onSelected: (String value){
                  setState(() {
                    addressProvider.city=value;
                  });
                  return addressProvider.city;
                },

              ),

            ],
          ),
        ),
      );
    }

    Widget _buildButton(){

      return Padding(
        padding: const EdgeInsets.only(top:30.0,bottom: 2),
        child: InkWell(
            onTap: ()async{
              if (_formKey.currentState.validate()&& addressProvider.city!=null) {
                addressProvider.loading=true;
                if(widget._adressId=='')
                  await Firestore.instance.collection('Address')
                      .document()
                      .setData({
                    'city': addressProvider.city,
                    'street': addressProvider.street.text,
                    'phone': addressProvider.phone.text,
                    'description': addressProvider.description.text,
                    'notes':addressProvider.notes.text,
                    'check':true
                  });
                else
                  await Firestore.instance.collection('Address')
                      .document(widget._adressId)
                      .updateData({
                    'city': addressProvider.city,
                    'street': addressProvider.street.text,
                    'phone': addressProvider.phone.text,
                    'description':addressProvider.description.text,
                    'notes':addressProvider.notes.text,
                    'check':addressProvider.check
                  });
                addressProvider.loading=false;


                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CustAddress()));
              }
            },
            child: Container(
                width: 130,
                height: 45,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    border: Border.all(color: Theme.of(context).accentColor,style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(30))

                ),
                child: Container(
                  width:  (MediaQuery.of(context).size.width/4)-10,

                  height: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      border: Border.all(color: Colors.white,style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(30))


                  ),
                  child: Center(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          (addressProvider.loading)?CircularProgressIndicator(backgroundColor: Colors.white,):Text("متابعة",style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),),
                        ],
                      )),
                ))),
      );
    }

    Widget _buildBottomCarousel(){
      return Padding(
          padding: const EdgeInsets.only(top:0,bottom:0,right: 20,left: 20),
          child: Container(
            width:MediaQuery.of(context).size.width-80 ,
            child: Form(
              key: _formKey,
              child:
              Column(children: <Widget>[


                dropDown(),
                BuildTextField(hintText:"الشارع",secure: false,controller: addressProvider.street,),

                BuildTextField(hintText:"معلم قريب منه",secure: false,controller: addressProvider.description, ),
                BuildTextField(hintText:"رقم الهاتف",secure: false, type: TextInputType.phone,controller: addressProvider.phone,),
                BuildTextField(hintText:"ملاحظات الشحن",secure: false,controller: addressProvider.notes, ),

                _buildButton()

              ],
              ),


            ),
          ));
    }

    Widget _buildBody()
    {
      return Stack (

            children:<Widget>[

              Container(
                height:MediaQuery.of(context).size.height/2 ,
                color: Theme.of(context).accentColor,

              ),

              Padding(
                  padding: const EdgeInsets.only(top:30,bottom:0,right: 20,left: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height+(AppBar().preferredSize.height+30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                    child: ListView(
                      children: <Widget>[
                        MapView(),
                        _buildBottomCarousel()
                      ],
                    ),
                  )
              ),



            ]
        );

    }


    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        appBar: AppBar(
          title: Text("العنوان",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,

            ),),
          centerTitle: true,
          leading:Image(image:AssetImage('images/icon-logo3.png')) ,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.shopping_cart), onPressed:(){
              Navigator.of(context).pushNamed('/cart');
            }),
            IconButton(icon: Icon(Icons.arrow_back_ios,textDirection: TextDirection.ltr
              ,), onPressed: (){Navigator.of(context).pop();}),
          ],
        ),
        body: _buildBody(),

      ),
    );
  }
}



