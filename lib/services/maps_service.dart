


//clave api maps : AIzaSyAE-uoP1Ckzs5hmlPZP36uRA-NoQXQlDjc

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:login_map/src/models/marker_model.dart';


class MapService extends ChangeNotifier{


List<MarkerModel> listadoMarkers =[]; 
final String baseURL ='https://mapsloginextrado-default-rtdb.firebaseio.com/Coordenadas.json'; 
final String apiKey = ''; //No genero  apikey por ahora

String email = ''; 
//post - Crear Coordenada
Future<String?> agregarMarker (MarkerModel coordenada)async {
 
    var getUrl = Uri.https(baseURL);
    var response = await http.post(getUrl, body: jsonEncode(coordenada));  

   if (response.statusCode == 200) {
        notifyListeners(); 
        return null; 
   } else {
      return response.statusCode.toString(); 
   }
  
}

//get - Recuperar Coordenada
Future<String?> recuperarMarkers () async{

    var getUrl = Uri.https(baseURL);
    var response = await http.get(getUrl, headers:{
      'idUser':email
    });  

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

Future<String?> eliminarMarker (MarkerModel marca) async {

    var getUrl = Uri.https(baseURL);
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