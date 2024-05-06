
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';




 class AuthGoogleProvider extends ChangeNotifier{

  final FirebaseAuth _auth = FirebaseAuth.instance;
   final GoogleSignIn googleSignIn = GoogleSignIn();

   final storage =  FlutterSecureStorage();
   Future<UserCredential?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
        
      );
     
          final userCredential = await _auth.signInWithCredential(credential);
          print('uid');
          print(userCredential.user?.uid);
        if (userCredential != null && userCredential.user != null) {
        // Guardar el ID token en el almacenamiento seguro
        await storage.write(key: 'token', value: userCredential.user?.uid);
         }

      return userCredential;
      }
          
    
  } catch (error) {
    print("Error al iniciar sesión con Google: $error");
  }
  return null;
}

  // Future logout() async {
  //   await storage.delete(key: 'token');
  //   return;
  // }
   Future<String> readToken() async {

    return await storage.read(key: 'token') ?? '';
    

  }




void signOutGoogle() async {
  try {
    await storage.delete(key: 'token');
    await googleSignIn.signOut();
    print("Usuario desconectado");

    // Eliminar el token del almacenamiento seguro al cerrar sesión
    
  } catch (error) {
    print("Error al cerrar sesión con Google: $error");
  }
}

 }
