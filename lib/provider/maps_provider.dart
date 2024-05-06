export 'package:provider/provider.dart';

import 'dart:async';
import 'package:geolocator/geolocator.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';


class MapProvider extends ChangeNotifier {

 late GoogleMapController mapsCtrl; 

 double lat= -34.581534; 
 double lng= -58.420641; 
 MapType selectedType = MapType.normal; 
 
 CameraPosition inicioLoc = const CameraPosition(
    target: LatLng(-34.581534, -58.420641),
    zoom: 16.0,
  );
 
 void changeType(){

   selectedType == MapType.normal 
    ? selectedType = MapType.satellite
    : selectedType = MapType.normal;

  notifyListeners();
}

Future<CameraPosition> determinarPosicion () async {
  

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
                  zoom: 16.0,
                ); 
     } else {
           print('Sin permisos');
       }

}
  
 return inicioLoc; 
}

Future<void> goToCenter() async {
//TODO: CAMBIAR POR COORDENADAS GPS

final GoogleMapController controller =  mapsCtrl;

final position = await determinarPosicion(); 

await controller.animateCamera(CameraUpdate.newCameraPosition(position));

notifyListeners(); 
}

//Desplazarse hasta algún marcador
Future<void> goToMarker(LatLng coordenadas) async { 

  CameraPosition moverLoc =  CameraPosition(
    //bearing: 192.8334901395799,
    target: coordenadas,
    zoom:16.0); 
  final GoogleMapController controller = mapsCtrl;
  await controller.animateCamera(CameraUpdate.newCameraPosition(moverLoc));
  
  notifyListeners(); 

}

}