import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mi_aplicacion/models/dish.dart';
import 'package:mi_aplicacion/models/estado.dart';

class ApiComida {
  final String baseUrl = 'http://192.168.245.21:8000/api/comida/';

  Future<List<Dish>> fetchComida() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as List<dynamic>;
        final List<Future<Dish>> dishFutures = jsonResponse.map((dishJson) => Dish.fromJsonAsync(dishJson)).toList();
        print(dishFutures);
        return Future.wait(dishFutures);
      } else {
        print('Error en fetchComida: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load comida.');
      }
    } catch (e) {
      print('Excepción en fetchComida: $e');
      throw Exception('Failed to load comida.');
    }
  }

  Future<Dish> createComida(String name, String store, String image, int proximity, double price, double starts, int stock, Estado id_estado) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'store': store,
          'image': image,
          'proximity': proximity,
          'price': price,
          'starts': starts,
          'stock': stock,
          'id_estado': id_estado.toJson(),
        }),
      );

      if (response.statusCode == 201) {
        return Dish.fromJson(jsonDecode(response.body));
      } else {
        print('Error en createComida: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to create comida.');
      }
    } catch (e) {
      print('Excepción en createComida: $e');
      throw Exception('Failed to create comida.');
    }
  }

  Future<Dish> updateComida(int id_comida, String name, String store, String image, int proximity, double price, double starts, int stock, Estado id_estado) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$id_comida/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id_comida': id_comida,
          'name': name,
          'store': store,
          'image': image,
          'proximity': proximity,
          'price': price,
          'starts': starts,
          'stock': stock,
          'id_estado': id_estado.toJson(),
        }),
      );

      if (response.statusCode == 200) {
        return Dish.fromJson(jsonDecode(response.body));
      } else {
        print('Error en updateComida: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to update comida.');
      }
    } catch (e) {
      print('Excepción en updateComida: $e');
      throw Exception('Failed to update comida.');
    }
  }

  Future<void> deleteComida(int id_comida) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$id_comida/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 204) {
        print('Error en deleteComida: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to delete comida.');
      }
    } catch (e) {
      print('Excepción en deleteComida: $e');
      throw Exception('Failed to delete comida.');
    }
  }

  Future<Dish> obtenerComida(int id_comida) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$id_comida/'));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return Dish.fromJson(jsonResponse);
      } else {
        print('Error en obtenerComida: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load comida.');
      }
    } catch (e) {
      print('Excepción en obtenerComida: $e');
      throw Exception('Failed to load comida.');
    }
  }
}
