import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:login_map/provider/maps_provider.dart';
import 'package:login_map/widgets/widgets.dart';




class MapsContainer extends StatelessWidget {
  const MapsContainer({super.key});


  @override
  Widget build(BuildContext context) {

    final mapsProv = Provider.of<MapProvider>(context);

    DeterminarLocacion () {
      
       mapsProv.DeterminarPosicion();  
    }

    return Scaffold(
      body: GoogleMap(
        mapType: mapsProv.selectedType,
        initialCameraPosition: mapsProv.inicioLoc,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          mapsProv.mapsCtrl.complete(controller);
        },
      ),
      bottomNavigationBar: BottomMenuMaps(mapProv: mapsProv,),
    );
  }

}

