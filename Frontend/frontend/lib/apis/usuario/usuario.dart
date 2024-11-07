import 'package:http/http.dart' as http;
import 'package:mi_aplicacion/apis/estado/estado.dart';
import 'dart:convert';
import 'package:mi_aplicacion/models/estado.dart';
import 'package:mi_aplicacion/models/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiCliente {
  final String baseUrl = 'http://192.168.245.21:8000/api';

  Future<Cliente> fetchCliente() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? clienteId = prefs.getInt('id_cliente');

    if (clienteId == null) {
      throw Exception('Cliente ID no encontrado en SharedPreferences');
    }

    final response = await http.get(Uri.parse('$baseUrl/cliente/$clienteId/'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print('Respuesta de la API: $jsonResponse');

      if (jsonResponse is Map<String, dynamic>) {
        // Suponiendo que `id_estado` necesita ser convertido a un objeto Estado
        final Estado estado = await ApiEstados().obtenerEstado(jsonResponse['id_estado']);
        jsonResponse['id_estado'] = estado;

        return Cliente.fromJson(jsonResponse);
      } else {
        throw Exception('La respuesta de la API no es un mapa válido');
      }
    } else {
      print('Error en fetchCliente: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to load Cliente.');
    }
  } catch (e) {
    print('Excepción en fetchCliente: $e');
    throw Exception('Failed to load Cliente.');
  }
}

  Future<Cliente> createCliente(String nombre_completo, String usuario, String num_tel, String contrasena, Estado id_estado) async {
    final response = await http.post(
      Uri.parse('${baseUrl}cliente/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nombre_completo': nombre_completo,
        'usuario': usuario,
        'num_tel': num_tel,
        'id_estado': id_estado.toJson(),
        'contraseña': contrasena,
      }),
    );

    if (response.statusCode == 201) {
      return Cliente.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Cliente.');
    }
  }

  Future<Cliente> updateCliente(int id_cliente, String nombre_completo, String usuario, String num_tel, String contrasena, Estado id_estado) async {
    final response = await http.put(
      Uri.parse('${baseUrl}cliente/$id_cliente/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_cliente': id_cliente,
        'nombre_completo': nombre_completo,
        'usuario': usuario,
        'num_tel': num_tel,
        'id_estado': id_estado.toJson(),
        'contraseña': contrasena,
      }),
    );

    if (response.statusCode == 200) {
      return Cliente.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update Cliente.');
    }
  }

  Future<void> deleteCliente(int id_cliente) async {
    final response = await http.delete(
      Uri.parse('${baseUrl}cliente/$id_cliente/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete Cliente.');
    }
  }

  Future<Cliente> obtenerCliente(int idCliente) async {
    final response = await http.get(Uri.parse('${baseUrl}/cliente/$idCliente/'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return Cliente.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load cliente.');
    }
  }
}
