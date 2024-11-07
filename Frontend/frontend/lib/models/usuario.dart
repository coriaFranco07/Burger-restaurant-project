import 'package:mi_aplicacion/apis/estado/estado.dart';
import 'package:mi_aplicacion/models/estado.dart';

class Cliente {
  int id_cliente;
  String nombre_completo;
  String usuario;
  String num_tel;
  Estado? id_estado; // Relación con Estado (puede ser nulo)
  String contrasena; // Contraseña del cliente
  DateTime created_at;

  Cliente({
    required this.id_cliente,
    required this.nombre_completo,
    required this.usuario,
    required this.num_tel,
    this.id_estado, // Puede ser nulo
    required this.contrasena,
    required this.created_at,
  });

  // Método para crear una instancia de Cliente desde un mapa (JSON)
 factory Cliente.fromJson(Map<String, dynamic> json) {
  return Cliente(
    id_cliente: json['id_cliente'],
    nombre_completo: json['nombre_completo'] ?? '',
    usuario: json['usuario'] ?? '',
    contrasena: json['contrasena'] ?? '',
    num_tel: json['num_tel'] ?? '',
    id_estado: json['id_estado'],
    created_at: DateTime.parse(json['created_at'] ?? ''), 
  );
}

  // Método para convertir Cliente a un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id_cliente': id_cliente,
      'nombre_completo': nombre_completo,
      'usuario': usuario,
      'num_tel': num_tel,
      'id_estado': id_estado?.toJson(),
      'contrasena': contrasena,
      'created_at': created_at.toIso8601String(),
    };
  }
}
