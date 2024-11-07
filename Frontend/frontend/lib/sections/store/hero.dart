import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_aplicacion/models/dish.dart';
import 'package:mi_aplicacion/pages/carrito.dart';
import 'package:mi_aplicacion/pages/datos_persona.dart'; // Importa la pantalla de datos de la persona

class CustomHero extends StatelessWidget {
  final Dish dish;
  final List<Dish> carrito;

  const CustomHero({Key? key, required this.dish, required this.carrito}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/principal.jpg"),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 44, right: 16, left: 16, bottom: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        FeatherIcons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Abre un diálogo con un campo de texto para buscar
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Buscar'),
                              content: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Ingrese su búsqueda',
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancelar'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Lógica para realizar la búsqueda
                                    Navigator.of(context).pop();
                                    // Puedes manejar la lógica de búsqueda aquí
                                  },
                                  child: Text('Buscar'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    
                    const SizedBox(width: 16),

                    IconButton(
                      icon: Icon(
                        FeatherIcons.shoppingCart,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Carrito(carrito: carrito),
                          ),
                        );
                      },
                    ),

                    const SizedBox(width: 16),

                    IconButton(
                      icon: Icon(
                        FeatherIcons.user,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DatosPersona(), // Página de datos de la persona
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenido...',
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'La mejor App de comida',
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FeatherIcons.facebook,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      size: 30,
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      FeatherIcons.instagram,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      size: 30,
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      FeatherIcons.twitter,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
