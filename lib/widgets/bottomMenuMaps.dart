import 'package:flutter/material.dart';

import 'package:login_map/provider/provider.dart';

class BottomMenuMaps extends StatelessWidget {
  const BottomMenuMaps({super.key,  required this.mapProv});
  
  final MapProvider mapProv; 

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
    indicatorColor: const Color.fromRGBO(67, 1, 95, 0.8),
    backgroundColor: const Color.fromRGBO(17, 1, 23, 1),
      destinations: [
         IconButton(
          icon: const Icon(Icons.map_outlined), 
          onPressed: ()=> mapProv.changeType(), 
             
        ),

         IconButton(
          onPressed:mapProv.goToCenter,
            icon: const Icon(Icons.album_outlined),
          ),          
      ],
      
    ); 
    
  }
}
