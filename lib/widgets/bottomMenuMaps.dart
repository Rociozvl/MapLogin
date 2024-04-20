import 'package:flutter/material.dart';

import 'package:login_map/provider/provider.dart';

class BottomMenuMaps extends StatelessWidget {
  const  BottomMenuMaps({key,  required this.mapProv});
  
  final MapProvider mapProv; 

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
    height: 55,
    indicatorColor: const Color.fromRGBO(67, 1, 95, 0.8),
    backgroundColor: const Color.fromARGB(255, 38, 3, 61),
      destinations: [
         IconButton(
          icon: const Icon(Icons.map_outlined), 
          onPressed: ()=> mapProv.changeType(), 
             
        ),

         IconButton(
          
          onPressed:(){
          //final mapsProv = Provider.of<MapProvider>(context, listen: false);
          //mapProv.determinarPosicion();
          mapProv.goToCenter();
          
          },
            icon: const Icon(Icons.album_outlined),
          ),          
      ],
      
    ); 
    
  }
}
