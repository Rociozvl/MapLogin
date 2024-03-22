import 'package:flutter/material.dart';


class NotificationsService {


  static GlobalKey<ScaffoldMessengerState> messengerKey =  GlobalKey<ScaffoldMessengerState>();


  static showSnackbar( String message ) {

    final snackBar =  SnackBar(
      
  
 content: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(88, 199, 48, 48),
          borderRadius: BorderRadius.circular(15),
         
          border: Border.all(
            color: const Color.fromARGB(255, 192, 32, 32),
            width: 2.0,
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Credenciales incorrectas',
                style: TextStyle(color: Color.fromARGB(255, 224, 42, 42), fontSize: 20),
              ),
            ),
           
              
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );

    messengerKey.currentState!.showSnackBar(snackBar);

  }


}