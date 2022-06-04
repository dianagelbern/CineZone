import 'package:cine_zone/ui/screens/home_screen.dart';
import 'package:cine_zone/ui/screens/sala_screen.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/extra/dimen.dart';
import 'package:expandable/expandable.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expandable/expandable.dart';
import 'dart:math' as math;

class CinesScreen extends StatefulWidget {
  const CinesScreen({Key? key}) : super(key: key);

  @override
  State<CinesScreen> createState() => _CinesScreenState();
}

class _CinesScreenState extends State<CinesScreen> {
  DatePickerController _controller = DatePickerController();
  TextEditingController cinesController = TextEditingController();
  bool _expanded = false;
  var _test = "Full Screen";

  DateTime _selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F2C44),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        leadingWidth: 100,
        title: const Text('Nombre de la película'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: datePicker(),
          ),
          const Divider(color: Colors.grey, height: 3),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [_search(), cineItem()],
            ),
          )
        ],
      ),
    );
  }

  Widget cineItem() {
    return ExpansionWidget(
      initiallyExpanded: true,
      titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
        return InkWell(
            onTap: () => toogleFunction(animated: true),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                      child: Text(
                    'Cine Zona',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )),
                  Transform.rotate(
                    angle: math.pi * animationValue / 1,
                    child: const Icon(
                      Icons.keyboard_arrow_down_outlined,
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
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(85, 255, 255, 255)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [_typeFormat()],
          )),
    );
  }

  Widget _typeFormat() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: const Text(
            'Regular',
            style: TextStyle(
                color: Color.fromARGB(122, 255, 255, 255), fontSize: 14),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [_buttonTime(), _buttonTime(), _buttonTime()],
          ),
        )
      ],
    );
  }

  Widget _buttonTime() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFF6C61AF),
      ),
      width: 75,
      height: 29,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SalaScreen()),
          );
        },
        child: const Text(
          '16:00',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _search() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 47,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xFF2F2C44),
            border: Border.all(color: const Color(0xFF2F2C44), width: 1)),
        margin: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: cinesController,
          decoration: const InputDecoration(
            labelText: 'Buscar Cine',
            prefixIcon: Icon(
              Icons.search,
              color: Color.fromARGB(115, 255, 255, 255),
            ),
            labelStyle: TextStyle(
                fontSize: 14, color: Color.fromARGB(125, 255, 255, 255)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2F2C44))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2F2C44))),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
          ),
          onSaved: (String? value) {},
        ),
      ),
    );
  }

  Widget datePicker() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: DatePicker(
        DateTime.now(),
        dateTextStyle: const TextStyle(
            color: Color.fromARGB(125, 255, 255, 255), fontSize: 12),
        monthTextStyle: const TextStyle(
            color: Color.fromARGB(125, 255, 255, 255), fontSize: 12),
        dayTextStyle: const TextStyle(
            color: Color.fromARGB(125, 255, 255, 255), fontSize: 12),
        width: 60,
        height: 80,
        daysCount: 9,
        controller: _controller,
        initialSelectedDate: DateTime.now(),
        selectionColor: const Color(0xFF2F2C44),
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          setState(() {
            _selectedValue = date;
            print(date.day);
            print(date.month);
          });
        },
      ),
    );
  }

  /*
  Con este se ve el dia que se pica 

  Widget _datePicker() {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.blueGrey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("You Selected:"),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Text(_selectedValue.toString()),
          Padding(
            padding: EdgeInsets.all(20),
          ),
          Container(
            child: DatePicker(
              DateTime.now(),
              width: 60,
              height: 80,
              controller: _controller,
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,
              inactiveDates: [
                DateTime.now().add(Duration(days: 3)),
                DateTime.now().add(Duration(days: 4)),
                DateTime.now().add(Duration(days: 7))
              ],
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedValue = date;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
  */
}
