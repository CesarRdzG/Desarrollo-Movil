import 'package:flutter/material.dart';
import 'package:examen1_rgc_copy1/utils/constants.dart' as con;
import 'package:examen1_rgc_copy1/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: con.fondo,
      body: Stack(
        children: [
          Column(
            children: [
              ///FILA 1
              Container(
                height: size.height * (1 / 3),
                width: size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: con.fondo2,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: con.fondo,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: con.fondo3,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: con.fondo4,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ///FILA 2
              Container(
                height: size.height * (1 / 3),
                width: size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: con.fondo4,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: con.fondo3,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: con.fondo2,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: con.fondo,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ///FILA 3
              Container(
                height: size.height * (1 / 3),
                width: size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: con.fondo3,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: con.fondo4,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: con.fondo,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: con.fondo2,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              height: size.height * 0.42,
              width: size.width * 0.80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Bienvenido a tu primer EXAMEN',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: con.titulos,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: user,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Correo/Usuario',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: pass,
                      ///obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Contraseña',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: con.botones,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        fixedSize: const Size(300, 40),
                      ),
                      onPressed: () {
                        setState(() {
                          if (user.text == "test" && pass.text == "FDM1") {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Home()));
                          } else {
                            if (user.text == "test" && !(pass.text == "FDM1")) {
                              showSnackBar('Contraseña incorrecta', context, 5);
                            } else if (!(user.text == "test") && pass.text == "FDM1") {
                              showSnackBar('Usuario incorrecto', context, 5);
                            } else if (user.text == "" && pass.text == "") {
                              showSnackBar('Datos incompletos', context, 5);
                            } else {
                              showSnackBar('Usuario y/o Contraseña incorrectos', context, 5);
                            }
                          }
                        });
                      },
                      child: const Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Mi primer examen, ¿estará sencillo?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showSnackBar(String texto, BuildContext context, int duracion) {
  final snackBar = SnackBar(
    content: Text(texto),
    duration: Duration(seconds: duracion),
    action: SnackBarAction(
      onPressed: () {
      },
      label: 'Cerrar',
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

