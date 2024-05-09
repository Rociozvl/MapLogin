import 'package:flutter/material.dart';
import 'package:login_map/provider/provider.dart';
import 'package:login_map/widgets/widgets.dart';

//Widget para buscador 


class FloatbuttonMaps extends StatelessWidget {
  const FloatbuttonMaps({key});

  @override
  Widget build(BuildContext context) {
    final searchProv = Provider.of<SearchingPlaceProvider>(context); 

    return   Container(
      padding: const EdgeInsets.only(top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50), 
        child: Container(
          
          //padding: EdgeInsets.only(top: 10),
          height: 50,
          width: 350,
          color:searchProv.estadoInput
          ? const Color.fromARGB(190, 38, 3, 61,)
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
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(190, 38, 3, 61,)),
                ),
              ),
              const SizedBox(width: 10,),
      
              searchProv.estadoInput
                ? const SearchInputWidget()
                : Container( width: 1, height: 1,),
               
              ] 
          ),
        ),
      ),
    );

//TODO: intentar hacer animacion slidetransition

  }
}
