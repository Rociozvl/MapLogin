import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_map/provider/login_form_provider.dart';
import 'package:login_map/services/auth_google.dart';
import 'package:login_map/services/auth_service.dart';
import 'package:login_map/services/notifcations_services.dart';
import 'package:login_map/ui/input_decorations.dart';
import 'package:provider/provider.dart';

import '../services/maps_service.dart';
import '../widgets/auth_background.dart';
import '../widgets/card_container.dart';


  
  
class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox( height: 250 ),

              CardContainer(
                child: Column(
                  children: [

                    const SizedBox( height: 10 ),

                    Text('Sing In', style: Theme.of(context).textTheme.headlineMedium ,selectionColor: Colors.black ),

                    const SizedBox( height: 30 ),
                    
                     ChangeNotifierProvider(
                       create: ( _ ) => LoginFormProvider(),
                       child: _LoginForm()
                     )
                    

                  ],
                )
              ),

              const SizedBox( height: 50 ),
              TextButton(

                onPressed: () => Navigator.pushReplacementNamed(context, 'register'), 

                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all( const Color.fromARGB(255, 235, 235, 238).withOpacity(0.1)),
                  shape: MaterialStateProperty.all( const StadiumBorder() )
                ),
                child: const Text('don´t have an account?', style: TextStyle( fontSize: 18, color: Color.fromARGB(221, 245, 240, 240) ),)
              ),
              const SizedBox( height: 20 ),

              ElevatedButton(
               onPressed: () async {
                UserCredential? userCredential = await signInWithGoogle();
                  if (userCredential != null) {
                  print("Usuario autenticado con Google: ${userCredential.user!.displayName}");
    }              Navigator.pushReplacementNamed(context, 'home');
  },
                  child: const Text("Iniciar sesión con Google"),
                  ),
                 
            ],
          ),
        )
      )
   );
  }
}


class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [
            
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration:  InputDecorations.authInputDecoration(
                hintText: 'example@gmail.com',
                labelText: 'Email',
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: ( value ) => loginForm.email = value,
              validator: ( value ) {

                  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  =  RegExp(pattern);
                  
                  return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';

              },
            ),

            const SizedBox( height: 30 ),

            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration:   InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Password',
                prefixIcon:Icons.lock_outline 
              ),
              onChanged: ( value ) => loginForm.password = value,
              validator: ( value ) {

                  return ( value != null && value.length >= 6 ) 
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';                                    
                  
              },
            ),

            const SizedBox( height: 30 ),

             MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      disabledColor: const Color.fromARGB(255, 5, 5, 5),
                      color:Colors.deepPurple,

                      onPressed: loginForm.isLoading ? null : () async{
                       final authService = Provider.of<AuthService>(context, listen: false);
                       if( !loginForm.isValidForm()) return;

                       loginForm.isLoading = true;
                        // TODO: validar si el login es correcto
                       final String? errorMessage = await authService.login(loginForm.email, loginForm.password);
                       if ( errorMessage == null ) {
                       
                       final mapService = Provider.of<MapService>(context, listen: false);
                       mapService.email = loginForm.email; 
                       
                       Navigator.pushReplacementNamed(context, 'home');
                       } else {
                       // TODO: mostrar error en pantalla
                       // print( errorMessage );
                       NotificationsService.showSnackbar(errorMessage);
                       loginForm.isLoading = false;
                  }

                      },
                      child: Container(
                        padding:  const EdgeInsets.symmetric( horizontal: 50 , vertical: 15),
                        child:  Text(
                          loginForm.isLoading
                          ? 'Espere unos momentos..'
                          :'Log in',

                        style: const TextStyle( color: Colors.white),
                        ),
                         )
                         )
          ]
        ),
      ),
    );
  }
}
  