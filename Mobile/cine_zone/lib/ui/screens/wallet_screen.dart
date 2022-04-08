import 'package:cine_zone/ui/screens/menu_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
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
        title: Text('Walllet'),
      ),
      body: SingleChildScrollView(child: _tarjetas()),
    );
  }

  Widget _tarjetas() {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tarjetas y cuentas',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text('+ Añadir',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600)))
              ],
            ),
          ),
          _walletCard(),
          Divider(color: Colors.grey, height: 3),
        ],
      ),
    );
  }

  Widget _walletCard() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          width: 330,
          height: 212,
          child: Stack(
            children: [
              Container(
                  decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/card1.png"),
                    fit: BoxFit.cover),
              )),
              Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  '**** **** **** 2345',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, bottom: 25),
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Nombre del usuario',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, bottom: 25, right: 90),
                alignment: Alignment.bottomRight,
                child: Text(
                  '22/30',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Eliminar tarjeta',
              style: TextStyle(
                  color: Color(0xFFD74343),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    );
  }

  Widget suscription() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            width: 330,
            height: 212,
            child: Stack(
              children: [
                Container(
                    decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/suscripcion.png"),
                      fit: BoxFit.cover),
                )),
                Container(
                  margin: EdgeInsets.only(right: 40, bottom: 40),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '5519 1997 1053 4218',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, top: 20),
                  alignment: Alignment.topRight,
                  child: Text(
                    'Fanático',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Eliminar Suscripción',
                style: TextStyle(
                    color: Color(0xFFD74343),
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
