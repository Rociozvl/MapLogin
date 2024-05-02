

import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';

import 'package:login_map/provider/provider.dart';
import 'package:login_map/services/place_services.dart';




class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
  final searchProv = Provider.of<SearchingPlaceProvider>(context);  

  
  return Container( 
                  width: 150,
                  height: 50,
                  child:SearchAutoGoogle(searchProv: searchProv,),
                  );
   }
  }

class SearchAutoGoogle extends StatelessWidget {
  const SearchAutoGoogle({super.key, required this.searchProv});

 

  final SearchingPlaceProvider searchProv; 
  @override
  Widget build(BuildContext context) {

    return  Form(
              child: GooglePlacesAutoCompleteTextFormField(
                textEditingController: searchProv.textController,
                googleAPIKey: searchProv.apiKey,
                decoration: const InputDecoration(
                  hintText: 'Enter your address',
                  labelText: 'Address',
                  labelStyle: TextStyle(color: Color.fromARGB(226, 250, 237, 253)),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                // proxyURL: _yourProxyURL,
                maxLines: 1,
                overlayContainer: (child) => Material(                  
                  color: const Color.fromARGB(190, 38, 3, 61,),
                  borderRadius: BorderRadius.circular(12),
                  child: child,
                ),
                getPlaceDetailWithLatLng: (prediction){ 
                    searchProv.coordenadas = LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!));

                },                
                itmClick: (prediction) async {  
                   searchProv.textController.text = prediction.description!;

                    final mapsProv = Provider.of<MapProvider>(context, listen:false);  
                    final placeSer = Provider.of<PlaceService>(context, listen: false);        
                    final markerProv = Provider.of<MarkersProvider>(context, listen:false);              
                  
                    
                    markerProv.marcaDestino(searchProv.coordenadas!); 
                    placeSer.generarRuta(placeSer.obtenerPolilineas(mapsProv.inicioLoc.target, markerProv.destinos[0].position));
                    
                    await mapsProv.goToMarker(searchProv.coordenadas!);
                    
                    searchProv.textController.clear();
                    
                    },
                    onTap: () => searchProv.textController.clear(),
              ),
            ); 
           
  }
}
