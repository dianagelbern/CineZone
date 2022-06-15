import 'package:cine_zone/bloc/image_pick_bloc/image_bloc.dart';
import 'package:cine_zone/bloc/register_bloc/register_bloc.dart';
import 'package:cine_zone/models/user/user_dto.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/shared.dart';
import 'package:cine_zone/repository/user_repository/user_repository.dart';
import 'package:cine_zone/repository/user_repository/user_repository_impl.dart';
import 'package:cine_zone/ui/screens/login_screen.dart';
import 'package:cine_zone/ui/screens/menu_screen.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _visible = false;
  bool _visible2 = false;
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController nacimientoController = TextEditingController();

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  String? path = '';

  late UserRepository userRepository;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    userRepository = UserRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return RegisterBloc(userRepository);
        },
        child: Scaffold(
          body: _content(context),
        ));
  }

  void _showError(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _content(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
        listenWhen: (context, state) {
      return state is RegisterSuccesState || state is RegisterErrorState;
    }, listener: (context, state) {
      if (state is RegisterSuccesState) {
        Shared.setString(Constant.bearerToken, state.userResponse.token);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MenuScreen()),
        );
      } else if (state is RegisterErrorState) {
        _showError(context, state.message);
      }
    }, buildWhen: (context, state) {
      return state is RegisterInitial;
    }, builder: (context, state) {
      if (state is RegisterInitial) {
        return _body(context);
      } else {
        return _body(context);
      }
    });
  }

  Widget _body(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _fondo(),
          SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 65,
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Registro",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 40, left: 60),
                        child: SvgPicture.asset('assets/images/logo.svg')),
                    _formulario(context),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          child: Text.rich(TextSpan(
                              text: '¿Ya tienes cuenta? ',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(178, 255, 255, 255)),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Inicia sesión',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                )
                              ])),
                        ))
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget _fondo() {
    return Positioned(
      top: 0,
      right: 0,
      child: Image.asset(
        'assets/images/fondo_login.png',
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _formulario(BuildContext context) {
    return Container(
        height: 510,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Theme(
                  data: ThemeData(
                      canvasColor: Colors.transparent,
                      colorScheme: ColorScheme.light(
                          primary: Color.fromARGB(255, 134, 122, 210))),
                  child: Stepper(
                    type: StepperType.horizontal,
                    physics: const ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: continued,
                    elevation: 0.0,
                    onStepCancel: cancel,
                    controlsBuilder:
                        (BuildContext context, ControlsDetails details) {
                      return Row(
                        children: <Widget>[
                          _currentStep < 2
                              ? Container(
                                  width: 102,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(244, 134, 122, 210),
                                        Color.fromARGB(255, 107, 97, 175)
                                      ],
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                    ),
                                  ),
                                  child: TextButton(
                                    onPressed: details.onStepContinue,
                                    child: Text(
                                      'CONTINUAR',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 102,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    gradient: LinearGradient(
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
                                        final userDto = UserDto(
                                            nombre: nombreController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            password2: password2Controller.text,
                                            telefono: telefonoController.text,
                                            fechaNacimiento:
                                                nacimientoController.text);
                                        debugPrint(userDto.toJson().toString());
                                        BlocProvider.of<RegisterBloc>(context)
                                            .add(CreateRegister(userDto));
                                      }
                                    },
                                    child: Text(
                                      'ENVIAR',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ),
                          Container(
                            margin: EdgeInsets.only(left: 40),
                            child: TextButton(
                                onPressed: details.onStepCancel,
                                child: Text(
                                  'CANCELAR',
                                  style: TextStyle(
                                      color: Color.fromARGB(225, 215, 67, 67)),
                                )),
                          )
                        ],
                      );
                    },
                    steps: <Step>[
                      Step(
                        title: new Text(
                          '',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Container(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    alignment: Alignment.bottomLeft,
                                    child: Text("Nombre:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Container(
                                    height: 47,
                                    decoration: new BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Color.fromARGB(0, 243, 243, 243),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                244, 134, 122, 210),
                                            width: 1)),
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      controller: nombreController,
                                      decoration: const InputDecoration(
                                        labelText: 'Ingresa tu nombre completo',
                                        labelStyle: TextStyle(
                                            fontSize: 13,
                                            color: Color.fromARGB(
                                                125, 255, 255, 255)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    244, 134, 122, 210))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    244, 134, 122, 210))),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                      ),
                                      onSaved: (String? value) {},
                                      validator: (value) {
                                        return (value == null || value.isEmpty)
                                            ? 'Escribe tu nombre'
                                            : null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep == 1
                            ? StepState.editing
                            : _currentStep > 1
                                ? StepState.complete
                                : StepState.indexed,
                      ),
                      Step(
                        title: new Text(
                          '',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Column(
                          children: [
                            Container(
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Color.fromARGB(0, 243, 243, 243),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                244, 134, 122, 210),
                                            width: 1)),
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                        labelText: 'Ingresa tu email',
                                        labelStyle: TextStyle(
                                            fontSize: 13,
                                            color: Color.fromARGB(
                                                125, 255, 255, 255)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    244, 134, 122, 210))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    244, 134, 122, 210))),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                      ),
                                      onSaved: (String? value) {},
                                      validator: (String? value) {
                                        return (value == null || value.isEmpty)
                                            ? 'Escribe tu correo electrónico'
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
                                    child: Text("Contaseña:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Container(
                                    height: 47,
                                    decoration: new BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Color.fromARGB(0, 243, 243, 243),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                244, 134, 122, 210),
                                            width: 1)),
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      obscureText: !_visible,
                                      style: TextStyle(color: Colors.white),
                                      controller: passwordController,
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
                                            color: Color.fromARGB(
                                                125, 255, 255, 255)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    244, 134, 122, 210))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    244, 134, 122, 210))),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                      ),
                                      onSaved: (String? value) {},
                                      validator: (value) {
                                        return (value == null || value.isEmpty)
                                            ? 'Escribe tu contraseña'
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
                                    child: Text("Repetir contraseña:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Container(
                                    height: 47,
                                    decoration: new BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Color.fromARGB(0, 243, 243, 243),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                244, 134, 122, 210),
                                            width: 1)),
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      obscureText: !_visible2,
                                      style: TextStyle(color: Colors.white),
                                      controller: password2Controller,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            splashRadius: 5.0,
                                            icon: Icon(
                                              _visible2
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _visible2 = !_visible2;
                                              });
                                            }),
                                        labelText: 'Ingresa tu contraseña',
                                        labelStyle: TextStyle(
                                            fontSize: 13,
                                            color: Color.fromARGB(
                                                125, 255, 255, 255)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    244, 134, 122, 210))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    244, 134, 122, 210))),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                      ),
                                      onSaved: (String? value) {},
                                      validator: (value) {
                                        return (value == null || value.isEmpty)
                                            ? 'Escribe tu contraseña'
                                            : null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep == 0
                            ? StepState.editing
                            : _currentStep > 0
                                ? StepState.complete
                                : StepState.indexed,
                      ),
                      Step(
                        title: new Text(
                          '',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Column(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    alignment: Alignment.bottomLeft,
                                    child: Text("Teléfono:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Container(
                                    height: 47,
                                    decoration: new BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Color.fromARGB(0, 243, 243, 243),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                244, 134, 122, 210),
                                            width: 1)),
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                        style: TextStyle(color: Colors.white),
                                        controller: telefonoController,
                                        decoration: const InputDecoration(
                                          labelText:
                                              'Ingresa tu número de teléfono',
                                          labelStyle: TextStyle(
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  125, 255, 255, 255)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      244, 134, 122, 210))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      244, 134, 122, 210))),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                        ),
                                        onSaved: (String? value) {},
                                        validator: (value) {
                                          return (value == null ||
                                                  value.isEmpty)
                                              ? 'Escribe tu número de teléfono'
                                              : null;
                                        },
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]')),
                                          LengthLimitingTextInputFormatter(9),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              alignment: Alignment.bottomLeft,
                              child: Text("Fecha de nacimiento:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: DateTimeField(
                                style: TextStyle(
                                    color: Color.fromARGB(226, 255, 255, 255),
                                    fontSize: 13),
                                resetIcon: Icon(
                                  Icons.close,
                                  color: Color.fromARGB(125, 255, 255, 255),
                                ),
                                format: DateFormat("yyyy-MM-dd"),
                                onShowPicker: (context, currentValue) {
                                  return showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime.now());
                                },
                                controller: nacimientoController,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                    prefixIcon: const Icon(
                                      Icons.date_range,
                                      color: Color.fromARGB(125, 255, 255, 255),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                244, 134, 122, 210))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                244, 134, 122, 210))),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    )),
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(125, 255, 255, 255),
                                        fontSize: 13),
                                    hintText: selectedDate == null
                                        ? 'Fecha de nacimiento'
                                        : DateFormat.EEEE(selectedDate)
                                            .toString()),
                              ),
                            )
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep == 2
                            ? StepState.editing
                            : _currentStep > 2
                                ? StepState.complete
                                : StepState.indexed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
