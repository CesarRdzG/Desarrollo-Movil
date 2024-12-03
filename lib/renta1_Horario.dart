import 'package:flutter/material.dart';
import 'package:proyecto_rgc/renta2_Campos.dart';
import 'package:proyecto_rgc/utils/db.dart';
import 'package:proyecto_rgc/utils/constants.dart' as con;
import 'package:proyecto_rgc/utils/singleton.dart' as res;
import 'package:syncfusion_flutter_calendar/calendar.dart';


class Renta1 extends StatefulWidget {
  const Renta1({super.key});

  @override
  State<Renta1> createState() => _Renta1State();
}

class _Renta1State extends State<Renta1> {
  TextEditingController nombreTeam = TextEditingController();
  TextEditingController nombreRival = TextEditingController();
  int _selectedButtonIndex = -1;

  void initState() {
    super.initState();
    loadReservations();
  }

  Future<void> loadReservations() async {
    List<Map<String, dynamic>> data = await DatabaseHelper.getReservations();

    setState(() {
      res.reservations = data;
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
              /// PESTAÑA DE ARRIBA - "Horarios"
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
                    SizedBox(height: (size.height * (1.1 / 10)) / 2.4),
                    Text(
                      "Horarios",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              /// CONTENIDO PRINCIPAL DE LA PÁGINA
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        /// PRIMER TEXTO - "Dia del Partido"
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 5.0,
                            top: 15.0,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Dia del Partido",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        /// CALENDARIO
                        Container(
                          height: size.height * (3.45 / 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: SfCalendar(
                              view: CalendarView.month,
                              showNavigationArrow: true,
                              dataSource: ReservationDataSource(convertReservationsToAppointments()),
                              cellBorderColor: Colors.transparent,
                              todayHighlightColor: con.principal,
                              selectionDecoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              headerStyle: CalendarHeaderStyle(
                                backgroundColor: con.botonesFondo,
                                textAlign: TextAlign.center,
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              onSelectionChanged: (CalendarSelectionDetails details){
                                DateTime date = details.date!;
                                res.reservation['eventDate'] = date;
                              },
                            ),
                          ),
                        ),
                        /// SEGUNDO TEXTO- "Horario del Partido"
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 5.0,
                            top: 15.0,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Horario del Partido",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        /// BOTONES
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              _buildButton("8:00-10:00", 0),
                              const SizedBox(width: 5),
                              _buildButton("10:00-12:00", 1),
                              const SizedBox(width: 5),
                              _buildButton("12:00-14:00", 2),
                              const SizedBox(width: 5),
                              _buildButton("14:00-16:00", 3),
                              const SizedBox(width: 5),
                              _buildButton("16:00-18:00", 4),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                        /// CAMPOS RESTANTES
                        Column(
                          children: [
                            /// TERCER TEXTO - "Nombre del Equipo"
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 5.0,
                                top: 15.0,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Nombre del Equipo",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: nombreTeam,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: con.botonesFondo,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            /// CUARTO TEXTO - "Nombre del Equipo Rival"
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 5.0,
                                top: 15.0,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Nombre del Equipo Rival",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: nombreRival,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: con.botonesFondo,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 30),
                            ///BOTON SIGUIENTE
                            TextButton(
                              onPressed: () {
                                res.reservation['team'] = nombreTeam.text;
                                res.reservation['rival'] = nombreRival.text;
                                setState(() {
                                  if (res.reservation['team'] != "" && res.reservation['rival'] != ""
                                      && res.reservation['time'] != null && res.reservation['eventDate'] != null) {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => Renta2Campos()));
                                  } else {
                                    showSnackBar('Complete todos los campos', context, 3);
                                  }
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: con.principal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                minimumSize: const Size(200, 60),
                              ),
                              child: const Text(
                                "Siguiente",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Método para construir cada botón con el índice correspondiente
  Widget _buildButton(String horario, int index) {
    return TextButton(
      onPressed: () {
        res.reservation['time'] = index;
        setState(() {
          _selectedButtonIndex = index;
        });
      },
      style: TextButton.styleFrom(
        backgroundColor: _selectedButtonIndex == index
            ? Color(0xFF0F2A1D)
            : con.botonesFondo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: const Size(100, 35),
      ),
      child: Text(
        horario,
        style: TextStyle(
          color: _selectedButtonIndex == index ? Colors.white : Colors.black,
        ),
      ),
    );
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

  List<Appointment> convertReservationsToAppointments() {
    return res.reservations.map((reservation) {
      return Appointment(
        startTime: obtenerHorarioInicio(reservation['time'], reservation['eventDate']),
        endTime: obtenerHorarioFinal(reservation['time'], reservation['eventDate']),
        subject: '${reservation['team']} vs ${reservation['rival']}',
        location: 'Campo: ${reservation['place'] + 1}',
        color: Colors.blue,
      );
    }).toList();
  }

  DateTime obtenerHorarioInicio(int horario, DateTime fecha) {
    DateTime horaInicio;

    switch (horario) {
      case 0:
        horaInicio = DateTime(fecha.year, fecha.month, fecha.day, 8, 0);
        break;
      case 1:
        horaInicio = DateTime(fecha.year, fecha.month, fecha.day, 10, 0);
        break;
      case 2:
        horaInicio = DateTime(fecha.year, fecha.month, fecha.day, 12, 0);
        break;
      case 3:
        horaInicio = DateTime(fecha.year, fecha.month, fecha.day, 14, 0);
        break;
      case 4:
        horaInicio = DateTime(fecha.year, fecha.month, fecha.day, 16, 0);
        break;
      default:
        throw ArgumentError("Índice de horario no válido: $horario");
    }
    return horaInicio;
  }

  DateTime obtenerHorarioFinal(int horario, DateTime fecha) {
    DateTime horaFinal;

    switch (horario) {
      case 0:
        horaFinal = DateTime(fecha.year, fecha.month, fecha.day, 10, 0);
        break;
      case 1:
        horaFinal = DateTime(fecha.year, fecha.month, fecha.day, 12, 0);
        break;
      case 2:
        horaFinal = DateTime(fecha.year, fecha.month, fecha.day, 14, 0);
        break;
      case 3:
        horaFinal = DateTime(fecha.year, fecha.month, fecha.day, 16, 0);
        break;
      case 4:
        horaFinal = DateTime(fecha.year, fecha.month, fecha.day, 18, 0);
        break;
      default:
        throw ArgumentError("Índice de horario no válido: $horario");
    }
    return horaFinal;
  }
}

class ReservationDataSource extends CalendarDataSource {
  ReservationDataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
