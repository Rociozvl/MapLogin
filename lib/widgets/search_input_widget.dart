
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