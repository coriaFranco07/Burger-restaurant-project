import 'package:http/http.dart' as http;
import 'package:mi_aplicacion/models/dish.dart';
import 'dart:convert';
import 'package:mi_aplicacion/models/estado.dart';
import 'package:mi_aplicacion/models/pedido.dart';
import 'package:mi_aplicacion/models/pedido_detalle.dart';

class ApiPedidoDetalle {
  final String baseUrl = 'http://192.168.245.21:8000/api/';

  Future<List<PedidoDetalle>> fetchPedidoDetalle() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}pedido_detalle/'));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as List<dynamic>;
        final List<Future<PedidoDetalle>> pedidoFutures = jsonResponse.map((pedidoJson) => PedidoDetalle.fromJsonAsync(pedidoJson)).toList();
        return Future.wait(pedidoFutures);
      } else {
        print('Error en fetchPedidoDetalle: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load PedidoDetalle.');
      }
    } catch (e) {
      print('Excepción en fetchPedidoDetalle: $e');
      throw Exception('Failed to load PedidoDetalle.');
    }
  }




 Future<List<PedidoDetalle>> fetchPedidoDetallesByPedidos(List<int> pedidosIds) async {
    try {
      final List<Future<http.Response>> responsesFutures = pedidosIds.map((id) {
        return http.get(Uri.parse('${baseUrl}pedido_detalle/?id_pedido=$id'));
      }).toList();

      final List<http.Response> responses = await Future.wait(responsesFutures);

      for (var response in responses) {
        if (response.statusCode != 200) {
          print('Error en fetchPedidoDetallesByPedidos: ${response.statusCode} - ${response.body}');
          throw Exception('Failed to load PedidoDetalle.');
        }
      }

      List<PedidoDetalle> allDetalles = [];
      for (var response in responses) {
        final jsonResponse = jsonDecode(response.body);
        print('Respuesta JSON: $jsonResponse'); // Para depuración

        if (jsonResponse is List) {
          final List<PedidoDetalle> detalles = jsonResponse.map((detalleJson) {
            try {
              if (detalleJson is Map<String, dynamic>) {
                return PedidoDetalle.fromJson(detalleJson);
              } else {
                print('Error en fetchPedidoDetallesByPedidos: Elemento no es un Map<String, dynamic>');
                throw Exception('Failed to load PedidoDetalle.');
              }
            } catch (e) {
              print('Excepción en fetchPedidoDetallesByPedidos - mapping: $e');
              throw Exception('Failed to load PedidoDetalle.');
            }
          }).toList();
          allDetalles.addAll(detalles);
        } else {
          print('Error en fetchPedidoDetallesByPedidos: Respuesta no es una lista');
          throw Exception('Failed to load PedidoDetalle.');
        }
      }

      return allDetalles;
    } catch (e) {
      print('Excepción en fetchPedidoDetallesByPedidos: $e');
      throw Exception('Failed to load PedidoDetalle.');
    }
  }


  Future<PedidoDetalle> createPedidoDetalle(Pedido id_pedido, Dish id_comida, int cantidad_comida, double total, Estado id_estado) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}pedido_detalle/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id_pedido': id_pedido.id_pedido,
          'id_comida': id_comida.id_comida,
          'cantidad_comida': cantidad_comida,
          'total': total,
          'id_estado': id_estado.id_estado,
        }),
      );

      if (response.statusCode == 201) {
        return PedidoDetalle.fromJson(jsonDecode(response.body));
      } else {
        print('Error en createPedidoDetalle: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to create PedidoDetalle.');
      }
    } catch (e) {
      print('Excepción en createPedidoDetalle: $e');
      throw Exception('Failed to create PedidoDetalle.');
    }
  }

  Future<PedidoDetalle> updatePedidoDetalle(int id_pedido_detalle, Pedido id_pedido, Dish id_comida, int cantidad_comida, double total, Estado id_estado) async {
    try {
      final response = await http.put(
        Uri.parse('${baseUrl}pedido_detalle/$id_pedido_detalle/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id_pedido_detalle': id_pedido_detalle,
          'id_pedido': id_pedido.id_pedido,
          'id_comida': id_comida.id_comida,
          'cantidad_comida': cantidad_comida,
          'total': total,
          'id_estado': id_estado.id_estado,
        }),
      );

      if (response.statusCode == 200) {
        return PedidoDetalle.fromJson(jsonDecode(response.body));
      } else {
        print('Error en updatePedidoDetalle: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to update PedidoDetalle.');
      }
    } catch (e) {
      print('Excepción en updatePedidoDetalle: $e');
      throw Exception('Failed to update PedidoDetalle.');
    }
  }

  Future<void> deletePedidoDetalle(int id_pedido_detalle) async {
    try {
      final response = await http.delete(
        Uri.parse('${baseUrl}pedido_detalle/$id_pedido_detalle/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 204) {
        print('Error en deletePedidoDetalle: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to delete PedidoDetalle.');
      }
    } catch (e) {
      print('Excepción en deletePedidoDetalle: $e');
      throw Exception('Failed to delete PedidoDetalle.');
    }
  }

  Future<PedidoDetalle> obtenerPedidoDetalle(int id_pedido_detalle) async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}pedido_detalle/$id_pedido_detalle/'));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return PedidoDetalle.fromJson(jsonResponse);
      } else {
        print('Error en obtenerPedidoDetalle: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load PedidoDetalle.');
      }
    } catch (e) {
      print('Excepción en obtenerPedidoDetalle: $e');
      throw Exception('Failed to load PedidoDetalle.');
    }
  }
}
