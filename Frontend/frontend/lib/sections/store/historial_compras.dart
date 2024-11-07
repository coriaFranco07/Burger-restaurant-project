import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_aplicacion/apis/pedido_detalle/pedido_detalle.dart';
import 'package:mi_aplicacion/apis/pedido/pedido.dart'; // Importa tu API de pedidos
import 'package:mi_aplicacion/models/pedido_detalle.dart'; // Importa tu modelo de detalles de pedido (si existe)

class HistorialLikeContent extends StatelessWidget {
  final int idCliente;

  HistorialLikeContent({required this.idCliente});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: ApiPedido().fetchPedidosByUser(idCliente),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error al cargar los pedidos'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay pedidos disponibles'));
        }

        List<int> pedidosIds = snapshot.data!;

        return FutureBuilder<List<PedidoDetalle>>(
          future: ApiPedidoDetalle().fetchPedidoDetallesByPedidos(pedidosIds),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error al cargar los detalles de los pedidos'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No hay detalles de pedidos disponibles'));
            }

            List<PedidoDetalle> detallesList = snapshot.data!;

            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: detallesList.map((detalle) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage("assets/images/${detalle.id_comida?.id_comida}.jpg"), // Ajusta esto según los datos disponibles
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Comida ID: ${detalle.id_comida?.id_comida}', // Ajusta esto según los datos que tengas disponibles
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 2.0,
                                          color: Colors.black54,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Cantidad: ${detalle.cantidad_comida}',
                                    style: GoogleFonts.inter(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 2.0,
                                          color: Colors.black54,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      SizedBox(width: 4),
                                      Text(
                                        "\$${detalle.total}",
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 2.0,
                                              color: Colors.black54,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Text(
                                detalle.created_at.toString(), // Ajusta esto según el formato de fecha que desees
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0, 1),
                                      blurRadius: 2.0,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
