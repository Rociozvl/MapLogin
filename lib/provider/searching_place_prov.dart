

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_map/services/services.dart';

class SearchingPlaceProvider extends ChangeNotifier {

  bool _estadoInput = false;

  bool get estadoInput => _estadoInput; 

  set estadoInput(bool value) {
    _estadoInput = value; 
    
    notifyListeners(); 
  }

  TextEditingController textController = TextEditingController(); 
  final apiKey = PlaceService.apiKey; 

  LatLng? coordenadas; 

}