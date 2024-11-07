import 'package:mi_aplicacion/apis/comida/dish.dart';
import 'package:mi_aplicacion/apis/estado/estado.dart';
import 'package:mi_aplicacion/apis/usuario/usuario.dart';
import 'package:mi_aplicacion/models/dish.dart';
import 'package:mi_aplicacion/models/usuario.dart';
import 'estado.dart'; // Importa el modelo Estado


class Like {
  int id_like;
  Cliente? id_cliente; // Relación con Cliente (puede ser nulo)
  Dish? id_comida; // Relación con Comida (puede ser nulo)
  Estado? id_estado; // Relación con Estado (puede ser nulo)
  DateTime created_at;

  Like({
    required this.id_like,
    this.id_cliente,
    this.id_comida,
    this.id_estado,
    required this.created_at,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id_like: json['id_like'],
      id_cliente: json['id_cliente'],
      id_comida: json['id_comida'],
      id_estado: null,
      created_at: DateTime.parse(json['created_at'] ?? ''),
    );
  }

  static Future<Like> fromJsonAsync(Map<String, dynamic> json) async {
    final int idCliente = json['id_cliente'] ?? 0; // Supongamos que el valor por defecto es 0 si es null
    final Cliente cliente = await ApiCliente().obtenerCliente(idCliente);

    final int idComida = json['id_comida'] ?? 0; // Supongamos que el valor por defecto es 0 si es null
    final Dish comida = await ApiComida().obtenerComida(idComida);

    final int idEstado = json['id_estado'] ?? 0; // Supongamos que el valor por defecto es 0 si es null
    final Estado estado = await ApiEstados().obtenerEstado(idEstado);

    return Like(
      id_like: json['id_like'],
      id_cliente: cliente,
      id_comida: comida,
      id_estado: estado,
      created_at: DateTime.parse(json['created_at'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_like': id_like,
      'id_cliente': id_cliente?.id_cliente,
      'id_comida': id_comida?.id_comida,
      'id_estado': id_estado?.id_estado,
      'created_at': created_at.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Like $id_like - Usuario: ${id_cliente?.nombre_completo} - Comida: ${id_comida?.name}';
  }
}