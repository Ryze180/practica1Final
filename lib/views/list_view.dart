import 'package:flutter/material.dart';

// No la llamo ListView porque ya existe un widget de Flutter con ese nombre
class RoutesView extends StatelessWidget {
  const RoutesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // La AppBar añade sola la flecha para volver atrás
      appBar: AppBar(
        title: const Text('MIS PLATOS'),
        backgroundColor: const Color(0xFF2D6A4F),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 80, color: Color(0xFF2D6A4F)),
            SizedBox(height: 16),
            Text(
              '¡Bienvenido a nuestro restaurante !',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Has entrado correctamente'),
          ],
        ),
      ),
    );
  }
}