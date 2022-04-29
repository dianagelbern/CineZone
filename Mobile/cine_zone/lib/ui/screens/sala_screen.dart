import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Container();
  }

  Widget screen() {
    return Container();
  }
}
