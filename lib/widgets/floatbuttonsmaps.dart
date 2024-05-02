import 'package:flutter/material.dart';
import 'package:login_map/provider/provider.dart';
import 'package:login_map/widgets/widgets.dart';

//Widget para buscador 


class FloatbuttonMaps extends StatelessWidget {
  const FloatbuttonMaps({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProv = Provider.of<SearchingPlaceProvider>(context); 

    return   ClipRRect(
      borderRadius: BorderRadius.circular(50), 
      child: Container(
        width: 300,
        color:searchProv.estadoInput
        ? Color.fromARGB(190, 38, 3, 61,)
        : null,
        child: Row(      
          children:[
            IconButton(
              onPressed: () {
                //Al tocar con un hero se expanda y abra un input para poder buscar         
                searchProv.estadoInput
                ? searchProv.estadoInput = false
                :searchProv.estadoInput = true; 

                searchProv.textController.clear();
          
              },
              icon: const Icon(Icons.search_outlined, color: Color.fromARGB(255, 226, 214, 233),
              ),
              iconSize: 30,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(190, 38, 3, 61,)),
              ),
            ),
            SizedBox(width: 20,),

            searchProv.estadoInput
              ? SearchInputWidget()
              : Container( width: 1, height: 1,),
             
            ] 
        ),
      ),
    );

//TODO: intentar hacer animacion slidetransition

  }
}
