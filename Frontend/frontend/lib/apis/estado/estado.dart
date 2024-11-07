import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mi_aplicacion/models/estado.dart';

class ApiEstados {
  
  final String baseUrl = 'http://192.168.245.21:8000/api/estado/';

  Future<List<Estado>> fetchEstados() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((estado) => Estado.fromJson(estado)).toList();
    } else {
      throw Exception('Failed to load estados.');
    }
  }

  Future<Estado> createEstado(String tipo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'tipo': tipo,
      }),
    );

    if (response.statusCode == 201) {
      return Estado.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create estado.');
    }
  }

  Future<Estado> updateEstado(int id_estado, String tipo) async {
    final response = await http.put(
      Uri.parse('$baseUrl$id_estado/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id_estado,
        'tipo': tipo,
      }),
    );

    if (response.statusCode == 200) {
      return Estado.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update estado.');
    }
  }

  Future<void> deleteEstado(int id_estado) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$id_estado/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete estado.');
    }
  }

  Future<Estado> obtenerEstado(int id_estado) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$id_estado/'));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return Estado.fromJson(jsonResponse);
      } else {
        print('Error en obtenerEstado: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load estado.');
      }
    } catch (e) {
      print('Excepción en obtenerEstado: $e');
      throw Exception('Failed to load estado.');
    }
  }
}
