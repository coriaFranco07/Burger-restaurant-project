import 'dart:convert'; // Para jsonEncode
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_aplicacion/models/dish.dart';
import 'package:http/http.dart' as http; // Para las solicitudes HTTP

class MiPedidoContent extends StatefulWidget {
  final List<Dish> carrito;
  final int idCliente; // Agrega esta línea

  const MiPedidoContent({Key? key, required this.carrito, required this.idCliente}) : super(key: key);

  @override
  _MiPedidoContentState createState() => _MiPedidoContentState();
}

class _MiPedidoContentState extends State<MiPedidoContent> {
  Future<void> _sendOrder(List<Dish> carrito, double total) async {
    // Crear una lista de items
    final items = carrito.map((dish) => {
      'id_comida': dish.id_comida, // Asegúrate de que `dish.id` esté definido en tu modelo
      'cantidad': dish.quantity,
      'total': dish.price * dish.quantity,
    }).toList();

    // Crear el pedido con solo `id_cliente` y `id_estado`
    final orderData = {
      'id_cliente': widget.idCliente,
      'id_estado': 10,//Pendiente
    };

    print(orderData);

    final response = await http.post(
      Uri.parse('http://192.168.245.21:8000/api/pedido/'), 
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 201) {
      // Obtener el id_pedido del response
      final orderResponse = jsonDecode(response.body);
      final int orderId = orderResponse['id_pedido']; // Asegúrate de que este sea el campo correcto

      print('Pedido enviado exitosamente');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SeleccionFormaPagoPage(orderId: orderId, items: items),
        ),
      );
    } else {
      print('Error al enviar el pedido: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.carrito.isEmpty
        ? Center(child: Text('No hay platos en el carrito'))
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.carrito.length,
                  itemBuilder: (context, index) {
                    Dish dish = widget.carrito[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            children: [
                              Image.network(
                                dish.image,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: 180,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.6),
                                      Colors.transparent
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dish.name,
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
                                      dish.store,
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
                                          "\$${dish.price}",
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
                                        Spacer(),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.remove, color: Colors.white),
                                              onPressed: () {
                                                setState(() {
                                                  if (dish.quantity > 1) {
                                                    dish.quantity--;
                                                  }
                                                });
                                              },
                                            ),
                                            Text(
                                              '${dish.quantity}',
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
                                            IconButton(
                                              icon: Icon(Icons.add, color: Colors.white),
                                              onPressed: () {
                                                setState(() {
                                                  if (dish.quantity < 100) {
                                                    dish.quantity++;
                                                  }
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    double total = _calculateTotal(widget.carrito);
                    _sendOrder(widget.carrito, total);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pagar \$${_calculateTotal(widget.carrito)}',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }

  double _calculateTotal(List<Dish> carrito) {
    double total = 0;
    for (var dish in carrito) {
      total += dish.price * dish.quantity;
    }
    return total;
  }
}

class SeleccionFormaPagoPage extends StatelessWidget {
  final int orderId;
  final List<Map<String, dynamic>> items;

  const SeleccionFormaPagoPage({Key? key, required this.orderId, required this.items}) : super(key: key);

  Future<void> _sendOrderDetails(BuildContext context, int orderId, Map<String, dynamic> item, String paymentMethod) async {
  final orderDetail = {
    'id_pedido': orderId,
    'id_comida': item['id_comida'],
    'cantidad_comida': item['cantidad'],
    'total': item['total'],
    'id_estado': 11, // Asumiendo que 'id_estado' 6 es 'Pagado'
  };

  final response = await http.post(
    Uri.parse('http://192.168.245.21:8000/api/pedido_detalle/'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(orderDetail),
  );

  if (response.statusCode == 201) {
    print('Detalles del pedido enviados exitosamente');

    // Actualizar estado del pedido a 'Finalizado'
    await _updateOrderStatus(orderId);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmacionPagoPage(orderId: orderId, paymentMethod: paymentMethod),
      ),
    );
  } else {
    print('Error al enviar los detalles del pedido: ${response.body}');
  }
}

Future<void> _updateOrderStatus(int orderId) async {
  final orderData = {
    'id_estado': 12, 
  };

  final response = await http.patch(
    Uri.parse('http://192.168.245.21:8000/api/pedido/$orderId/'), // Endpoint para actualizar pedido por ID
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(orderData),
  );

  if (response.statusCode == 200) {
    print('Estado del pedido actualizado a Finalizado');
  } else {
    print('Error al actualizar el estado del pedido: ${response.body}');
  }
}

  void _sendAllOrderDetails(BuildContext context, int orderId, List<Map<String, dynamic>> items, String paymentMethod) {
    for (var item in items) {
      _sendOrderDetails(context, orderId, item, paymentMethod);
    }
  }

  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.deepPurple,
      title: Text(
        'Seleccionar Forma de Pago',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selecciona tu forma de pago:',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade800,
            ),
          ),
          SizedBox(height: 20),
          _buildStyledButton(
              context, 'Tarjeta de Crédito', Icons.credit_card, Colors.purple),
          _buildStyledButton(
              context, 'PayPal', Icons.account_balance_wallet, Colors.blue),
          _buildStyledButton(
              context, 'Transferencia Bancaria', Icons.money, Colors.green),
        ],
      ),
    ),
  );
}

Widget _buildStyledButton(
    BuildContext context, String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
      ),
      onPressed: () {
        _sendAllOrderDetails(context, orderId, items, title);
      },
      icon: Icon(icon, size: 24, color: Colors.white),
      label: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}

}

class ConfirmacionPagoPage extends StatelessWidget {
  final int orderId;
  final String paymentMethod;

  const ConfirmacionPagoPage({Key? key, required this.orderId, required this.paymentMethod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmación de Pago'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gracias por tu compra!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Número de Pedido: $orderId'),
            Text('Método de Pago: $paymentMethod'),
          ],
        ),
      ),
    );
  }
}

