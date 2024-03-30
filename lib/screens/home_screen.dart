import 'package:flutter/material.dart';

import 'package:login_map/provider/provider.dart';
import 'package:login_map/services/auth_service.dart';
import 'package:login_map/services/maps_service.dart';

import 'package:login_map/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

 

  @override
  Widget build(BuildContext context) {

   
    final mapService = Provider.of<MapService>(context);
    final markerProv = Provider.of<MarkersProvider>(context);

    //Desde correo  traer de marker services listado
    Future recuperarMarkers () async {

       final String? marker = await mapService.recuperarMarkers(); 

       marker!.isEmpty
       ? markerProv.cargarLista(mapService.listadoMarkers)
       : null; 

    }

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          /* 
          IconButton(
            icon: const Icon(Icons.person_2_outlined), 
            onPressed: () { 
              // TODO: IR AL PERFIL
          },),
          */
          
          PopupMenuButton(
            initialValue: 0,
             itemBuilder: (BuildContext context) => [
                for (int i = 0; i < markerProv.marcas.length; i++)
                    PopupMenuItem(
                      value: markerProv.marcas[i].position,
                      child: Text(markerProv.marcas[i].markerId.value),
                      onTap: () {
                        final mapProv = Provider.of<MapProvider>(context);
                        mapProv.goToMarker(markerProv.marcas[i]); 
                      }
                    ),
  ],
          ),
          
          
          IconButton(
            icon: const Icon(Icons.edit_location_outlined), 
            onPressed: () { 
              // TODO: mostrar listado de coordenadas guardadas
          
          },),


          IconButton(
            icon: const Icon(Icons.output_outlined), 
            onPressed: () { 
              final authService = Provider.of<AuthService>(context, listen: false);
              
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
          },),
       ],
      ),

      
      body:  Center(
        child: ChangeNotifierProvider<MapProvider>(
          create: ((context) => MapProvider()),   
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: 350,
              height: 700,
              child: const Center 
              (child:  MapsContainer())),
          )),
        
      ),
    );
  }
}

