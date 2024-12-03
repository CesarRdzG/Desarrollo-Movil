import 'package:flutter/material.dart';
import 'package:proyecto_rgc/utils/constants.dart' as con;
import 'package:proyecto_rgc/utils/singleton.dart' as res;

import 'package:proyecto_rgc/sign_up.dart';
import 'package:proyecto_rgc/home.dart';
import 'package:proyecto_rgc/utils/db.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController telefono = TextEditingController();
  final pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "¡Bienvenido de vuelta!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color: con.principal,
                ),
              ),
              const SizedBox(height: 50),
              TextFormField(
                controller: telefono,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Telefono',
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Contraseña',
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () async {
                  if (telefono.text.isEmpty || pass.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor, ingrese su número de teléfono y contraseña'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  final user = await DatabaseHelper.loginUser(telefono.text, pass.text);
                  if (user != null) {
                    res.user['fullName'] = user['fullName'];
                    res.user['phoneNumber'] = user['phoneNumber'];
                    res.user['password'] = user['password'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Número de teléfono o contraseña incorrectos'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: con.principal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: const Size(200, 60),
                ),
                child: const Text(
                  "Iniciar Sesión",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "¿No tiene una cuenta? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      "Regístrate aquí",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue, // Simula un enlace
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
