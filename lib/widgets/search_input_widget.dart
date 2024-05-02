

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
                getPlaceDetailWithLatLng: (prediction){ 
                  searchProv.coordenadas = LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!));
                  final mapsProv = Provider.of<MapProvider>(context, listen:false);
                  mapsProv.goToMarker(searchProv.coordenadas!);

                  searchProv.textController.clear();
                  searchProv.coordenadas = null;                      
                   
                },                
                itmClick: (prediction)  {  

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
