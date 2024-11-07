
import 'package:mi_aplicacion/apis/estado/estado.dart';
import 'package:mi_aplicacion/models/estado.dart';

class Dish {
  int id_comida;
  String name;
  String store;
  String image;
  int proximity;
  double price;
  double starts;
  int stock;
  Estado? id_estado;
  DateTime created_at;
  int quantity;

  Dish({
    required this.id_comida,
    required this.name,
    required this.store,
    required this.image,
    required this.proximity,
    required this.price,
    required this.starts,
    required this.stock,
    required this.id_estado,
    required this.created_at,
    this.quantity = 1,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id_comida: json['id_comida'],
      name: json['name'] ?? '',
      store: json['store'] ?? '',
      image: json['image'] ?? '',
      proximity: json['proximity'] ?? 0,
      price: json['price'] is String ? double.parse(json['price']) : (json['price'] ?? 0.0),
      starts: json['starts'] is int ? (json['starts'] as int).toDouble() : (json['starts'] ?? 0.0),
      stock: json['stock'] ?? 0,
      id_estado: null,
      created_at: DateTime.parse(json['created_at'] ?? ''),
    );
  }

  static Future<Dish> fromJsonAsync(Map<String, dynamic> json) async {
    final int idEstado = json['id_estado'] ?? 0;
    final Estado estado = await ApiEstados().obtenerEstado(idEstado);

    return Dish(
      id_comida: json['id_comida'],
      name: json['name'] ?? '',
      store: json['store'] ?? '',
      image: json['image'] ?? '',
      proximity: json['proximity'] ?? 0,
      price: json['price'] is String ? double.parse(json['price']) : (json['price'] ?? 0.0),
      starts: json['starts'] is int ? (json['starts'] as int).toDouble() : (json['starts'] ?? 0.0),
      stock: json['stock'] ?? 0,
      id_estado: estado,
      created_at: DateTime.parse(json['created_at'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_comida': id_comida,
      'name': name,
      'store': store,
      'image': image,
      'proximity': proximity,
      'price': price,
      'starts': starts,
      'stock': stock,
      'id_estado': id_estado?.id_estado,
      'created_at': created_at.toIso8601String(),
    };
  }

  isValid() {}
}


/* List<Dish> dishes() {
  Estado estado1 = Estado(id_estado: 1, tipo: 'Activo', created_at: DateTime.now());
  return [
    Dish(
      id_comida: 1,
      name: "Fried Chiness",
      store: "Chiness Su'Cafe",
      image: "hamburg.jpeg",
      proximity: 38, // Entero
      price: 7500, // Entero
      starts: 4.6, // Double
      stock: 10,
      id_estado: estado1,
      created_at: DateTime.now(),
    ),
    Dish(
      id_comida: 2,
      name: "Fried Rice",
      store: "Chiness Su'Cafe",
      image: "hamburg1.jpg",
      proximity: 38, // Entero
      price: 4500, // Entero
      starts: 4.6, // Double
      stock: 10,
      id_estado: estado1,
      created_at: DateTime.now(),
    ),
    Dish(
      id_comida: 3,
      name: "Chiness Rice",
      store: "Chiness Su'Cafe",
      image: "hamburg2.jpg",
      proximity: 38, // Entero
      price: 8000, // Entero
      starts: 4.6, // Double
      stock: 10,
      id_estado: estado1,
      created_at: DateTime.now(),
    ),
    Dish(
      id_comida: 4,
      name: "Fried Rice",
      store: "Chiness Su'Cafe",
      image: "hamburg.jpeg",
      proximity: 38, // Entero
      price: 7500, // Entero
      starts: 4.6, // Double
      stock: 10,
      id_estado: estado1,
      created_at: DateTime.now(),
    ),
  ];
} */

