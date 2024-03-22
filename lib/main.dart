
import 'package:flutter/material.dart';
import 'package:login_map/screens/screens.dart';
import 'package:login_map/services/services.dart';

import 'package:login_map/src/theme/tema.dart';
import 'package:provider/provider.dart';




 
void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService() ),
       
       
      ],
      child: MyApp(),
    );
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     initialRoute: 'login',
     routes: {
          'login'   : ( _) => LoginScreen(),
          'home'    : ( _)=> const HomeScreen(),
          'register' : ( _)=> RegisterScreen()
       
     },
     scaffoldMessengerKey: NotificationsService.messengerKey  ,
       theme: miTema,       );
   
  }
}