import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:login_map/provider/provider.dart';
import 'package:login_map/services/auth_service.dart';
import 'package:login_map/services/maps_service.dart';

import 'package:login_map/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    recuperarMarkers();
    determinarPosicion(); 
  }

    //Desde correo  traer de marker services listado
   Future recuperarMarkers () async {

    final mapService = Provider.of<MapService>(context, listen: false);
    final markerProv = Provider.of<MarkersProvider>(context, listen: false);
    
    print('entro a recuperar'); 

    final String? marker = await mapService.recuperarMarkers(); 

        marker == null 
        ? await markerProv.cargarLista(mapService.listadoMarkers)
        : print (marker);
    }
    
      @override
      Widget build(BuildContext context) {
   final markerProv = Provider.of<MarkersProvider>(context);

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
                markerProv.marcas.isNotEmpty
              ?  DropdownMenu<Marker>(
                   leadingIcon: const Icon(Icons.edit_location_outlined),
                   onSelected:(value) async  {
                    print(value!.position.toString());  
                    //chequeado, funciona latlng 

                    final mapProv = Provider.of<MapProvider>(context, listen: false);
                    await mapProv.goToMarker(value.position); 

                   },
                    initialSelection: null,       
                    dropdownMenuEntries: markerProv.marcas.map<DropdownMenuEntry<Marker>>((Marker value) {
                          return DropdownMenuEntry<Marker>(
                            value: value, 
                            label: value.markerId.value,
                            leadingIcon: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                //TODO:  BORRAR MARCA Y ACTUALIZAR LISTADO

                              },
                              ) );
                     }).toList(),
                  )              
              : IconButton(
                icon: const Icon(Icons.location_off),
                onPressed: (){
                      ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No tienes marcadores agregados')),        
                );
                }
             ),
      

          IconButton(
            icon: const Icon(Icons.output_outlined), 
            onPressed: () { 

              final mapSer = Provider.of<MapService>(context, listen: false);
              mapSer.listadoMarkers =[]; 
              markerProv.marcas = []; 

              final authService = Provider.of<AuthService>(context, listen: false);
              authService.logout();

              Navigator.pushReplacementNamed(context, 'login');
          },),
       ],
      ),

      
      body:  Center(
        child:  ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(3),
              child: const Center 
              (child:  MapsContainer())),
          )),
    );
   }

   Future determinarPosicion () async {
      
      final mapsProv = Provider.of<MapProvider>(context, listen: false);
      await  mapsProv.determinarPosicion();  

    }


}

