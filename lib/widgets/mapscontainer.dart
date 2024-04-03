
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:login_map/provider/provider.dart';
import 'package:login_map/services/maps_service.dart';
import 'package:login_map/widgets/widgets.dart';




class MapsContainer extends StatelessWidget {
  const MapsContainer({super.key});

  Future<void> peticionHttp () async{
    print('ejecutó función'); 

    //TODO: peticion http
  }

  @override
  Widget build(BuildContext context) {

    final mapsProv = Provider.of<MapProvider>(context);
    final markerProv = Provider.of<MarkersProvider>(context);
    
      return Scaffold(
      body: GoogleMap(
        mapType: mapsProv.selectedType,
        initialCameraPosition: mapsProv.inicioLoc,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          mapsProv.mapsCtrl = controller;

        },
        markers: Set<Marker>.of(markerProv.marcas),   
      
        onTap: (LatLng value) async {

          //TODO:  ASIGNAR NOMBRE A MI MARCA

          markerProv.mostrarMarker(value, 'Marker${markerProv.marcas.length + 1}'); 
          
          final mapsServ = Provider.of<MapService>(context, listen: false); 

          await mapsServ.agregarMarker(value.latitude.toDouble(), value.longitude.toDouble()); 
          


        }
      ),
     
      bottomNavigationBar: BottomMenuMaps(mapProv: mapsProv,),
     
    );
  }

}

/*
 Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>();  
    
    }



class _MarkName extends StatelessWidget {
  const _MarkName({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}*/