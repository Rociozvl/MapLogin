
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:login_map/provider/provider.dart';
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
    
    Future determinarPosicion () async {
      await  mapsProv.determinarPosicion();  
    }
  
  
    return Scaffold(
      body: GoogleMap(
        mapType: mapsProv.selectedType,
        initialCameraPosition: mapsProv.inicioLoc,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          mapsProv.mapsCtrl.complete(controller);
        },
        markers:markerProv.marcas.isEmpty
        ? Set<Marker>.of(markerProv.marcas)
        : Set(),
      
           
        onTap: (LatLng value)  {
          markerProv.mostrarMarker(value, 'prueba', peticionHttp); 
          print('coordenadas tap: $value');

        }
      ),
     
      bottomNavigationBar: BottomMenuMaps(mapProv: mapsProv,),
     
    );
  }

}

