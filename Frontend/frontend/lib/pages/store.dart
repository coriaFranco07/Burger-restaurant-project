import 'package:flutter/material.dart';
import 'package:mi_aplicacion/models/dish.dart';
import 'package:mi_aplicacion/pages/carrito.dart'; // Verifica que esta ruta sea correcta
import 'package:mi_aplicacion/pages/datos_persona.dart'; // Verifica que esta ruta sea correcta
import 'package:feather_icons/feather_icons.dart'; // Asegúrate de haber agregado la dependencia de feather_icons

class Store extends StatefulWidget {
  final List<Dish> dishes;

  const Store({Key? key, required this.dishes}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  final List<Dish> _carrito = [];

  void _addToCart(Dish dish) {
    
    setState(() {
      _carrito.add(dish);
    });
      
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Añadido al carrito'),
          content: Text('${dish.name} ha sido añadido al carrito.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar la ventana
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuestras hamburguesas',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        
        actions: [
          IconButton(
            icon: Icon(
              FeatherIcons.shoppingCart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Carrito(carrito: _carrito),
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
                  builder: (context) => DatosPersona(),
                ),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
        backgroundColor: Colors.deepPurple.shade800,
        elevation: 0,
      ),
      body: widget.dishes.isEmpty
          ? Center(
              child: Text(
                'No hay platos disponibles',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
            )
          : ListView.builder(
              itemCount: widget.dishes.length,
              itemBuilder: (context, index) {
                final dish = widget.dishes[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        dish.image,
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      dish.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dish.store,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          'Aprox: ${dish.proximity}min',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          '\$${dish.price}',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 14,
                          ),
                        ),
                        
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.add_shopping_cart,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        _addToCart(dish);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
