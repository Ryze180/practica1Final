import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/dish.dart';

// ---------- PANTALLA DE DETALLE ----------
class DetailView extends StatelessWidget {
  // Plato recibido desde la lista a través del constructor
  final Dish dish;

  const DetailView({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF5F1),
      appBar: AppBar(
        title: Text(dish.name),
        backgroundColor: const Color(0xFF2D6A4F),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto del plato
            Hero(
              tag: 'dish-${dish.id}', // mismo tag que en la lista
              child: Image.network(
                dish.imageUrl,
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 280,
                  color: const Color(0xFFD8E9DF),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.leaf,
                      size: 64,
                      color: Color(0xFF2D6A4F),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B4332),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    dish.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.leaf,
                        size: 18,
                        color: Color(0xFF2D6A4F),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Vegano · ${dish.price.toStringAsFixed(2)} €',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D6A4F),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
