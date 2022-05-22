import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({Key? key}) : super(key: key);

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: _perfil()),
    );
  }

  Widget _perfil() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
              child: Image.asset(
            'assets/images/fondo.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 150),
            child: Column(
              children: [
                _boton(),
                Center(
                  child: Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xFF2F2C44),
                    ),
                    width: 600,
                    height: 500,
                    child: Column(
                      children: [],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _boton() {
    return Container(
      margin: EdgeInsets.only(left: 430, bottom: 40),
      width: 161,
      height: 47,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: new LinearGradient(
          colors: [
            Color.fromARGB(244, 134, 122, 210),
            Color.fromARGB(255, 107, 97, 175)
          ],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Añadir admin',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
