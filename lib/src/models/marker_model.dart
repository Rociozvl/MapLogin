import 'dart:convert';

class MarkerModel {

 double lat;
 double long;
 String markerId; //markedID
 // para rescatar solo listado del user  
 String idUser;
 late String name;  


 MarkerModel({
  required this.lat,
  required this.long, 
  required this.markerId,
  required this.idUser
 });

 factory MarkerModel.fromRawJson(String str) => MarkerModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MarkerModel.fromJson(Map<String, dynamic> json) => MarkerModel(
        markerId: json["markerId"],
        lat: json["lat"]!.toDouble(),
        long: json["long"]!.toDouble(),
        idUser: json["idUser"],
    );

    Map<String, dynamic> toJson() => {
        "markerId": markerId,
        "lat": lat,
        "long": long,
        "idUser": idUser,
    };




}