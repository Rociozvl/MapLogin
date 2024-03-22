import 'package:flutter/material.dart';



class CardContainer extends StatelessWidget {

  final Widget child;

  const CardContainer({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 30 ),
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all( 20 ),
          decoration: _createCardShape(),
          child: this.child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
    color:Colors.transparent,
    borderRadius: BorderRadius.circular(35),
    boxShadow: const [
     BoxShadow(
        color: Colors.black12,
        blurRadius: 15,
        offset: Offset(0, 5),
      )
    ],
      border: Border.all(
        color: Colors.white, // Color del borde blanco
        width: 0.5, // Ancho del borde blanco
      ),
  );
}