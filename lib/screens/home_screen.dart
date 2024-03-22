import 'package:flutter/material.dart';
import 'package:login_map/services/auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          icon: const Icon(Icons.output_outlined), 
          onPressed: () { 
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
           },)
      ),
      body: const Center(
        child: Text('HomeScreen'),
        
      ),
    );
  }
}