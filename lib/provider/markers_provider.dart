import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../src/models/marker_model.dart';

class MarkersProvider extends ChangeNotifier{

List<Marker> marcas = []; 


mostrarMarker (LatLng coor, String name, Function function) {
     marcas.add(
      Marker(markerId: MarkerId(name),
      position: coor,
      draggable: false, 
      onTap: () {
            function();  
      }
      ));
 notifyListeners();
}
//pasar de listador model a markerMap 
cargarLista (List<MarkerModel> lista) {

   for(int i = 0; i<lista.length; i++){
    marcas.add(
      Marker(
      markerId: MarkerId(lista[i].markerId.toString()), 
      position: LatLng (lista[i].lat, lista[i].long),
      draggable: false,
      ));

    notifyListeners(); 
   }
  
} 

//refrescar lista marcadores al agregar 
void refrescarLista (List<MarkerModel> lista) {

   final lastMark = lista.lastWhere((element) => true);
    marcas.add(
      Marker(
        markerId: MarkerId(lastMark.markerId),
        position: LatLng(lastMark.lat, lastMark.long),
        draggable: false,
    
      ));

    notifyListeners(); 
}


}