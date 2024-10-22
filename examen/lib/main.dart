import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
       debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 241, 121, 229)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Inicio de sesión'),
    );
  }
}

List<Persona> _personas = [
  Persona('luis', 'Luis Angel Mateo Flores', 'luis12345'),
  Persona('juan', 'Juan Lopez Perez', 'juan5897'),
  Persona('angel', 'Angel Gonzales Lopez', '987654'),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _failedAttempts = 0; // Variable para contar los intentos fallidos

  void _onLogin() {
    String name = _nameController.text;
    String password = _passwordController.text;

    try {
      Persona? user = _personas.firstWhere(
        (persona) => persona.name == name && persona.pass == password,
      );

      if (user != null) {
        // Reinicia los intentos fallidos
        setState(() {
          _failedAttempts = 0;
        });

        // Usuario encontrado, navega a la siguiente pantalla
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Principal2(user: user),
          ),
        );
      }
    } catch (e) {
      // Incrementa el contador de intentos fallidos
      setState(() {
        _failedAttempts++;
      });

      // Usuario no encontrado, muestra mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Nombre',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30.0),
            TextField(
              controller: _passwordController,
              obscureText: true, // Para ocultar la contraseña
              decoration: const InputDecoration(
                hintText: 'Contraseña',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30.0),
            TextButton(
              child: const Text(
                'Entrar',
                style: TextStyle(fontSize: 15.0, color: Colors.black, ),
              ),
              onPressed: _onLogin,
            ),
            const SizedBox(height: 30.0),
            // Muestra el contador de intentos fallidos debajo de los botones
            Text(
              'Intentos fallidos: $_failedAttempts',
              style: const TextStyle(fontSize: 16.0, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class Principal2 extends StatelessWidget {
  final Persona user;

  const Principal2({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos del Usuario'),
      ),
      body: Center(
        child: Text(
          'Login del usuario: ${user.name}\nNombre: ${user.nombre}\n${user.nombre} encontrado',
          style: const TextStyle(fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Persona {
  final String name;
  final String nombre;
  final String pass;

  Persona(this.name, this.nombre, this.pass);
}
