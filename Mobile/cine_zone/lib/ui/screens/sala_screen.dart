import 'package:cine_zone/ui/screens/compra_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SalaScreen extends StatefulWidget {
  const SalaScreen({Key? key}) : super(key: key);

  @override
  State<SalaScreen> createState() => _SalaScreenState();
}

class _SalaScreenState extends State<SalaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2F2C44),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        leadingWidth: 100,
        title: Text('Nombre de película'),
      ),
      body: _sala(),
    );
  }

  Widget _sala() {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          screen(),
          _asientos(),
          _info(),
          Padding(
            padding: EdgeInsets.all(20),
            child: _info_compra(),
          )
        ],
      ),
    ));
  }

  Widget screen() {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: SvgPicture.asset('assets/images/pantalla.svg')),
        Text(
          'Pantalla',
          style: TextStyle(
              color: Color.fromARGB(148, 255, 255, 255), fontSize: 14),
        ),
      ],
    );
  }

  Widget _asientos() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      color: Colors.white,
      height: 300,
    );
  }

  Widget _info() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Divider(color: Color.fromARGB(52, 255, 255, 255), height: 3),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              asiento_info('assets/images/libre.png', 'Libre'),
              asiento_info('assets/images/ocupado.png', 'Ocupado'),
              asiento_info('assets/images/seleccionado.png', 'Seleccionado')
            ],
          ),
        )
      ],
    );
  }

  Widget asiento_info(String image, String info) {
    return Row(
      children: [
        Image.asset(
          image,
          width: 20,
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            info,
            style: TextStyle(
                color: Color.fromARGB(155, 255, 255, 255), fontSize: 11),
          ),
        )
      ],
    );
  }

  Widget _info_compra() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      height: 47,
      decoration: BoxDecoration(
          color: Color(0xFF867AD2), borderRadius: BorderRadius.circular(10)),
      child: TextButton(
          onPressed: () => showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 47, 44, 68),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    height: 280,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.domain,
                                color: Colors.white,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Nombre del cine',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                cineInfo('Hora', '16:30'),
                                cineInfo('Fecha', '24 Jun'),
                                cineInfo('Entrada', 'Regular')
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Lugares',
                                  style: TextStyle(
                                      color: Color.fromARGB(113, 212, 212, 212),
                                      fontSize: 14),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Text('A10, ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)),
                                      Text('A11',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      color: Color.fromARGB(113, 212, 212, 212),
                                      fontSize: 14),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Text('17.00€',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          boton_compra()
                        ],
                      ),
                    ));
              }),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/ticket.svg',
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Comprar",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            ],
          )),
    );
  }

  Widget cineInfo(String infoEstatica, String info) {
    return Container(
      width: 98,
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(50, 253, 253, 253)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            infoEstatica,
            style: TextStyle(
                color: Color.fromARGB(113, 212, 212, 212), fontSize: 13),
          ),
          Text(
            info,
            style: TextStyle(color: Colors.white, fontSize: 17),
          )
        ],
      ),
    );
  }

  Widget boton_compra() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      height: 47,
      decoration: BoxDecoration(
          color: Color(0xFF867AD2), borderRadius: BorderRadius.circular(10)),
      child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CompraScreen()),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/ticket.svg',
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Comprar",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            ],
          )),
    );
  }
}
