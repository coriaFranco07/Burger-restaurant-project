import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_aplicacion/models/dish.dart';

class EstadoListScreen extends StatelessWidget {
  final Dish dish;

  const EstadoListScreen({Key? key, required this.dish}) : super(key: key);

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
            height: 200, // Ajusta la altura según sea necesario
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
                dish.image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Ajusta el padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dish.name,
                  style: GoogleFonts.inter(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  dish.store,
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
                      "${dish.proximity} mins",
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        FeatherIcons.heart,
                        color: const Color.fromARGB(255, 240, 39, 39),
                      ),
                      onPressed: () {
                        // Agrega aquí la lógica para gestionar el estado de favorito
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "\$${dish.price}",
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
                    onPressed: () {
                      // Acción que deseas realizar al presionar el botón
                      print("Precionaste el boton de ${dish.name}");
                    },
                    child: Text('Agregar al carrito'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
