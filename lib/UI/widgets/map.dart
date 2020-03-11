import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';



class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  Completer<GoogleMapController> _controller = Completer();

 static var currentLocation = LatLng(37.42796133580664, -122.085749655962);
  LatLng _lastPosition = currentLocation;

  var location = new Location();
  final Set<Marker> _marker={};



  static final CameraPosition _kGooglePlex = CameraPosition(
    target: currentLocation,
    zoom: 14.4746,

  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: currentLocation,
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top:40.0,right: 30,left: 30),
      child: Container(
        height:150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/map.png'),fit: BoxFit.cover),
        ),
        child: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: _kGooglePlex,
              mapType: MapType.satellite,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
              markers: _marker,
            ),

            IconButton(icon: Icon(Icons.location_on), onPressed: (){

              location.onLocationChanged().listen((LocationData currentLocation) {
                print(currentLocation.latitude);
                print(currentLocation.longitude);
              });

            })
          ],
        ),
      ),

    );
  }
}
