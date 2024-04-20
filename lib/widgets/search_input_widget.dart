import 'package:flutter/material.dart';


class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({key});

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: 150,
                  height: 50,
                  child: TextFormField(
                    decoration:const InputDecoration(
                      label: Text('¿a dónde voy?'),
                    ),
                  ),
                );
    
  }
}