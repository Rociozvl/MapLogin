import 'package:flutter/material.dart';
import 'package:login_map/provider/login_form_provider.dart';
import 'package:login_map/services/auth_service.dart';
import 'package:login_map/services/notifcations_services.dart';
import 'package:login_map/ui/input_decorations.dart';
import 'package:login_map/widgets/auth_background.dart';
import 'package:login_map/widgets/card_container.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';
class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox( height: 250 ),

              CardContainer(
                child: Column(
                  children: [

                    const SizedBox( height: 10 ),
                    Text('Sing Up', style: Theme.of(context).textTheme.headlineMedium ),
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
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'), 
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all( const Color.fromARGB(255, 230, 231, 233).withOpacity(0.1)),
                  shape: MaterialStateProperty.all( StadiumBorder() )
                ),
                child: const Text('Already have an account?', style: TextStyle( fontSize: 18, color: Color.fromARGB(221, 236, 234, 234) ),)
              ),
              const SizedBox( height: 50 ),
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
              decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Password',
                prefixIcon:Icons.lock_outline   
              ),
              onChanged: ( value ) => loginForm.password = value,
              validator: ( value ) {

                  return ( value != null && value.length >= 6 ) 
                    ? null
                    : 'La contraseña debe contener al menos 6 caracteres';                                    
                  
              },
            ),

            const SizedBox( height: 30 ),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: loginForm.isLoading ? null : () async {
                
                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);
                
                if( !loginForm.isValidForm() ) return;

                loginForm.isLoading = true;


                // TODO: validar si el login es correcto
                final String? errorMessage = await authService.createUser(loginForm.email, loginForm.password);

                if ( errorMessage == null ) {

                         final mapService = Provider.of<MapService>(context, listen: false);
                         mapService.email = loginForm.email; 

                  Navigator.pushReplacementNamed( context, 'home');
                } else {
                  // TODO: mostrar error en pantalla
                  NotificationsService.showSnackbar(errorMessage);
                  print( errorMessage );
                  loginForm.isLoading = false;
                }
              },
                child:  Container(
                padding: const EdgeInsets.symmetric( horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading 
                    ? 'Espere'
                    : 'Sing up',
                  style: const TextStyle( color: Colors.white ),
                )
              )
            )

          ],
        ),
      ),
    );
  }
}