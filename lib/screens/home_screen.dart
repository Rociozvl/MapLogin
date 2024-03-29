import 'package:flutter/material.dart';

import 'package:login_map/provider/provider.dart';
import 'package:login_map/services/auth_service.dart';

import 'package:login_map/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
  

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [ 
          IconButton(
            icon: const Icon(Icons.person_2_outlined), 
            onPressed: () { 
              // TODO: IR AL PERFIL
          },),
          IconButton(
            icon: const Icon(Icons.edit_location_outlined), 
            onPressed: () { 
              // TODO: mostrar listado de coordenadas guardadas
          },),
          IconButton(
            icon: const Icon(Icons.output_outlined), 
            onPressed: () { 
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

