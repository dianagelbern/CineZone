import 'dart:html';

import 'package:cine_zone/bloc/login_bloc/login_bloc.dart';
import 'package:cine_zone/models/auth/login_dto.dart';
import 'package:cine_zone/repository/auth_repository/auth_repository.dart';
import 'package:cine_zone/repository/auth_repository/auth_repository_impl.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/shared.dart';
import 'package:cine_zone/ui/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _visible = false;
  late AuthRepository authRepository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginBloc(authRepository);
      },
      child: Scaffold(
        body: SingleChildScrollView(child: _body()),
      ),
    );
  }

  Widget _body() {
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
          Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 330,
                    height: 50,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 100),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xFF2F2C44),
                  ),
                  width: 600,
                  height: 500,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      _doLogin()
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _doLogin() {
    return BlocConsumer<LoginBloc, LoginState>(listenWhen: (context, state) {
      return state is LoginSuccessState || state is LoginErrorState;
    }, listener: (context, state) {
      if (state is LoginSuccessState) {
        //print(state.loginResponse.token);
        //Shared.setToken(state.loginResponse.token);

        window.localStorage
            .addAll({Constant.bearerToken: state.loginResponse.token});
        /*
        window.localStorage.clear();
        */

        /*    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MenuScreen()),
        ); */

        Navigator.pushNamed(context, '/menu');
      } else if (state is LoginErrorState) {
        _showSnackbar(context, state.message);
      }
    }, buildWhen: (context, state) {
      return state is LoginInitialState || state is LoginLoadingState;
    }, builder: (ctx, state) {
      if (state is LoginInitialState) {
        return _formulario(ctx);
      } else if (state is LoginLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return _formulario(ctx);
      }
    });
  }

  Widget _formulario(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text("Email:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    height: 47,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromARGB(0, 243, 243, 243),
                        border: Border.all(
                            color: Color.fromARGB(244, 134, 122, 210),
                            width: 1)),
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
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
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text("Contraseña:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    height: 47,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromARGB(0, 243, 243, 243),
                        border: Border.all(
                            color: Color.fromARGB(244, 134, 122, 210),
                            width: 1)),
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: passwordController,
                      obscureText: !_visible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            splashRadius: 5.0,
                            icon: Icon(
                              _visible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _visible = !_visible;
                              });
                            }),
                        labelText: 'Ingresa tu contraseña',
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
                            ? 'Write a password'
                            : null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: 350,
              height: 50,
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final loginDto = LoginDto(
                        email: emailController.text,
                        password: passwordController.text);
                    BlocProvider.of<LoginBloc>(context)
                        .add(DoLoginEvent(loginDto));
                  }
                },
                child: Text(
                  'Acceder',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
