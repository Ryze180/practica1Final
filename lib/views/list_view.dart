import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/dish.dart';
import 'detail_view.dart';

// ---------- PANTALLA DE LA LISTA ----------
class RoutesView extends StatefulWidget {
  const RoutesView({super.key});

  @override
  State<RoutesView> createState() => _RoutesViewState();
}

class _RoutesViewState extends State<RoutesView> {
  // Future con la carta; se crea una sola vez en initState
  late Future<Menu> _futureMenu;

  // Texto escrito en el buscador
  String _search = '';

  @override
  void initState() {
    super.initState();
    _futureMenu = _loadMenu();
  }

  // Carga y parsea el fichero .json local de forma asíncrona
  Future<Menu> _loadMenu() async {
    // Pequeña espera para que se vea el indicador de progreso
    await Future.delayed(const Duration(seconds: 1));
    final String jsonString = await rootBundle.loadString('assets/menu.json');
    final Map<String, dynamic> data = json.decode(jsonString);
    return Menu.fromJson(data);
  }

  // Abre la pantalla de detalle pasando el plato por el constructor
  void _openDetail(BuildContext context, Dish dish) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailView(dish: dish)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF5F1),
      appBar: AppBar(
        title: const Text('Nuestros platos'),
        backgroundColor: const Color(0xFF2D6A4F),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Caja de texto para filtrar los platos
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar plato...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _search = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<Menu>(
              future: _futureMenu,
              builder: (context, snapshot) {
                // Error al cargar o parsear el .json
                if (snapshot.hasError) {
                  return const Center(child: Text('No se ha podido cargar la carta'));
                }
                // Mientras se carga: indicador de progreso
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF2D6A4F)),
                  );
                }
                // Platos que coinciden con la búsqueda (nombre o descripción)
                final dishes = snapshot.data!.dishes
                    .where((d) =>
                        d.name.toLowerCase().contains(_search) ||
                        d.description.toLowerCase().contains(_search))
                    .toList();
                if (dishes.isEmpty) {
                  return const Center(child: Text('No se han encontrado platos'));
                }
                // Lista perezosa: solo construye los platos que se ven en pantalla
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: dishes.length,
                  itemBuilder: (context, index) {
                    final dish = dishes[index];
                    return DishCard(
                      dish: dish,
                      onTap: () => _openDetail(context, dish),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- TARJETA DE CADA PLATO ----------
class DishCard extends StatelessWidget {
  final Dish dish;
  final VoidCallback onTap;

  const DishCard({super.key, required this.dish, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias, // Recorta la foto con las esquinas redondeadas
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto del plato (Hero: se anima hacia la pantalla de detalle)
            Hero(
              tag: 'dish-${dish.id}', // tag único por plato
              child: Image.network(
                dish.imageUrl,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                // Mientras carga la imagen
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: double.infinity,
                    height: 180,
                    color: const Color(0xFFD8E9DF),
                    child: const Center(
                      child: Icon(Icons.image, color: Color(0xFF2D6A4F)),
                    ),
                  );
                },
                // Si la imagen falla
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 180,
                  color: const Color(0xFFD8E9DF),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.leaf,
                      size: 48,
                      color: Color(0xFF2D6A4F),
                    ),
                  ),
                ),
              ),
            ),

            // Texto del plato
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B4332),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(dish.description),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.leaf,
                        size: 16,
                        color: Color(0xFF2D6A4F),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Vegano · ${dish.price.toStringAsFixed(2)} €',
                        style: const TextStyle(
                          fontSize: 16,
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