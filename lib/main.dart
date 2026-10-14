import 'package:flutter/material.dart';
import 'views/main_view.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: 'P1 IPC',
        debugShowCheckedModeBanner: false,  // Oculta el banner que aparece en la esquina superior derecha
        home: MainView(), // Widget principal de main_view.dart
      );
}