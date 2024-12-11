import 'package:flutter/material.dart';
import 'package:examen1_rgc_copy1/utils/constants.dart' as con;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List lista;

  @override
  void initState() {
    lista = List.from(con.listaExamen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: con.fondo,
      body: Column(
        children: [
          /// Barra de nombre
          Container(
            width: size.width,
            height: 30,
            color: con.fondo4,
            alignment: Alignment.center,
            child: const Text(
              'SEGUNDA VISTA: Rodriguez Gloria Cesar',
              style: TextStyle(
                fontSize: 18,
                color: con.titulos,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            height: 50,
            width: size.width * 0.80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Notificaciones de actividades',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: con.titulos,
              ),
            ),
          ),
          const SizedBox(height: 25.0),
          /// CREACIÓN DE LOS WIDGETS CON LA LISTA
          Expanded(
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (BuildContext context, int index) {
                var datos = lista[index].toString().split('#');
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
                  child:  esPar(int.parse(datos[1])) == true ? createdCard2(
                      datos[1], datos[2], datos[3], int.parse(datos[4]), size)
                      : createdCard1(
                      datos[1], datos[2], datos[3], int.parse(datos[4]), size, int.parse(datos[0]))
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Container createdCard2(String numero, String titulo, String desc, int numEstrellas, Size size) {
    return Container(
      height: size.height * 0.12,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Text(
                  numero,
                  style: TextStyle(fontSize: 24, color: con.fondo),
                ),
                Spacer(),
                Icon(Icons.energy_savings_leaf_outlined),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Text(
                  titulo,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  desc,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Spacer(),
                Icon(Icons.star, color: Colors.amber, size: 15),
                Icon(Icons.star, color: Colors.amber, size: 15),
                Icon(Icons.star, color: Colors.amber, size: 15),
                Icon(Icons.star, color: Colors.amber, size: 15),
                Icon(Icons.star, color: Colors.amber, size: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container createdCard1(String numero, String titulo, String desc, int numEstrellas, Size size, int ID) {
    return Container(
      height: size.height * 0.12,
      width: size.width * 0.90,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Text(
                          numero,
                          style: TextStyle(fontSize: 24, color: con.fondo),
                        ),
                        Spacer(),
                        Icon(Icons.energy_savings_leaf_outlined),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Text(
                          titulo,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          desc,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Spacer(),
                        Icon(Icons.star, color: Colors.amber, size: 15),
                        Icon(Icons.star, color: Colors.amber, size: 15),
                        Icon(Icons.star, color: Colors.amber, size: 15),
                        Icon(Icons.star, color: Colors.amber, size: 15),
                        Icon(Icons.star, color: Colors.amber, size: 15),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: con.botones,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {

                      },
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Ver mas', style: TextStyle(
                            color: Colors.white,
                          ),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: con.botones,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if(ID != 10 && ID != 15 && ID != 20 && ID != 23)
                            lista.removeAt(ID-1);
                          showSnackBar('Se elimino el elemento con el id: $ID', context, 5);
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Borrar', style: TextStyle(
                            color: Colors.white,
                          ),),
                        ],
                      ),
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

bool esPar(int numero) {
  return numero % 2 == 0;
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