import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mi_aplicacion/models/dish.dart';
import 'package:mi_aplicacion/models/estado.dart';
import 'package:mi_aplicacion/models/like.dart';
import 'package:mi_aplicacion/models/usuario.dart';

class ApiLike {
  final String baseUrl = 'http://192.168.245.21:8000/api/';

  Future<List<Like>> fetchLike() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}like/'));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as List<dynamic>;
        final List<Future<Like>> likeFutures = jsonResponse.map((likeJson) => Like.fromJsonAsync(likeJson)).toList();
        return Future.wait(likeFutures);
      } else {
        print('Error en fetchLike: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load Like.');
      }
    } catch (e) {
      print('Excepción en fetchLike: $e');
      throw Exception('Failed to load Like.');
    }
  }

  Future<Like> createLike(Cliente id_cliente, Dish id_comida, Estado id_estado) async {
    final response = await http.post(
      Uri.parse('${baseUrl}like/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_cliente': id_cliente,
        'id_comida': id_comida,
        'id_estado': id_estado.toJson(),
      }),
    );

    if (response.statusCode == 201) {
      return Like.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create comida.');
    }
  }

  Future<Like> updateLik(int id_like, Cliente id_cliente, Dish id_comida, Estado id_estado) async {
    final response = await http.put(
      Uri.parse('${baseUrl}like/$id_like/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_like': id_like,
        'id_cliente': id_cliente,
        'id_comida': id_comida,
        'id_estado': id_estado.toJson(),
      }),
    );

    if (response.statusCode == 200) {
      return Like.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update comida.');
    }
  }

  Future<void> deleteLik(int id_like) async {
    final response = await http.delete(
      Uri.parse('${baseUrl}like/$id_like/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete comida.');
    }
  }

  Future<Like> obtenerLike(int id_like) async {
    try {
      final response = await http.get( Uri.parse('${baseUrl}like/$id_like/'));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return Like.fromJson(jsonResponse);
      } else {
        print('Error en obtenerLike: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load Like.');
      }
    } catch (e) {
      print('Excepción en obtenerLike: $e');
      throw Exception('Failed to load Like.');
    }
  }
   
}


