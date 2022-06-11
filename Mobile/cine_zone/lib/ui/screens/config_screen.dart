import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/shared.dart';
import 'package:cine_zone/ui/screens/ayuda_screen.dart';
import 'package:cine_zone/ui/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2F2C44),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          leadingWidth: 100,
          title: const Text('Configuración'),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              _botonAyuda(),
              _botonTerminos(),
              _botonPrivacidad(),
              _botonOff()
            ],
          ),
        ));
  }

/*
- assets/images/terminos.svg
   - assets/images/ayuda.svg
   - assets/images/privacidad.svg
   - assets/images/off.svg
*/
  Widget _botonAyuda() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AyudaScreen()),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      child: SvgPicture.asset(
                    'assets/images/ayuda.svg',
                    height: 25,
                    color: Colors.white,
                  )),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const Text(
                      'Ayuda',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              )
            ],
          )),
    );
  }

  Widget _botonTerminos() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextButton(
          onPressed: () {
            /*
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WalletScreen()),
                            );
                            */
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      child: SvgPicture.asset(
                    'assets/images/terminos.svg',
                    height: 25,
                    color: Colors.white,
                  )),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const Text(
                      'Términos de servicio',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              )
            ],
          )),
    );
  }

  Widget _botonPrivacidad() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextButton(
          onPressed: () {
            /*
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WalletScreen()),
                            );
                            */
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      child: SvgPicture.asset(
                    'assets/images/privacidad.svg',
                    height: 25,
                    color: Colors.white,
                  )),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const Text(
                      'Políticas de privacidad',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              )
            ],
          )),
    );
  }

  Widget _botonOff() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextButton(
          onPressed: () {
            Shared.remove(Constant.bearerToken).whenComplete(() =>
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', ModalRoute.withName('/')));
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      child: SvgPicture.asset(
                    'assets/images/off.svg',
                    height: 25,
                    color: const Color(0xFFD74343),
                  )),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const Text(
                      'Cerrar sesión',
                      style: TextStyle(color: Color(0xFFD74343), fontSize: 18),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
