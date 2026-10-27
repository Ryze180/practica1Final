import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ---------- MODELO DE DATOS ----------
class Dish {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

// Carta del restaurante: platos veganos sencillos
final List<Dish> menu = [
  Dish(
    id: 1,
    name: 'Hummus con pan de pita',
    description: 'Crema de garbanzos con tahini, limón y aceite de oliva.',
    price: 5.50,
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6ZOM9PBKVAd3jpw9-1oLyykNS44nQH1shsC1a3vRCEoA6yf3IV0gwvqY&s=10',
  ),
  Dish(
    id: 2,
    name: 'Ensalada de garbanzos',
    description: 'Garbanzos, tomate, pepino y cebolla morada con limón.',
    price: 6.50,
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgFb08BO76voeUdaex97ZCsoRKkgBiO2ANU1haKEaBmXF6FYGh-YxaRXk&s=10',
  ),
  Dish(
    id: 3,
    name: 'Crema de calabaza',
    description: 'Crema suave de calabaza y zanahoria con aceite de oliva.',
    price: 5.00,
    imageUrl: 'https://static.bainet.es/clip/8f39485e-d395-43dc-897c-6bfd73daa501_source-aspect-ratio_1600w_0.jpg',
  ),
  Dish(
    id: 4,
    name: 'Falafel con tahini',
    description: 'Croquetas de garbanzo crujientes con salsa de sésamo.',
    price: 6.00,
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-act30f4NA3ZuBIRs5oEx22I-pQRxTh9JZe-8gamss6ji4VdUFM3WGXo&s=10',
  ),
  Dish(
    id: 5,
    name: 'Tostada de aguacate',
    description: 'Pan tostado con aguacate, tomate y un toque de limón.',
    price: 4.50,
    imageUrl: 'https://content.cuerpomente.com/medio/2021/09/30/tostada-aguacate-hummus-rabanitos_209d7b5f_1200x1200.jpg',
  ),
  Dish(
    id: 6,
    name: 'Arroz con verduras',
    description: 'Arroz salteado con pimiento, calabacín y zanahoria.',
    price: 7.00,
    imageUrl: 'https://assets.tmecosys.com/image/upload/t_web_rdp_recipe_584x480_1_5x/img/recipe/ras/Assets/e3dde35b7bc4aadea5806424ded7107c/Derivates/4cbd810c3cc16917169916c1debd24e90548e38d.jpg',
  ),
];

// ---------- PANTALLA DE LA LISTA ----------
class RoutesView extends StatelessWidget {
  const RoutesView({super.key});

  // Muestra el mensaje al tocar un plato
  void _showMessage(BuildContext context, Dish dish) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('El detalle de "${dish.name}" se implementará en la Fase 3'),
        backgroundColor: const Color(0xFF2D6A4F),
      ),
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
      // Lista perezosa: solo construye los platos que se ven en pantalla
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: menu.length,
        itemBuilder: (context, index) {
          final dish = menu[index];
          return DishCard(
            dish: dish,
            onTap: () => _showMessage(context, dish),
          );
        },
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
            // Foto del plato
            Image.network(
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