
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_map/firebase_options.dart';


import 'package:login_map/screens/screens.dart';
import 'package:login_map/services/auth_google.dart';
import 'package:login_map/services/services.dart';
import 'package:login_map/src/theme/tema.dart';


import 'package:login_map/provider/provider.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';

import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';


 
void main() async {
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    // Force Hybrid Composition mode.
    mapsImplementation.useAndroidViewSurface = true;}
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(AppState());
}

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService()),
        ChangeNotifierProvider(create: ( _ ) => AuthGoogleProvider()),
        ChangeNotifierProvider(create: ( _ ) => MarkersProvider()),
        ChangeNotifierProvider(create: ( _ ) => MapService()),
        ChangeNotifierProvider(create: ( _ ) => MapProvider()),
        ChangeNotifierProvider(create: ( _ ) => PlaceService()),
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
       theme: miTema,     
         );
   
  }
}