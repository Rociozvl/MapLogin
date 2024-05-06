
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../src/models/marker_model.dart';

class MarkersProvider extends ChangeNotifier{

List<Marker> marcas = []; 
TextEditingController markCtrl = TextEditingController(); 
String markName = ''; 
List<Marker> destinos = []; 


mostrarMarker (LatLng coor, String name) {
     marcas.add(
      Marker(markerId: MarkerId(name),
      position: coor,
      draggable: false, 
      onTap: () {
          marcaDestino(coor);
      }
      ));

 notifyListeners();
}
//pasar de listador model a markerMap 
cargarLista (List<MarkerModel> lista) {

   for(int i = 0; i<lista.length; i++){
    marcas.add(
      Marker(
      visible:true,
      markerId: MarkerId(lista[i].markerId.toString()), 
      position: LatLng (lista[i].lat, lista[i].long),
      draggable: false,
      ));

    notifyListeners(); 
   }
  
} 

//refrescar lista marcadores al agregar 
void refrescarLista (List<MarkerModel> lista) {
  
    marcas.clear(); 
    cargarLista(lista); 

    notifyListeners(); 
}

void marcaDestino (LatLng coor) {
 limpiarDestino();
  destinos.add(
        Marker(markerId: const MarkerId('Destino'),
        position: coor,
        draggable: false, 
        onTap: () {
            

        }
        ));

  notifyListeners();

}
void limpiarDestino(){
destinos = [];
 notifyListeners();

} 



} 


