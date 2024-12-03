import 'package:flutter/material.dart';
import 'package:proyecto_rgc/renta3_confirmacion.dart';
import 'package:proyecto_rgc/utils/constants.dart' as con;
import 'package:proyecto_rgc/utils/singleton.dart' as res;

class Renta2Campos extends StatefulWidget {
  const Renta2Campos({super.key});

  @override
  State<Renta2Campos> createState() => _Renta2CamposState();
}

class _Renta2CamposState extends State<Renta2Campos> {
  List<int> availableFields = [0, 1, 2, 3, 4];

  void initState() {
    super.initState();
    filterFields();
  }

  void filterFields() {
    DateTime selectedDate = res.reservation['eventDate'];
    int selectedTime = res.reservation['time'];

    List<Map<String, dynamic>> conflicts =
    filterReservationsByDateAndTime(selectedDate, selectedTime);

    List<int> occupiedFields =
    conflicts.map((reservation) => reservation['place'] as int).toList();

    setState(() {
      availableFields =
          [0, 1, 2, 3, 4].where((field) => !occupiedFields.contains(field)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              ///PESTAÑA DE ARRIBA - "Seleccion de Campo"
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
                      "Seleccion de Campo",
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
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///PRIMER TEXTO - "Seleccione un Campo"
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Seleccione un Campo",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: availableFields.map((field) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: TextButton(
                            onPressed: () {
                              res.reservation['place'] = field;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Renta3Confirmacion(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              minimumSize: const Size(300, 50),
                            ),
                            child: Text(
                              "Campo ${field + 1}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> filterReservationsByDateAndTime(DateTime date, int time) {
    return res.reservations.where((reservation) {
      return reservation['eventDate'] == date && reservation['time'] == time;
    }).toList();
  }
}
