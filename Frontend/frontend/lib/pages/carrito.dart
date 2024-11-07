import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_aplicacion/apis/usuario/usuario.dart';
import 'package:mi_aplicacion/models/dish.dart';
import 'package:mi_aplicacion/models/usuario.dart';
import 'package:mi_aplicacion/sections/store/historial_compras.dart';
import 'package:mi_aplicacion/sections/store/pedido_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Carrito extends StatefulWidget {
  final List<Dish> carrito;

  const Carrito({Key? key, required this.carrito}) : super(key: key);

  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> with SingleTickerProviderStateMixin {
  Future<Cliente>? _clienteFuture;
  int? _clienteId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadCliente();
  }

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

  late TabController _tabController;
  int selectedQuantity = 1;
  final List<int> quantities = List<int>.generate(20, (i) => i + 1);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Mi Carrito',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          backgroundColor: Colors.deepPurple.shade800 // Color de fondo personalizado
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]?.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(25.8),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: Color.fromARGB(255, 167, 161, 161).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      controller: _tabController,
                      tabs: [
                        Tab(
                          child: Text(
                            'En curso',
                            style: GoogleFonts.satisfy(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
/*                         Tab(
                          child: Text(
                            'Finalizados',
                            style: GoogleFonts.satisfy(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ), */
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _clienteId != null
                      ? MiPedidoContent(carrito: widget.carrito, idCliente: _clienteId!)
                      : Center(child: CircularProgressIndicator()),
                  //HistorialLikeContent(idCliente: _clienteId!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
