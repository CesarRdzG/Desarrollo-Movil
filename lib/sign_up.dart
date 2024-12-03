import 'package:flutter/material.dart';
import 'package:proyecto_rgc/utils/constants.dart' as con;
import 'package:proyecto_rgc/utils/singleton.dart' as res;

import 'package:proyecto_rgc/login.dart';
import 'package:proyecto_rgc/home.dart';
import 'package:proyecto_rgc/utils/db.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nombre = TextEditingController();
  TextEditingController telefono = TextEditingController();
  final pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Crea una cuenta",
                    style: TextStyle(
                      fontSize: 40,
                      color: con.principal,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: nombre,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Nombre Completo',
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: telefono,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Número Telefónico',
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
                      if (nombre.text.isEmpty || telefono.text.isEmpty || pass.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor, complete todos los campos'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      res.user['fullName'] = nombre.text;
                      res.user['phoneNumber'] = telefono.text;
                      res.user['password'] = pass.text;

                      int result = await DatabaseHelper.registerUser(res.user);

                      if (result > 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error al registrar usuario. Verifique los datos.'),
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
                      "Registrarse",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "¿Ya tiene una cuenta? ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          "Iniciar Sesión",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
