import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:login_map/provider/provider.dart';
import 'package:login_map/services/place_services.dart';





class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
  final searchProv = Provider.of<SearchingPlaceProvider>(context);  

  
  return Container( 
                padding: const EdgeInsets.only( bottom: 8),
                  width: 260,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                maxLines: 1,
                overlayContainer: (child) => Material(                  
                  color: const Color.fromARGB(190, 38, 3, 61,),
                  borderRadius: BorderRadius.circular(12),
                  child: child,
                ),
                getPlaceDetailWithLatLng: (prediction) async { 
                  searchProv.coordenadas = LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!));
                  final mapsProv = Provider.of<MapProvider>(context, listen:false);
                  await mapsProv.goToMarker(searchProv.coordenadas!);

                  final markProv = Provider.of<MarkersProvider>(context, listen: false); 
                  markProv.marcaDestino(searchProv.coordenadas!); 

                  final placeSer = Provider.of<PlaceService>(context, listen: false);
                  await placeSer.generarRuta(placeSer.obtenerPolilineas(mapsProv.inicioLoc.target , searchProv.coordenadas!)); 
                    
                  searchProv.textController.clear();
                  searchProv.coordenadas = null;                      
                   
                },                
                itmClick: (prediction) async {  

                      searchProv.textController.text = prediction.description!;
                      searchProv.textController.clear();

                    },
                    onTap: () { searchProv.textController.clear();
                      searchProv.coordenadas = null; 
                    },
              ),
            ); 
           
  }
}
