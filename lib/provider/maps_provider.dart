export 'package:provider/provider.dart';

import 'dart:async';
import 'package:geolocator/geolocator.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';


class MapProvider extends ChangeNotifier {

 final Completer<GoogleMapController> mapsCtrl =  Completer<GoogleMapController>(); 
 // inicializando con puntos principales

 final double lat =-34.581534; 
 final double lng= -58.420641; 

 MapType selectedType = MapType.normal; 


 CameraPosition inicioLoc = const CameraPosition(
    target: LatLng(-34.581534, -58.420641),
    zoom: 14.4746,
  );
 
 void ChangeType(){

   selectedType == MapType.normal 
    ? selectedType = MapType.satellite
    : selectedType = MapType.normal;

  notifyListeners();
}

Future<CameraPosition> DeterminarPosicion () async {

 

  if (await Permission.location.request().isGranted) {

    await Geolocator.requestPermission(); 

 
  } 


  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  permission = await Geolocator.checkPermission();

  if (serviceEnabled ) { 
   if (permission == LocationPermission.always || permission ==LocationPermission.whileInUse){
    
    var position = await Geolocator.getCurrentPosition();
    print(position.latitude.toString()); 
    
     inicioLoc = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 14.4746,
          ); 
   } else {
      print('Sin permisos');
   }
}
  
 return inicioLoc; 
}


Future<void> goToCenter() async {
//TODO: CAMBIAR POR COORDENADAS GPS

final GoogleMapController controller = await mapsCtrl.future;

final position = await DeterminarPosicion(); 

await controller.animateCamera(CameraUpdate.newCameraPosition(position));
notifyListeners(); 
}

Future<void> goToMarker(CameraPosition coordenadas) async { 
  
  CameraPosition moverLoc = const CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414);

      //TODO: CAMBIAR POR UN MARKER

  final GoogleMapController controller = await mapsCtrl.future;

  await controller.animateCamera(CameraUpdate.newCameraPosition(moverLoc));
  notifyListeners(); 
}


/*
    LatLng getLatLng() {

      final latLng = this.valor.substring(4).split(',');
      final lat = double.parse( latLng[0] );
      final lng = double.parse( latLng[1] );

      return LatLng( lat, lng );
    }*/

}