

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';


class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
  
    String buscarLugar = ''; 
    
   return Container( 

                  width: 150,
                  height: 50,
                  //TODO:  CAMBAIR A MENU DROPDOWN ¿? 
                  child: TextFormField(
                    decoration:const InputDecoration(
                      label: Text('¿a dónde voy?'),
                    ),
                    onChanged: (value) => buscarLugar = value ,
                    onEditingComplete: () async {
                     
                    },
                  ),
                );
   }

  }
  /*
class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
   final placeServ = Provider.of<PlaceService>(context); 
   
   return Container(
    width: 150,
    height: 50,
    child: TypeAheadField(
      debounceDuration: const Duration(milliseconds: 100),
      itemBuilder: (context, snapshot) {
       
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                title: Text(placeServ.listadoPredicciones[i].description),
              );
            },
          ),
        );
        } else {
          return const Center(child: Text('error'),);
        }
       
      }, 
      onSelected: (suggestion){
        //TODO:  ir hasta suggestion y mostrar ruta!!!
        // de la ruta seleccionada tomar latlang e ir al punto 
        }, 
      suggestionsCallback: (search) async{ 

        final mapsProv = Provider.of<MapProvider>(context, listen: false); 
         await placeServ.buscarLugar(search, mapsProv.inicioLoc.target.latitude, mapsProv.inicioLoc.target.longitude);
    
          return placeServ.listadoPredicciones; 
        },
      builder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            labelText: '¿A dónde vas?',
          ),
        );},
      ),
   ); 
  }
}

    return Container(
                  width: 150,
                  height: 50,
                  //TODO:  CAMBAIR A MENU DROPDOWN ¿? 
                  child: TextFormField(
                    decoration:const InputDecoration(
                      label: Text('¿a dónde voy?'),
                    ),
                    onChanged: (value) => buscarLugar = value ,
                    onEditingComplete: () async {
                       final placeService = Provider.of<PlaceService>(context, listen: false); 
                       placeService.buscarLugar(buscarLugar); 
                    },
                  ),
                );*/
  