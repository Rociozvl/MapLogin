


//clave api maps : AIzaSyAE-uoP1Ckzs5hmlPZP36uRA-NoQXQlDjc

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;

import 'package:login_map/src/models/marker_model.dart';


class MapService extends ChangeNotifier{


List<MarkerModel> listadoMarkers =[]; 
final String baseURL ='mapsloginextrado-default-rtdb.firebaseio.com'; 
final String apiKey = ''; //No genero  apikey por ahora

String email = ''; 
//post - Crear Coordenada
Future<String?> agregarMarker ( double lat, double long )async {
  
    MarkerModel coordenada =  MarkerModel(
      lat: lat, 
      long: long, 
      markerId: 'Marker${listadoMarkers.length + 1}', 
      idUser: email); 

    var getUrl = Uri.https(baseURL, 'Coordenadas.json');
    var response = await http.post(getUrl, body: jsonEncode(coordenada));  

   if (response.statusCode == 200) {
      
       await ultimaMarker();   
       notifyListeners(); 
       return null; 
       
   } else {
      return response.statusCode.toString(); 
   }
  
}

//Recuperar ultima marca  
//TODO:  REVISAR
Future<String?> ultimaMarker () async{
  
    var getUrl = Uri.https(baseURL, 'Coordenadas.json', {'orderBy': '"idUser"', 'equalTo': '"$email"', 'limitToLast': '1'});
    var response = await http.get(getUrl);  

  if(response.statusCode == 200) {

      var data = json.decode(response.body);
      data.forEach((key, value){
        final mark = MarkerModel.fromJson(value.first);  
        mark.name = key; 
        listadoMarkers.add(mark); 

      }); 

      notifyListeners(); 
      return null; 

  } else {
    return response.statusCode.toString();
  }
}

//get - Recuperar Coordenada
Future<String?> recuperarMarkers () async{

    var getUrl = Uri.https(baseURL, 'Coordenadas.json', {'idUser':'"$email"'});
    var response = await http.get(getUrl);  

  if(response.statusCode == 200) {

      var data = json.decode(response.body);
      data.forEach((key, value){

        final mark = MarkerModel.fromJson(value);  
        mark.name = key; 
        listadoMarkers.add(mark); 

      }); 

      notifyListeners(); 
      return null; 

  } else {
    return response.statusCode.toString();
  }
}

//DELETE - Eliminar Coordenada  
//TODO: CORREGIR

Future<String?> eliminarMarker (MarkerModel marca) async {

    var getUrl = Uri.https(baseURL, 'Coordenadas.json',  );
    var response = await http.delete(getUrl, headers: {'name': marca.name}); 

    if (response.statusCode == 200) {
           final index = listadoMarkers.indexWhere((name)=> name == marca.name);
           listadoMarkers.removeAt(index);  
          
           notifyListeners(); 

            return null; 

      } else {
          return response.statusCode.toString(); 
      }
}


}