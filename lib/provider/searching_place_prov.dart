

import 'package:flutter/material.dart';

class SearchingPlaceProvider extends ChangeNotifier {

  bool _estadoInput = false; 

  bool get estadoInput => _estadoInput; 

  set estadoInput(bool value) {
    _estadoInput = value; 
    
    notifyListeners(); 
  }





}