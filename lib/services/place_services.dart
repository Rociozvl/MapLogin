
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



void generarRuta (Future<List<LatLng>> coordenadas) async {
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





/*
class PlaceService extends ChangeNotifier{


static String apiKey = 'AIzaSyBF9fxfB0quecp_1kEMMT1ZLb6Ge8o7aUE';
static String urlGoogleMaps = 'maps.googleapis.com';
static String endpointPlaces = '/maps/api/place/details/json';
static String endpointAutocomplete= '/maps/api/place/autocomplete/json';
static String endpointDirection= '/maps/api/directions/json';


List<PredictionPlace> listadoPredicciones =[]; 

Future<void> buscarLugar (String lugar, double lat, double long) async {
  
  Map<String,  dynamic> input ={
    'input' : lugar,
    'includedPrimaryTypes' : '(cities|geocode)',
    'languageCode': 'es',
    'key': apiKey,
    
  };

  final getUrl = Uri.https(urlGoogleMaps,endpointAutocomplete, input); 
  final response = await http.get(getUrl);

  print('recuperando data ...'); 

  print(response.statusCode); 
  print(response.body); 

  if(response.statusCode == 200) {
    
    var data=json.decode(response.body)['predictions'];

   try {
         data.forEach((value){

          final lugar = PredictionPlace.fromJson(value); 
          print(lugar.description);
          listadoPredicciones.add(lugar);

          notifyListeners();
          });

   } catch (e) {
      print(e.toString() + response.statusCode.toString()); 
   }
  }

 }

//limpiar data 
void terminaBusqueda () {
  listadoPredicciones = []; 
}


}*/