import 'package:flutter/material.dart';
import 'package:proyecto_rgc/home.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_rgc/utils/db.dart';
import 'package:proyecto_rgc/utils/singleton.dart' as res;
import 'package:proyecto_rgc/utils/constants.dart' as con;

class Renta3Confirmacion extends StatefulWidget {
  const Renta3Confirmacion({super.key});

  @override
  State<Renta3Confirmacion> createState() => _Renta3ConfirmacionState();
}

class _Renta3ConfirmacionState extends State<Renta3Confirmacion> {
  int campoFinal = res.reservation['place'] + 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              ///PESTAÑA DE ARRIBA - "Confirmacion"
              Container(
                height: size.height * (1.1 / 10),
                width: size.width,
                decoration: const BoxDecoration(
                  color: con.principal,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: (size.height * (1.1 / 10))/2.4),
                    Text(
                      "Confirmacion",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ///CONTENIDO PRINCIPAL DE LA PAGINA
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    _buildText("Nombre", res.user['fullName']),
                    SizedBox(height: 5,),
                    _buildText("Telefono", res.user['phoneNumber']),
                    SizedBox(height: 5,),
                    _buildText("Fecha del Partido", DateFormat('yyyy:MM:dd').format(res.reservation['eventDate'])),
                    SizedBox(height: 5,),
                    _buildText("Horario", res.horarios[res.reservation['time']]),
                    SizedBox(height: 5,),
                    _buildText("Tu Equipo", res.reservation['team']),
                    SizedBox(height: 5,),
                    _buildText("Equipo Rival", res.reservation['rival']),
                    SizedBox(height: 5,),
                    _buildText("Campo", "$campoFinal"),
                    SizedBox(height: (size.height * (2 / 10))),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: const Border(
                          top: BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Precio",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "\$400",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () async {
                        int reservationId = await DatabaseHelper.createReservation(res.reservation);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Reservación confirmada. ID: $reservationId'),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: con.principal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: const Size(200, 60),
                      ),
                      child: const Text(
                        "Confirmar",
                        style: TextStyle(
                          color: Colors.white,
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
  Widget _buildText(String categoria, dynamic dato) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              categoria,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              dato,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
