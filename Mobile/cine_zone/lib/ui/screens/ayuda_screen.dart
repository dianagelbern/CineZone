import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AyudaScreen extends StatefulWidget {
  const AyudaScreen({Key? key}) : super(key: key);

  @override
  State<AyudaScreen> createState() => _AyudaScreenState();
}

class _AyudaScreenState extends State<AyudaScreen> {
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
        title: const Text('Ayuda'),
      ),
      body: SingleChildScrollView(child: cuerpo()),
    );
  }

  Widget cuerpo() {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                const Text(
                  'Contacta con CineZone',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                const Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Siempre que quieras puedes contactar con nosotros por cualquiera de nuestras redes sociales',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          socialMedia('Twitter', 'assets/images/twitter.png', '@CineZone'),
          socialMedia('Correo electrónico', 'assets/images/mail.png',
              'team@cinezone.com'),
          socialMedia('Facebook', 'assets/images/facebook.png', 'CineZone'),
          socialMedia('WhatsApp', 'assets/images/wa.png', 'CineZone'),
          socialMedia('Instagram', 'assets/images/insta.png', 'CineZone')
        ],
      ),
    );
  }

  /*
  - assets/images/facebook.png
   - assets/images/insta.png
   - assets/images/mail.png
   - assets/images/twitter.png
   - assets/images/wa.png
  */

  Widget socialMedia(String titulo, String imagen, String nombre) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            titulo,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(imagen),
                ),
                Text(
                  nombre,
                  style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontSize: 15),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
