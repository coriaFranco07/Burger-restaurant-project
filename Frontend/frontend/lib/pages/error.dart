import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_aplicacion/pages/principal.dart';

class ErrorScreen extends StatefulWidget {
  final String errorMessage;

  const ErrorScreen({Key? key, required this.errorMessage}) : super(key: key);

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo
          Image.asset(
            'assets/images/principal.jpg',
            fit: BoxFit.cover,
          ),
          // Contenido con fondo rayado
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CustomPaint(
              painter: StripedPainter(),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Error',
                        style: GoogleFonts.satisfy(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 40,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                      ScaleTransition(
                        scale: _animation,
                        child: Icon(
                          Icons.error_outline,
                          color: Color.fromARGB(255, 185, 7, 7),
                          size: 100,
                        ),
                      ),
                      Text(
                        'Upps, algo ha salido mal!!!',
                        style: GoogleFonts.satisfy(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Principal(),
                            ),
                          );
                        },
                        child: Text(
                          'Volver',
                          style: GoogleFonts.satisfy(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StripedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromARGB(255, 122, 2, 2)
      ..strokeWidth = 2;

    final double distance = 5;
    final double strokeWidth = 2;

    // Dibujar rayas horizontales
    for (double i = 0; i < size.height; i += distance) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }

    // Dibujar rayas verticales
    for (double i = strokeWidth / 2; i < size.width; i += distance) {
      canvas.drawLine(Offset(i, 0), Offset(i - size.height, size.height), paint);
    }

    // Dibujar rayas diagonales (izquierda arriba a derecha abajo)
    final paint2 = Paint()
      ..color = Color.fromARGB(255, 122, 2, 2)
      ..strokeWidth = 2;

    for (double i = -size.width; i < size.height; i += distance) {
      canvas.drawLine(Offset(0, i), Offset(i + size.width, size.height), paint2);
    }

    // Dibujar rayas diagonales (derecha arriba a izquierda abajo)
    final paint3 = Paint()
      ..color = Color.fromARGB(255, 122, 2, 2) // Cambiar color a uno más oscuro
      ..strokeWidth = 2;

    for (double i = size.width; i > -size.height; i -= distance) {
      canvas.drawLine(Offset(size.width, i), Offset(i, -size.height), paint3);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// Ejemplo de cómo usar ErrorScreen:
void showError(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: ErrorScreen(errorMessage: message),
      );
    },
  );
}
