import 'package:flutter/material.dart';
import 'list_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo verde oscuro de toda la pantalla
      backgroundColor: const Color(0xFF1B4332),
      body: Center(
        // Tarjeta blanca donde va todo el contenido
        child: Container(
          width: 320,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            // Hace que la tarjeta solo ocupe lo necesario
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.restaurant, size: 64, color: Color(0xFF2D6A4F)),
              const SizedBox(height: 8),
              const Text(
                'Ali & Anas',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B4332),
                ),
              ),
              const SizedBox(height: 4),
              const Text('Bienvenidos a nuestro restaurante'),
              const SizedBox(height: 24),

              // Formulario básico
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true, // Oculta lo que se escribe
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              // Área interactiva que navega a la segunda pantalla
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RoutesView()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D6A4F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Entrar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

          
              
            ],
          ),
        ),
      ),
    );
  }
}