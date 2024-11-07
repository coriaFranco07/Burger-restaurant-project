import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mi_aplicacion/models/estado.dart';
import 'package:mi_aplicacion/models/pedido.dart';
import 'package:mi_aplicacion/models/usuario.dart';

class ApiPedido {
  final String baseUrl = 'http://192.168.245.21:8000/api/';

  Future<List<Pedido>> fetchPedido() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}pedido/'));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as List<dynamic>;
        final List<Future<Pedido>> pedidoFutures = jsonResponse.map((pedidoJson) => Pedido.fromJsonAsync(pedidoJson)).toList();
        return Future.wait(pedidoFutures);
      } else {
        print('Error en fetchPedido: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load Pedido.');
      }
    } catch (e) {
      print('Excepción en fetchPedido: $e');
      throw Exception('Failed to load Pedido.');
    }
  }

  Future<List<int>> fetchPedidosByUser(int idCliente) async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}pedido/?id_cliente=$idCliente'));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as List<dynamic>;
        final List<int> pedidos = jsonResponse.map((pedidoJson) => pedidoJson['id_pedido'] as int).toList();
        return pedidos;
      } else {
        print('Error en fetchPedidosByUser: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load pedidos.');
      }
    } catch (e) {
      print('Excepción en fetchPedidosByUser: $e');
      throw Exception('Failed to load pedidos.');
    }
  }

  Future<Pedido> createPedido(Cliente id_cliente, Estado id_estado) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}pedido/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id_cliente': id_cliente.id_cliente,
          'id_estado': id_estado.id_estado,
        }),
      );

      if (response.statusCode == 201) {
        return Pedido.fromJson(jsonDecode(response.body));
      } else {
        print('Error en createPedido: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to create Pedido.');
      }
    } catch (e) {
      print('Excepción en createPedido: $e');
      throw Exception('Failed to create Pedido.');
    }
  }

  Future<Pedido> updatePedido(int id_pedido, Cliente id_cliente, Estado id_estado) async {
    try {
      final response = await http.put(
        Uri.parse('${baseUrl}pedido/$id_pedido/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id_cliente': id_cliente.id_cliente,
          'id_estado': id_estado.id_estado,
        }),
      );

      if (response.statusCode == 200) {
        return Pedido.fromJson(jsonDecode(response.body));
      } else {
        print('Error en updatePedido: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to update Pedido.');
      }
    } catch (e) {
      print('Excepción en updatePedido: $e');
      throw Exception('Failed to update Pedido.');
    }
  }

  Future<void> deletePedido(int id_pedido) async {
    try {
      final response = await http.delete(
        Uri.parse('${baseUrl}pedido/$id_pedido/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 204) {
        print('Error en deletePedido: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to delete Pedido.');
      }
    } catch (e) {
      print('Excepción en deletePedido: $e');
      throw Exception('Failed to delete Pedido.');
    }
  }

  Future<Pedido> obtenerPedido(int id_pedido) async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}pedido/$id_pedido/'));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return Pedido.fromJson(jsonResponse);
      } else {
        print('Error en obtenerPedido: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load Pedido.');
      }
    } catch (e) {
      print('Excepción en obtenerPedido: $e');
      throw Exception('Failed to load Pedido.');
    }
  }
}
