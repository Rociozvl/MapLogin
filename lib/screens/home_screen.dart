import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:login_map/provider/provider.dart';
import 'package:login_map/services/auth_google.dart';
import 'package:login_map/services/auth_service.dart';
import 'package:login_map/services/maps_service.dart';




import 'package:login_map/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    recuperarMarkers();
    //determinarPosicion(); 
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
     final mapSer = Provider.of<MapService>(context);

    return  Scaffold(
      appBar: AppBar(
        
       backgroundColor: const Color.fromARGB(255, 38, 3, 61),
        toolbarHeight: 80,
      
        actions: [
          markerProv.marcas.isNotEmpty
              ?  DropdownMenu<Marker>(
                
                    width: 300,
                     leadingIcon: const Icon(Icons.edit_location_outlined),
                     label: const Text('Guardados'),
                     onSelected:(value) async  { 
                      try{
                            final mapProv = Provider.of<MapProvider>(context, listen: false);
                            await mapProv.goToMarker(value!.position); 
                
                      } catch (e) {
                        print (e); 
                      }
                     
                     },
                      initialSelection: null,    
                        
                      dropdownMenuEntries: markerProv.marcas.map<DropdownMenuEntry<Marker>>((Marker value) {
                            return DropdownMenuEntry<Marker>(
                             
                              value: value, 
                              
                              label: value.markerId.value,
                              leadingIcon: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  var markDelete = mapSer.listadoMarkers.firstWhere((marker) => marker.markerId == value.markerId.value && marker.lat == value.position.latitude); 
                                  
                                  print(markDelete.markerId + markDelete.name); 
                
                                  final String? delete = await mapSer.eliminarMarker(markDelete); 
                                  
                                  delete == null
                                  ? markerProv.refrescarLista(mapSer.listadoMarkers)
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('No se pudo eliminar el registro')),        
                                    );
                                },
                                )
                                );
                              }).toList(),
                       )                  
              : 
             
           
                    Column(
                      
                      children:[
                        IconButton( 
                                     
                      icon: const Icon(Icons.add, ),
                      onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Toca el mapa para agregar tu primer marcador')),        
                      ); 
                      }),
                        const Text('Agregar ubicaciones'),
                        const SizedBox(width: 250,)
                      ] 
                      
                    ),
                    
                 
                 
            

          const SizedBox(width: 20,),
          IconButton(
            icon: const Icon(Icons.output_outlined), 
            onPressed: () { 
              _mostrarDialogo(context);
               mapSer.listadoMarkers.clear();  
               markerProv.marcas.clear();
               final authService = Provider.of<AuthService>(context, listen: false);
               authService.logout();
            
              //  Navigator.pushReplacementNamed(context, 'login');
          },),
       ],
      ),

      
      body:  Center(
        child: Container(
              padding: const EdgeInsets.all(3),
              child: const Center 
              (child:  MapsContainer())),
          )
    );
   }

  
    
  void _mostrarDialogo(BuildContext context) {
        showDialog(context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                   title: const Text('¿Desea salir de la página?'),
                   actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                //Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, 'login');
                 // Pop de nuevo para salir de la página
              
                      signOutGoogle();
                    
                  

              },
              child: const Text('Sí'),
            ),
          ],
        );
            
            }

          );
      }
          
      
}



