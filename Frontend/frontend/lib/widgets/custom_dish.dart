import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:http/http.dart' as http;
import 'package:mi_aplicacion/models/dish.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDish extends StatefulWidget {
  final Dish dish;
  final VoidCallback onAddToCart;

  const CustomDish({
    Key? key,
    required this.dish,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  _CustomDishState createState() => _CustomDishState();
}

class _CustomDishState extends State<CustomDish> {
  bool isLiked = false;
  late int idCliente;

  @override
  void initState() {
    super.initState();
    _loadClientId();
    _checkIfLiked(); // Verificar si el plato está marcado como liked al inicializar
  }

  Future<void> _loadClientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idCliente = prefs.getInt('id_cliente') ?? 0;
    });
  }

  Future<void> _checkIfLiked() async {
    final url = 'http://192.168.245.21:8000/api/like/like_by_user/$idCliente/';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          isLiked = data.any((item) => item['id_comida'] == widget.dish.id_comida);
        });
      } else {
        // Manejar errores
        print('Error al cargar las hamburguesas favoritas: ${response.statusCode}');
      }
    } catch (error) {
      // Manejar errores de conexión u otros errores
      print('Error: $error');
    }
  }

  Future<void> toggleLike() async {
    final url = isLiked
        ? 'http://192.168.245.21:8000/api/like/dislike_comida/'
        : 'http://192.168.245.21:8000/api/like/like_comida/';

    try {
      final response = isLiked
          ? await http.delete(
              Uri.parse(url),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({
                'id_comida': widget.dish.id_comida,
                'id_cliente': idCliente
              }),
            )
          : await http.post(
              Uri.parse(url),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({
                'id_comida': widget.dish.id_comida,
                'id_cliente': idCliente
              }),
            );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          isLiked = !isLiked;
        });
      } else {
        // Manejar errores
        print('Error: ${response.body}');
      }
    } catch (error) {
      // Manejar errores de conexión u otros errores
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 224, 219, 219),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 205,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network(
                widget.dish.image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.dish.name,
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    widget.dish.store,
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        FeatherIcons.clock,
                        color: Colors.red,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${widget.dish.proximity} mins",
                        style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? const Color.fromARGB(255, 240, 39, 39) : Colors.grey,
                        ),
                        onPressed: toggleLike,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "\$${widget.dish.price}",
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: widget.onAddToCart,
                      child: Text('Agregar al carrito'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
