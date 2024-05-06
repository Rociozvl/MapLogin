
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';

//TODO:  USO DE API DIRECTION , API AUTOCOMPLETE (?) Y FLUTTER POLYLINE POINTS



class PlaceService extends ChangeNotifier{
static String apiKey = 'AIzaSyBF9fxfB0quecp_1kEMMT1ZLb6Ge8o7aUE';

//TODO: funcion para buscar direcciones en maps 



//Funciones para polilineas

Map<PolylineId, Polyline> polylines = {}; 


Future<List<LatLng>> obtenerPolilineas(LatLng o, LatLng d) async{

List<LatLng> coordenadas = []; 
PolylinePoints puntosPolyline = PolylinePoints(); 
PolylineResult result = await puntosPolyline.getRouteBetweenCoordinates(
  apiKey, 
  PointLatLng(o.latitude, o.longitude), 
  PointLatLng(d.latitude,d.longitude), 
  travelMode: TravelMode.driving);

if(result.points.isNotEmpty){
  result.points.forEach((PointLatLng point) {
    coordenadas.add(LatLng(point.latitude, point.longitude));
    });
  }
  return coordenadas; 
}



Future<void> generarRuta (Future<List<LatLng>> coordenadas) async {
 polylines ={}; 
 PolylineId id = const PolylineId('polilinea'); 
 Polyline polyline = Polyline(polylineId: id, color: const Color.fromARGB(126, 69, 3, 95), points:await coordenadas,
 width: 6);

 polylines[id] = polyline; 
 notifyListeners();
 
}

void limpiarPolylines () {
 polylines = {};
 notifyListeners();
}


}
