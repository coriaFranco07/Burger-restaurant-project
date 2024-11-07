import 'package:flutter/material.dart';
import 'package:mi_aplicacion/pages/login_or_register.dart';
import 'package:mi_aplicacion/pages/nuestra_history.dart';
import 'package:mi_aplicacion/widgets/custom_button.dart';

class Principal extends StatelessWidget {
  const Principal({Key? key});

  void _nuestraHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NuestraHistory(),
      ),
    );
  }

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
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                children: [
                  CustomButton(
                    color: const Color(0xFFFF4317),
                    iconVisible: false,
                    text: "Iniciar",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginOrRegisterPage(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () => _nuestraHistory(context),
                    child: Text(
                      'Mas sobre nosotros...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
