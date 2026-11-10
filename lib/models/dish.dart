// ---------- MODELO DE DATOS ----------

// Contenedor de la carta: encapsula la lista de platos del .json
class Menu {
  final List<Dish> dishes;

  Menu({required this.dishes});

  // Crea la carta a partir del Map obtenido al decodificar el .json
  factory Menu.fromJson(Map<String, dynamic> json) {
    final list = json['dishes'] as List<dynamic>;
    return Menu(
      dishes: list.map((d) => Dish.fromJson(d as Map<String, dynamic>)).toList(),
    );
  }
}

// Un plato de la carta
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

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
}
