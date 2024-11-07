import 'package:flutter/material.dart';
import 'package:mi_aplicacion/pages/contraseña.dart';
import 'package:mi_aplicacion/pages/hist_like.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_aplicacion/apis/usuario/usuario.dart';
import 'package:mi_aplicacion/models/usuario.dart';

class DatosPersona extends StatefulWidget {
  @override
  _DatosPersonaState createState() => _DatosPersonaState();
}

class _DatosPersonaState extends State<DatosPersona> {
  Future<Cliente>? _clienteFuture;
  int? _clienteId;

  @override
  void initState() {
    super.initState();
    _loadCliente();
  }

  // Método para cargar el cliente desde SharedPreferences al inicio
  Future<void> _loadCliente() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? clienteId = prefs.getInt('id_cliente');
    if (clienteId != null) {
      setState(() {
        _clienteId = clienteId;
        _clienteFuture = ApiCliente().fetchCliente();
      });
    } else {
      print('No se encontró clienteId en SharedPreferences');
    }
  }

  // Método para cambiar la contraseña
  void _changePassword() {
    if (_clienteId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangePasswordPage(clienteId: _clienteId!),
        ),
      );
    } else {
      print('Cliente ID no encontrado');
    }
  }

  void _histLike() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistorialLike(
          dishes: [],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Datos Personales',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.redAccent),
            onPressed: _histLike,
          ),
          IconButton(
            icon: Icon(Icons.lock, color: Colors.white),
            onPressed: _changePassword,
          ),
        ],
      ),
      body: FutureBuilder<Cliente>(
        future: _clienteFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar datos: ${snapshot.error}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text(
                'No se encontraron datos',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            );
          } else {
            final cliente = snapshot.data!;
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                Card(
                  elevation: 8,
                  shadowColor: Colors.teal.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mi Usuario: ${cliente.usuario}',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        Divider(color: Colors.grey.shade300),
                        SizedBox(height: 10),
                        _buildInfoRow('Mi Nombre:', cliente.nombre_completo),
                        _buildInfoRow('Mi Teléfono:', cliente.num_tel),
                        _buildInfoRow(
                            'Mi Estado:', cliente.id_estado?.tipo ?? 'N/A'),
                        _buildInfoRow('Fecha de Registro:',
                            cliente.created_at.toString()),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
