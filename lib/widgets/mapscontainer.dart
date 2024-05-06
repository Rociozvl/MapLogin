
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:login_map/provider/provider.dart';
import 'package:login_map/services/maps_service.dart';
import 'package:login_map/services/place_services.dart';

import 'package:login_map/widgets/widgets.dart';




class MapsContainer extends StatelessWidget {
  const MapsContainer({key});

 
  @override
  Widget build(BuildContext context) {

    final mapsProv = Provider.of<MapProvider>(context);
    final markerProv = Provider.of<MarkersProvider>(context);
    final placeSer = Provider.of<PlaceService>(context);

   
      return Scaffold(
      body: GoogleMap(
        mapType: mapsProv.selectedType,
        initialCameraPosition: mapsProv.inicioLoc,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          mapsProv.mapsCtrl = controller;
        },
        markers: markerProv.destinos.isEmpty
        ? Set<Marker>.of(markerProv.marcas)
        : Set<Marker>.of(markerProv.marcas)..addAll(markerProv.destinos),
        polylines: Set.of(placeSer.polylines.values),
        onLongPress: (LatLng value) async {
          _showMyDialog(context, markerProv, value); 
          } ,
        onTap: (LatLng value) {
          markerProv.marcaDestino(value); 
          placeSer.generarRuta(placeSer.obtenerPolilineas(mapsProv.inicioLoc.target, markerProv.destinos[0].position));
       
       } 

       
      ),
      floatingActionButton: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ( _ ) => SearchingPlaceProvider()),
          ChangeNotifierProvider(create: ( _ ) => PlaceService()),
        ],
      child: const FloatbuttonMaps()),

      floatingActionButtonLocation:FloatingActionButtonLocation.startTop ,
      bottomNavigationBar: BottomMenuMaps(mapProv: mapsProv,),
     
    );
  }

  Future<void> _showMyDialog(BuildContext context, MarkersProvider mark, LatLng position) async {
  
  return showDialog<void>(
    context: context,
    barrierDismissible: false, 
    useSafeArea: true,
    builder: (BuildContext context) {
      return  MarkName(mark: mark, position: position,);
    },
   ); 
 }

}

class MarkName extends StatelessWidget {
  const MarkName({key, required this.mark,  required this.position});
  final MarkersProvider mark; 
  final LatLng position;  
 
  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(

      content: Form(            
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: mark.markCtrl,
                decoration:  const InputDecoration(
                     labelText: 'Nombre de la ubicación: '         
                ),
                     onChanged: (value) => mark.markName = value, 
              ),
            ),
        
      actions: [
                TextButton(
                  onPressed: (){
                    mark.markName = '';
                    mark.markCtrl.clear(); 
                    Navigator.of(context).pop();
                },
                  child: const Text('Cancelar')),
                 TextButton(
                  child: const Text('Aceptar'),
                    onPressed: ()async {
                        final mapsServ = Provider.of<MapService>(context, listen: false);
                        final markerProv = Provider.of<MarkersProvider>(context, listen: false);

                        await mapsServ.agregarMarker(position.latitude.toDouble(), position.longitude.toDouble(), mark.markName);
                        markerProv.refrescarLista(mapsServ.listadoMarkers);
                                  
                        mark.markCtrl.clear(); 
                        Navigator.of(context).pop();

                 },
                ),
              ],
    );
  }
}
