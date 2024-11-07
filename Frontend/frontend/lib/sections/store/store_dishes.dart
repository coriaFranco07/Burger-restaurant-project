import 'package:flutter/material.dart';
import 'package:mi_aplicacion/models/dish.dart';
import 'package:mi_aplicacion/widgets/custom_dish.dart';

class StoreDishes extends StatefulWidget {
  final List<Dish> dishes;

  const StoreDishes({Key? key, required this.dishes}) : super(key: key);

  @override
  _StoreDishesState createState() => _StoreDishesState();
}

class _StoreDishesState extends State<StoreDishes> {
  final List<Dish> _carrito = [];

  void _addToCart(Dish dish) {
    setState(() {
      _carrito.add(dish);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 320, // Ajusta este valor para acomodar la nueva altura de la imagen
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: widget.dishes.length,
        itemBuilder: (context, index) {
          return CustomDish(
            dish: widget.dishes[index],
            onAddToCart: () {
              _addToCart(widget.dishes[index]);
            },
          );
        },
      ),
    );
  }
}
