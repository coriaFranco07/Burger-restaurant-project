import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mi_aplicacion/apis/comida/dish.dart';
import 'package:mi_aplicacion/apis/estado/estado.dart';
import 'package:mi_aplicacion/apis/pedido/pedido.dart';
import 'package:mi_aplicacion/models/dish.dart';
import 'package:mi_aplicacion/models/estado.dart';
import 'package:mi_aplicacion/models/pedido.dart';

class PedidoDetalle {
  int id_pedido_detalle;
  Pedido? id_pedido;
  Dish? id_comida;
  int cantidad_comida;
  double total;
  Estado? id_estado;
  DateTime created_at;

  PedidoDetalle({
    required this.id_pedido_detalle,
    this.id_pedido,
    this.id_comida,
    required this.cantidad_comida,
    required this.total,
    this.id_estado,
    required this.created_at,
  });

factory PedidoDetalle.fromJson(Map<String, dynamic> json) {
  try {
    return PedidoDetalle(
      id_pedido_detalle: json['id_pedido_detalle'],
      id_pedido: json['id_pedido'] != null ? Pedido.fromJson(json['id_pedido']) : null,
      id_comida: json['id_comida'] != null ? Dish.fromJson(json['id_comida']) : null,
      cantidad_comida: json['cantidad_comida'] ?? 0,
      total: json['total'] is String ? double.parse(json['total']) : (json['total'] ?? 0.0),
      id_estado: json['id_estado'] != null ? Estado.fromJson(json['id_estado']) : null,
      created_at: DateTime.parse(json['created_at'] ?? ''),
    );
  } catch (e) {
    print('Error en PedidoDetalle.fromJson: $e');
    throw Exception('Failed to parse PedidoDetalle.');
  }
}

  static Future<PedidoDetalle> fromJsonAsync(Map<String, dynamic> json) async {
    final int idPedidoDetalle = json['id_pedido_detalle'];
    final int idPedido = json['id_pedido'];
    final int idComida = json['id_comida'];
    final int cantidadComida = json['cantidad_comida'];
    final double total = json['total'];
    final int idEstado = json['id_estado'];
    final DateTime createdAt = DateTime.parse(json['created_at']);

    final Pedido pedido = await ApiPedido().obtenerPedido(idPedido);
    final Dish comida = await ApiComida().obtenerComida(idComida);
    final Estado estado = await ApiEstados().obtenerEstado(idEstado);

    return PedidoDetalle(
      id_pedido_detalle: idPedidoDetalle,
      id_pedido: pedido,
      id_comida: comida,
      cantidad_comida: cantidadComida,
      total: total,
      id_estado: estado,
      created_at: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pedido_detalle': id_pedido_detalle,
      'id_pedido': id_pedido?.toJson(),
      'id_comida': id_comida?.toJson(),
      'cantidad_comida': cantidad_comida,
      'total': total,
      'id_estado': id_estado?.toJson(),
      'created_at': created_at.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'PedidoDetalle $id_pedido_detalle - Pedido: ${id_pedido?.id_pedido} - Comida: ${id_comida?.name} - Cant: $cantidad_comida - Total: $total';
  }
}
