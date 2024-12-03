import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_rgc/utils/constants.dart' as con;
import 'package:proyecto_rgc/utils/singleton.dart' as res;

import 'package:proyecto_rgc/renta1_Horario.dart';
import 'package:proyecto_rgc/utils/db.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
                      "Go Futbol",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ///CONTENEDOR PRINCIPAL CON SCROLL
              Container(
                height: size.height * (8.1 / 10),
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        ///CONTENEDOR 1 - MAPA
                        Container(
                          height: 50,
                          width: size.width,
                          decoration: const BoxDecoration(
                            color: con.principal,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                          ),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Text(
                                "Donde nos encontramos",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * (3 / 10),
                          width: size.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                            child: FlutterMap(
                              options: MapOptions(
                                initialCenter: con.position,
                                initialZoom: 15,
                                minZoom: 11,
                                maxZoom: 17,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate: 'https://api.mapbox.com/styles/v1/'
                                      '{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                                  additionalOptions: {
                                    'accessToken': con.accessToken,
                                    'id': 'mapbox/streets-v12',
                                  },
                                ),
                                MarkerLayer(
                                  markers: [
                                    Marker(
                                      point: con.position,
                                      child: const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ///CONTENEDOR 2
                        Container(
                          height: 50,
                          width: size.width,
                          decoration: const BoxDecoration(
                            color: con.principal,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                          ),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Text(
                                "Tus reservaciones",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * (3.4 / 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                            border: const Border(
                              left: BorderSide(color: Colors.grey, width: 1.0),
                              right: BorderSide(color: Colors.grey, width: 1.0),
                              bottom: BorderSide(color: Colors.grey, width: 1.0),
                            ),
                          ),
                          child: ListView.builder(
                            itemCount: res.reservations.length,
                            itemBuilder: (context, index) {
                              final reservation = res.reservations[index];
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        title: Text("Reservación ${reservation['id']}"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Fecha: ${reservation['eventDate'].toIso8601String().split('T')[0]}"),
                                            const SizedBox(height: 8),
                                            Text("Horario: ${res.horarios[reservation['time']]}"),
                                            const SizedBox(height: 8),
                                            Text("Equipo: ${reservation['team']}"),
                                            const SizedBox(height: 8),
                                            Text("Rival: ${reservation['rival']}"),
                                            const SizedBox(height: 8),
                                            Text("Lugar: Campo ${reservation['place'] + 1}"),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            child: const Text("Cerrar"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey, width: 1),
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text("Reservación ${reservation['id']}"),
                                    subtitle: Text(
                                      "${reservation['eventDate'].toIso8601String().split('T')[0]} | "
                                          "${res.horarios[reservation['time']]}",
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                        ),
                        SizedBox(height: 10),
                        ///CALENDARIO
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
                                backgroundColor: con.principal,
                                textAlign: TextAlign.center,
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              onLongPress: (CalendarLongPressDetails details) {
                                if (details.appointments != null && details.appointments!.isNotEmpty) {
                                  final appointments = details.appointments!;
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        title: Text("Reservaciones del día"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: appointments.map((appointment) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Título: ${appointment.subject}", style: TextStyle(fontWeight: FontWeight.bold)),
                                                  Text("Hora: ${appointment.startTime.hour}:${appointment.startTime.minute.toString().padLeft(2, '0')} - "
                                                      "${appointment.endTime.hour}:${appointment.endTime.minute.toString().padLeft(2, '0')}"),
                                                  Text("Lugar: Campo ${(appointment.location ?? 'Sin especificar')}"),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            child: const Text("Cerrar"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("No hay reservaciones para este día."),
                                    ),
                                  );
                                }
                              },
                              onSelectionChanged: (CalendarSelectionDetails details){
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Renta1()));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: con.principal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(size.width, 45),
                    ),
                    child: const Text(
                      "Renta un campo",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
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
