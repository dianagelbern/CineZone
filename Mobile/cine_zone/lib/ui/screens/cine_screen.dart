import 'package:cine_zone/ui/screens/menu_screen.dart';
import 'package:cine_zone/ui/screens/sala_screen.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CineScreen extends StatefulWidget {
  const CineScreen({Key? key}) : super(key: key);

  @override
  State<CineScreen> createState() => _CineScreenState();
}

class _CineScreenState extends State<CineScreen> {
  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();

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
          title: const Text('Cine elegido'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              datePicker(),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: const Divider(
                      color: Color.fromARGB(158, 158, 158, 158), height: 5)),
              _type()
            ],
          ),
        ));
  }

  Widget _type() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 20, top: 10),
            child: const Text(
              'Regular',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w700),
            )),
        _movieItem()
      ],
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

  Widget _movieItem() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 117,
          height: 167,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://pics.filmaffinity.com/Star_Wars_Los_ltimos_Jedi-535293064-large.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  'Star Wars: The Last Jedi',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text('P-G 13+',
                    style: TextStyle(
                      color: Color.fromARGB(104, 255, 255, 255),
                      fontSize: 12,
                    )),
              ),
              Container(
                child: Row(
                  children: [_buttonTime(), _buttonTime()],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget _buttonTime() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFF6C61AF),
      ),
      width: 50,
      height: 30,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SalaScreen()),
          );
        },
        child: const Text(
          '16:00',
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }
}
