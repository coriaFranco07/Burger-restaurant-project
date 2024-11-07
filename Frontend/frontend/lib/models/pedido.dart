import 'package:mi_aplicacion/apis/estado/estado.dart';
import 'package:mi_aplicacion/apis/usuario/usuario.dart';
import 'package:mi_aplicacion/models/estado.dart';
import 'package:mi_aplicacion/models/usuario.dart';

class Pedido {
  int id_pedido;
  Cliente? id_cliente;
  Estado? id_estado;
  DateTime created_at;

  Pedido({
    required this.id_pedido,
    this.id_cliente,
    this.id_estado,
    required this.created_at,
  });

  // Método para crear una instancia de Pedido desde un mapa (JSON)
  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id_pedido: json['id_pedido'],
      id_cliente: json['id_cliente'] != null ? Cliente.fromJson(json['id_cliente']) : null,
      id_estado: json['id_estado'] != null ? Estado.fromJson(json['id_estado']) : null,
      created_at: DateTime.parse(json['created_at']),
    );
  }

  static Future<Pedido> fromJsonAsync(Map<String, dynamic> json) async {
    final int idCliente = json['id_cliente'] ?? 0;
    final Cliente cliente = await ApiCliente().obtenerCliente(idCliente);

    final int idEstado = json['id_estado'] ?? 0;
    final Estado estado = await ApiEstados().obtenerEstado(idEstado);

    return Pedido(
      id_pedido: json['id_pedido'],
      id_cliente: cliente,
      id_estado: estado,
      created_at: DateTime.parse(json['created_at']),
    );
  }

  // Método para convertir Pedido a un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id_pedido': id_pedido,
      'id_cliente': id_cliente?.toJson(),
      'id_estado': id_estado?.toJson(),
      'created_at': created_at.toIso8601String(),
    };
  }
}
