import 'package:flutter/material.dart';
import 'package:proyecto_rgc/utils/constants.dart' as con;

import 'package:proyecto_rgc/login.dart';
import 'package:proyecto_rgc/sign_up.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: size.height * (8.3 / 10),
                  width: size.width,
                  child: Column(
                    children: [
                      const SizedBox(height: 70),
                      Container(
                        height: size.height * (5 / 10),
                        width: size.width * (9 / 10),
                        color: Colors.green,
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "GoFutbol",
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Rentar una cancha de futbol nunca fue tan facil.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF6E6E6E),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => SignUp()));
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: con.principal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: const Size(150, 60),
                        ),
                        child: const Text(
                          "Registrarse",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Login()));
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                              color: con.principal,
                              width: 2,
                          ),
                          ),
                          minimumSize: const Size(150, 60),
                        ),
                        child: const Text(
                          "Iniciar Sesion",
                          style: TextStyle(
                            color: con.principal,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }
}
