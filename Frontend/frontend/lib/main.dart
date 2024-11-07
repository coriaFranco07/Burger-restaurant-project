import 'package:flutter/material.dart';
import 'package:mi_aplicacion/pages/error.dart';
import 'package:mi_aplicacion/pages/estado.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      debugShowCheckedModeBanner: false,
      home: ErrorScreen(errorMessage: '',)
    );
  }
}
