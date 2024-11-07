import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mi_aplicacion/apis/usuario/usuario.dart'; // Asegúrate de que la ruta sea correcta
import 'package:mi_aplicacion/models/usuario.dart';

class ChangePasswordPage extends StatefulWidget {
  final int clienteId;

  ChangePasswordPage({required this.clienteId});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  Future<Cliente>? _clienteFuture;

  @override
  void initState() {
    super.initState();
    _loadCliente();
  }

  // Método para cargar el cliente
  Future<void> _loadCliente() async {
    _clienteFuture = ApiCliente().obtenerCliente(widget.clienteId);
    setState(() {});
  }

  void _saveNewPassword() async {
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    final response = await http.patch(
      Uri.parse('http://192.168.245.21:8000/api/cliente/${widget.clienteId}/change_password/'), // Endpoint para actualizar la contraseña del cliente por ID
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'password': newPassword}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contraseña actualizada con éxito')),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar la contraseña: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Cliente>(
          future: _clienteFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Cargando...');
            } else if (snapshot.hasError) {
              return Text('Cambiar mi contraseña');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Text('Cliente no encontrado');
            } else {
              return Text('Cambiar Contraseña: ${snapshot.data!.usuario}');
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Nueva Contraseña'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirmar Contraseña'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNewPassword,
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
