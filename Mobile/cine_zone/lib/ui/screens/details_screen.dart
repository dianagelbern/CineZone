import 'package:cine_zone/ui/screens/cine_screen.dart';
import 'package:cine_zone/ui/screens/cines_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: principal());
  }

  Widget principal() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: cuerpo(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 40),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color.fromARGB(0, 28, 26, 41),
                          Color.fromARGB(60, 28, 26, 41),
                          Color.fromARGB(100, 28, 26, 41),
                          Color(0xFF1C1A29),
                          Color(0xFF1C1A29),
                          Color(0xFF1C1A29),
                          Color(0xFF1C1A29)
                        ]))),
                Container(
                  width: 325,
                  height: 47,
                  decoration: BoxDecoration(
                      color: const Color(0xFF867AD2),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CinesScreen()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/ticket.svg',
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Comprar",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          )
                        ],
                      )),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Widget cuerpo() {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 212,
              child: Stack(
                children: [
                  Container(
                    width: 800,
                    color: Colors.amber,
                    child: Image.network(
                      'https://static.wikia.nocookie.net/disney/images/7/7a/Star_Wars_The_Last_Jedi_Poster_Official.jpg/revision/latest?cb=20171010025646&path-prefix=es',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    width: 800,
                    color: const Color.fromARGB(171, 28, 26, 41),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                margin: const EdgeInsets.only(top: 190),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            'https://static.wikia.nocookie.net/disney/images/7/7a/Star_Wars_The_Last_Jedi_Poster_Official.jpg/revision/latest?cb=20171010025646&path-prefix=es',
                            fit: BoxFit.cover,
                            width: 130,
                            height: 189,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 150,
                                child: const Text('Star Wars: The Last Jedi',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25)),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              'Director',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    64, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              'Género',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    64, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              'Productora',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    64, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 10, left: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              'Rian Johnson',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    150, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              'Action',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    150, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              'LucasFilm',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    150, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                width: 98,
                height: 58,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(50, 253, 253, 253)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Duración',
                      style: const TextStyle(
                          color: Color.fromARGB(113, 212, 212, 212),
                          fontSize: 13),
                    ),
                    const Text(
                      '152 Min.',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                width: 98,
                height: 58,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(50, 253, 253, 253)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'P-G',
                      style: TextStyle(
                          color: const Color.fromARGB(113, 212, 212, 212),
                          fontSize: 13),
                    ),
                    const Text(
                      '13+',
                      style: const TextStyle(color: Colors.white, fontSize: 17),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('Sinopsis',
                    style: const TextStyle(fontSize: 18, color: Colors.white)),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 130),
                child: const Text(
                  "Star Wars: Episodio VIII Los Últimos Jedi, comercializada como Star Wars: Los Últimos Jedi, es una película de 2017 escrita y dirigida por Rian Johnson y producida por Kathleen Kennedy y Ram Bergman, junto con el productor ejecutivo J.J. Abrams. Es la segunda película de la trilogía de secuelas de Star Wars. \n \n La película ve el regreso de Mark Hamill, Carrie Fisher, Adam Driver, Daisy Ridley, John Boyega, Oscar Isaac, Lupita Nyong'o, Domhnall Gleeson, Anthony Daniels, Gwendoline Christie y Andy Serkis. \n \n Los nuevos miembros del reparto incluyen a Benicio Del Toro, Laura Dern y Kelly Marie Tran. Los Últimos Jedi comienza inmediatamente después de los acontecimientos de Star Wars: Episodio VII El Despertar de la Fuerza, establecida treinta años después de la conclusión de la trilogía original de Star Wars. Continúa la historia de Rey y su descubrimiento del exiliado Maestro Jedi Luke Skywalker, junto con la historia de la guerra entre la Resistencia de la General Leia Organa y la Primera Orden.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13, color: Color.fromARGB(113, 212, 212, 212)),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
