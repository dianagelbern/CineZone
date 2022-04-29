import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';

class CompraScreen extends StatefulWidget {
  const CompraScreen({Key? key}) : super(key: key);

  @override
  State<CompraScreen> createState() => _CompraScreenState();
}

class _CompraScreenState extends State<CompraScreen> {
  int _stackIndex = 0;

  String _singleValue = "Text alignment right";

  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreTitularController = TextEditingController();
  TextEditingController numTarjetaController = TextEditingController();
  TextEditingController fechaVencimientoController = TextEditingController();
  DateTime? selectedDate;

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
        title: Text('Comprar entrada'),
      ),
      body: SingleChildScrollView(child: cuerpo()),
    );
  }

  Widget cuerpo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Column(
        children: [_resumen(), _formaPago()],
      ),
    );
  }

  Widget _formaPago() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Text(
              'Pagar con',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: ExpansionWidget(
                  initiallyExpanded: true,
                  titleBuilder: (double animationValue, _, bool isExpaned,
                      toogleFunction) {
                    return InkWell(
                        onTap: () => toogleFunction(animated: true),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Text(
                                'Tarjeta asociada',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              )),
                              Transform.rotate(
                                angle: math.pi * animationValue / 1,
                                child: Icon(
                                  Icons.keyboard_arrow_up_outlined,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                alignment: Alignment.center,
                              )
                            ],
                          ),
                        ));
                  },
                  content: Container(
                      child: Column(
                    children: [
                      RadioButton(
                        description: "****42",
                        value: "****42",
                        groupValue: _singleValue,
                        onChanged: (value) => setState(() {
                          _singleValue = value as String;
                          print(value);
                        }),
                        activeColor: Color.fromARGB(255, 134, 122, 210),
                        textStyle: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      RadioButton(
                        description: "****43",
                        value: "****43",
                        groupValue: _singleValue,
                        onChanged: (value) => setState(() {
                          _singleValue = value as String;
                          print(value);
                        }),
                        activeColor: Color.fromARGB(255, 134, 122, 210),
                        textStyle: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      boton_compra()
                    ],
                  )),
                ),
              ),
              ExpansionWidget(
                initiallyExpanded: true,
                titleBuilder:
                    (double animationValue, _, bool isExpaned, toogleFunction) {
                  return InkWell(
                      onTap: () => toogleFunction(animated: true),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text(
                              'Nueva tarjeta',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            )),
                            Transform.rotate(
                              angle: math.pi * animationValue / 1,
                              child: Icon(
                                Icons.keyboard_arrow_up_outlined,
                                size: 30,
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                            )
                          ],
                        ),
                      ));
                },
                content: _formularioTarjeta(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _formularioTarjeta() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nombre del titular',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 47,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color.fromARGB(0, 243, 243, 243),
                    border: Border.all(
                        color: const Color.fromARGB(244, 134, 122, 210),
                        width: 1)),
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: nombreTitularController,
                  decoration: const InputDecoration(
                    labelText: 'Ingresa tu nombre',
                    labelStyle: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(125, 255, 255, 255)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(244, 134, 122, 210))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(244, 134, 122, 210))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                  ),
                  onSaved: (String? value) {},
                  validator: (value) {
                    return (value == null || value.isEmpty)
                        ? 'Write a name'
                        : null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Número de tarjeta',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 47,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color.fromARGB(0, 243, 243, 243),
                    border: Border.all(
                        color: const Color.fromARGB(244, 134, 122, 210),
                        width: 1)),
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: numTarjetaController,
                  decoration: const InputDecoration(
                    labelText: 'Número de tarjeta',
                    labelStyle: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(125, 255, 255, 255)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(244, 134, 122, 210))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(244, 134, 122, 210))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                  ),
                  onSaved: (String? value) {},
                  validator: (value) {
                    return (value == null || value.isEmpty)
                        ? 'Write a name'
                        : null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Fecha de vencimiento',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 20),
                width: 200,
                child: DateTimeField(
                  style: TextStyle(
                      color: Color.fromARGB(226, 255, 255, 255), fontSize: 13),
                  resetIcon: Icon(
                    Icons.close,
                    color: Color.fromARGB(125, 255, 255, 255),
                  ),
                  format: DateFormat("yyyy-MM-dd"),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime.now());
                  },
                  controller: fechaVencimientoController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      prefixIcon: const Icon(
                        Icons.date_range,
                        color: Color.fromARGB(125, 255, 255, 255),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(244, 134, 122, 210))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(244, 134, 122, 210))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                      hintStyle: TextStyle(
                          color: Color.fromARGB(125, 255, 255, 255),
                          fontSize: 13),
                      hintText: selectedDate == null
                          ? 'Fecha de vencimiento'
                          : DateFormat.EEEE(selectedDate).toString()),
                ),
              ),
              boton_compra()
            ],
          )),
    );
  }

  Widget _resumen() {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 47, 44, 68),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        height: 220,
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                          Text('A11',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14))
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
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
            /*
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CinesScreen()),
                        );
                        */
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
