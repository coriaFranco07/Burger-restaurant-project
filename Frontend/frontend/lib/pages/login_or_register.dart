import 'dart:convert'; // Necesario para jsonEncode y jsonDecode
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mi_aplicacion/apis/comida/dish.dart';
import 'package:mi_aplicacion/models/dish.dart';
import 'package:mi_aplicacion/pages/store.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginOrRegisterPage extends StatefulWidget {
  @override
  _LoginOrRegisterPageState createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: [
            // Imagen de fondo
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/principal.jpg'), // Asegúrate de tener esta imagen en tu carpeta assets
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Contenido principal
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 50), // Espacio entre la parte superior y la TabBar
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]?.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(25.8),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: Color.fromARGB(255, 167, 161, 161).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      controller: _tabController,
                      tabs: [
                        Tab(
                          child: Text(
                            'Login',
                            style: GoogleFonts.satisfy(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Register',
                            style: GoogleFonts.satisfy(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        LoginWidget(),
                        RegisterWidget(),
                      ],
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


class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late Future<List<Dish>> futureDishes; // Usar Future para cargar platos
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureDishes = _loadDishes();
  }

  Future<List<Dish>> _loadDishes() async {
    return await ApiComida().fetchComida();
  }

  void _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    // URL de tu API (usando HTTP en lugar de HTTPS)
    final String apiUrl = 'http://192.168.245.21:8000/api/login/';

    // Realizar solicitud POST
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final int clienteId =
            responseData['user']['id_cliente']; // Extrae id_cliente del campo user

        print('Cliente ID: $clienteId');
        print('Username: $username');
        print('Password: $password');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Credenciales Correctas')),
        );

        // Guardar datos en SharedPreferences después de iniciar sesión
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt(
            'id_cliente', clienteId); // Guardar el ID del cliente en SharedPreferences

        // Si el servidor devuelve una respuesta OK, navegar a la siguiente pantalla
        final List<Dish> dishes = await futureDishes; // Esperar a que los platos se carguen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Store(
              //heroDish: dishes[0], // Pasar el primer plato como el plato principal
              dishes: dishes, // Pasar la lista completa de platos
            ),
          ),
        );
      } else {
        // Si la respuesta no fue OK, mostrar un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Credenciales inválidas')),
        );
      }
    } catch (error) {
      // Manejo de errores de red
      print('Error en la solicitud: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la conexión con el servidor')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Dish>>(
      future: futureDishes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mostrar un indicador de carga mientras los platos se están cargando
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // Manejo de errores al cargar los platos
          return Center(
            child: Text(
              'Error al cargar datos',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else {
          // Los platos se han cargado correctamente
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: GoogleFonts.satisfy(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  late List<Dish> dishes;
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDishes();
  }

  void _loadDishes() async {
    dishes = await ApiComida().fetchComida();
  }

  Future<void> _register() async {
    final String nombre_completo = _nombreController.text;
    final String telefono = _telefonoController.text;
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    print('Nombre Completo: $nombre_completo');
    print('Telefono: $telefono');
    print('Username: $username');
    print('Password: $password');

    final String apiUrl = 'http://192.168.245.21:8000/api/register/';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nombre_completo': nombre_completo,
          'usuario': username,  // Verifica que este nombre sea correcto
          'contraseña': password,  // Verifica que este nombre sea correcto
          'num_tel': telefono,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Credenciales Correctas')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Store(
              //heroDish: dishes[0],
              dishes: dishes,
            ),
          ),
        ); 
      } else {
        print('Error en el servidor: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Credenciales inválidas')),
        );
      }

    } catch (error) {
      print('Error en la solicitud: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la conexión con el servidor')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Register',
            style: GoogleFonts.satisfy(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _nombreController,
            decoration: InputDecoration(
              labelText: 'Nombre Completo',
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _telefonoController,
            decoration: InputDecoration(
              labelText: 'Telefono',
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _register,
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
