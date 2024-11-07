import 'package:flutter/material.dart';

class NuestraHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/principal.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
              ),
              child: Image.asset(
                "assets/images/logo1.webp",
                height: MediaQuery.of(context).size.height * 0.21,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Column(
                children: [
                  Text(
                    ' "Nuestra Historia" ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nos dedicamos a brindar a nuestros clientes una experiencia gastronómica excepcional. Nuestras hamburguesas son cuidadosamente preparadas con los ingredientes más frescos y de la más alta calidad, para garantizar un sabor inigualable en cada bocado. Además, nuestro ambiente acogedor y nuestro servicio excepcional hacen que cada visita sea una experiencia memorable.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      ),
    );
  }
}
