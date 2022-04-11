import 'package:cine_zone/ui/screens/config_screen.dart';
import 'package:cine_zone/ui/screens/tickets_screen.dart';
import 'package:cine_zone/ui/screens/wallet_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 65),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Perfil',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConfigScreen()),
                      );
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    label: const Text(''),
                  )
                ],
              ),
              Stack(children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF867AD2)),
                    width: 40,
                    height: 40,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              ]),
              Container(
                child: _formulario(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: const Divider(
                  height: 5,
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WalletScreen()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/wallet.svg',
                                  height: 25,
                                  color: Colors.white,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 30),
                                  child: const Text(
                                    'Wallet',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
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
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TicketsScreen()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/ticket.svg',
                                    height: 25,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 30),
                                    child: const Text(
                                      'Tickets',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
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
                    )
                  ],
                ),
              )
              /*otros */
            ],
          ),
        ),
      ),
    );
  }

  Widget _formulario() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.bottomLeft,
                child: const Text("Nombre:",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
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
                  controller: nombreController,
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
            ],
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.bottomLeft,
                child: const Text("Email:",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ),
              Container(
                height: 47,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color.fromARGB(0, 243, 243, 243),
                    border: Border.all(
                        color: Color.fromARGB(244, 134, 122, 210), width: 1)),
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'ejemplo@gmail.com',
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
                  validator: (String? value) {
                    return (value == null || !value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.bottomLeft,
                child: const Text("Teléfono:",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
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
                  controller: telefonoController,
                  decoration: const InputDecoration(
                    labelText: 'Ingresa tu teléfono',
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
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            width: 350,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(244, 134, 122, 210),
                  Color.fromARGB(255, 107, 97, 175)
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
              ),
            ),
            child: TextButton(
              onPressed: () {
                /*
                if (_formKey.currentState!.validate()) {
                  final loginDto = LoginDto(
                      email: emailController.text,
                      password: passwordController.text);
                  BlocProvider.of<LoginBloc>(context)
                      .add(DoLoginEvent(loginDto));
                } */
              },
              child: const Text(
                'Guardar cambios',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
