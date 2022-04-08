import 'dart:io';
import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:cine_zone/ui/screens/menu_screen.dart';
import 'package:flutter/material.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
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
        title: Text('Tickets'),
      ),
      body: _ticketCard(),
    );
  }

  Widget _ticketCard() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text('Fecha y hora: ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text('12/03/22',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text('13:30',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: BarcodeWidget(
              barcode: Barcode.code128(), // Barcode type and settings
              data: '384958592011938549505694405660',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              color: Colors.white, // Content
              width: 380,
              height: 80,
            ),
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text('Sala: Sala 4',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14)),
                    ),
                    Text('Te Batman',
                        style: TextStyle(color: Colors.white, fontSize: 13))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text('Butaca: Fila 9, Butaca 10',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14))),
                    Container(
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 70),
                              child: Text('VOSE',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13))),
                          Text('Digital',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.centerLeft,
              child: Text('Cine: CineSur Nervión',
                  style: TextStyle(color: Colors.white, fontSize: 13)))
        ],
      ),
    );
  }
}
