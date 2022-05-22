import 'package:cine_zone/ui/screens/cines_screen.dart';
import 'package:cine_zone/ui/screens/peliculas_screen.dart';
import 'package:cine_zone/ui/screens/perfil_screen.dart';
import 'package:cine_zone/ui/screens/usuarios_screen.dart';
import 'package:cine_zone/ui/widgets/custom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    PeliculasScreen(),
    CinesScreen(),
    UsuariosScreen(),
    PerfilScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Drawer(
          backgroundColor: Color(0xFF2F2C44),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 150,
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.movie_creation),
                            selectedColor: Colors.white,
                            textColor: Color(0xFF867AD2),
                            iconColor: Color(0xFF867AD2),
                            title: Text('Películas'),
                            selected: _selectedIndex == 0,
                            onTap: () => _onItemTapped(0),
                          ),
                          ListTile(
                            leading: Icon(Icons.business_rounded),
                            selectedColor: Colors.white,
                            textColor: Color(0xFF867AD2),
                            iconColor: Color(0xFF867AD2),
                            title: Text('Cines'),
                            selected: _selectedIndex == 1,
                            onTap: () => _onItemTapped(1),
                          ),
                          ListTile(
                            leading: Icon(Icons.people_outline_outlined),
                            selectedColor: Colors.white,
                            textColor: Color(0xFF867AD2),
                            iconColor: Color(0xFF867AD2),
                            title: Text('Usuarios'),
                            selected: _selectedIndex == 2,
                            onTap: () => _onItemTapped(2),
                          ),
                          ListTile(
                            leading: Icon(Icons.person_outline),
                            selectedColor: Colors.white,
                            textColor: Color(0xFF867AD2),
                            iconColor: Color(0xFF867AD2),
                            title: Text('Perfil'),
                            selected: _selectedIndex == 3,
                            onTap: () => _onItemTapped(3),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Configuración",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Scaffold(
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ),
      ],
    );
  }
}
