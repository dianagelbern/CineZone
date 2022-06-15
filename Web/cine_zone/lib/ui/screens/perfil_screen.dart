import 'package:cine_zone/bloc/bloc/create_user_admin_bloc.dart';
import 'package:cine_zone/bloc/edit_user_bloc/edit_user_bloc.dart';
import 'package:cine_zone/bloc/profile_bloc/profile_bloc.dart';
import 'package:cine_zone/models/user/new_user_dto.dart';
import 'package:cine_zone/models/user/user_admin_dto.dart';
import 'package:cine_zone/models/user/user_response.dart';
import 'package:cine_zone/repository/user_repository/user_repository.dart';
import 'package:cine_zone/repository/user_repository/user_repository_impl.dart';
import 'package:cine_zone/ui/screens/menu_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({Key? key}) : super(key: key);

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  bool _visible = false;
  bool _visible2 = false;
  late UserRepository userRepository;
  late ProfileBloc _profileBloc;
  late EditUserBloc _editUserBloc;
  DateTime? selectedDate;

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController nacimientoController = TextEditingController();

  TextEditingController emailNewUserController = TextEditingController();
  TextEditingController nombreNewUserController = TextEditingController();
  TextEditingController telefonoNewUserController = TextEditingController();
  TextEditingController nacimientoNewUserController = TextEditingController();
  TextEditingController password1NewUserController = TextEditingController();
  TextEditingController password2NewUserController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userRepository = UserRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ProfileBloc(userRepository)..add(ProfileFetchEvent());
            },
          ),
          BlocProvider(create: (context) {
            return EditUserBloc(userRepository);
          }),
          BlocProvider(create: (context) {
            return CreateUserAdminBloc(userRepository);
          })
        ],
        child: Scaffold(
          body: SingleChildScrollView(child: _createProfileView(context)),
        ));
  }

  Widget _createProfileView(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileInitial) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      } else if (state is ProfileFetchError) {
        return Center(
          child: Column(
            children: [
              Container(
                width: 500,
                child: Image.asset('assets/images/error.png'),
              ),
              Text(
                "Oops.. " + state.message,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        );
      } else if (state is ProfileFetchedState) {
        return _perfil(context, state.userResponse);
      } else {
        return const Text('Not Support');
      }
    });
  }

  Widget _updateProfile(BuildContext context, UserResponse user) {
    return BlocConsumer<EditUserBloc, EditUserState>(
      listenWhen: (context, state) {
        return state is EditUserSuccesState || state is EditUserErrorState;
      },
      listener: (context, state) {
        if (state is EditUserSuccesState) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MenuScreen()));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("El perfil se modificó correctamente",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800)),
              backgroundColor: Color(0xFF867AD2),
            ),
          );
        } else if (state is EditUserErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Algo salió mal, vuelve a intentarlo")),
          );
        }
      },
      builder: (context, state) {
        if (state is EditUserInitial) {
          return _botonEdit(context, user);
        } else {
          return _botonEdit(context, user);
        }
      },
      buildWhen: (context, state) {
        return state is EditUserInitial || state is EditUserErrorState;
      },
    );
  }

  Widget _newUserAdmin(BuildContext context) {
    return BlocConsumer<CreateUserAdminBloc, CreateUserAdminState>(
        listenWhen: (context, state) {
      return state is CreateUserAdminSuccesState ||
          state is CreateUserAdminErrorState;
    }, listener: (context, state) {
      if (state is CreateUserAdminState) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MenuScreen()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Se añadió un usuario administrador de forma correcta",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800)),
            backgroundColor: Color(0xFF867AD2),
          ),
        );
      } else if (state is CreateUserAdminErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Algo salió mal, vuelve a intentarlo")),
        );
      }
    }, builder: (context, state) {
      return _boton(context);
    }, buildWhen: (context, state) {
      return state is CreateUserAdminInitial &&
          state is CreateUserAdminSuccesState;
    });
  }

  Widget _botonEdit(BuildContext context, UserResponse user) {
    return TextButton(
      onPressed: () {
        final editProfile = NewUserDto(
            nombre: nombreController.text.isEmpty
                ? user.nombre!
                : nombreController.text,
            telefono: telefonoController.text.isEmpty
                ? user.telefono!
                : telefonoController.text,
            email: user.email!,
            fechaNacimiento: user.fechaNacimiento!);
        BlocProvider.of<EditUserBloc>(context).add(DoEditUser(editProfile));
        print(editProfile.toJson().toString());
      },
      child: const Text(
        'Editar perfil',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget _formulario(BuildContext context, UserResponse user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            _infoUsuario("Nombre", user.nombre.toString(), nombreController),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  alignment: Alignment.bottomLeft,
                  child: Text("Email",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 47,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(0, 243, 243, 243),
                        border: Border.all(
                            color: const Color.fromARGB(244, 134, 122, 210),
                            width: 1)),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, left: 20),
                      child: Text(
                        user.email!,
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(73, 255, 255, 255)),
                      ),
                    ))
              ],
            ),
            _infoUsuario(
                "Telefono", user.telefono.toString(), telefonoController),
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
                child: _updateProfile(context, user)),
          ],
        ),
      ],
    );
  }

  Widget _infoUsuario(
      String ref, String info, TextEditingController controlador) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          alignment: Alignment.bottomLeft,
          child: Text(ref,
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
                  color: const Color.fromARGB(244, 134, 122, 210), width: 1)),
          margin: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: controlador,
            decoration: InputDecoration(
              hintText: info,
              hintStyle: TextStyle(
                  fontSize: 13, color: Color.fromARGB(214, 255, 255, 255)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(244, 134, 122, 210))),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(244, 134, 122, 210))),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
            ),
            onSaved: (String? value) {},
            validator: (value) {
              return (value == null || value.isEmpty) ? 'Write a $ref' : null;
            },
          ),
        ),
      ],
    );
  }

  Widget _perfil(BuildContext context, UserResponse user) {
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 150),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 30, left: 370),
                  child: _newUserAdmin(context),
                ),
                Center(
                  child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xFF2F2C44),
                      ),
                      width: 600,
                      height: 500,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: _formulario(context, user),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _boton(BuildContext ctx) {
    return Container(
      margin: EdgeInsets.only(left: 60),
      width: 161,
      height: 47,
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
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  backgroundColor: Color(0xFF2F2C44),
                  title: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Añadir usuario administrador',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  content: Container(
                    alignment: Alignment.center,
                    width: 310,
                    height: 750,
                    child: Column(
                      children: [
                        _formCreateUser(context),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          width: 300,
                          height: 47,
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
                              final createAdmin = UserAdminDto(
                                  password: password1NewUserController.text,
                                  password2: password2NewUserController.text,
                                  nombre: nombreNewUserController.text,
                                  telefono: telefonoNewUserController.text,
                                  email: emailNewUserController.text,
                                  fechaNacimiento:
                                      nacimientoNewUserController.text);
                              BlocProvider.of<CreateUserAdminBloc>(ctx)
                                  .add(CreateUserAdmin(createAdmin));
                              print(createAdmin.toJson().toString());
                            },
                            child: Text(
                              'Añadir usuario',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ));
            }),
        child: Text(
          'Añadir usuario',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _formCreateUser(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Column(
            children: [
              _infoUser("Nombre", "Nombre del administrador",
                  nombreNewUserController, 300),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text("Número de teléfono",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    height: 47,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(0, 243, 243, 243),
                        border: Border.all(
                            color: const Color.fromARGB(244, 134, 122, 210),
                            width: 1)),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: telefonoNewUserController,
                      decoration: InputDecoration(
                        hintText: "Número de teléfono",
                        hintStyle: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(214, 255, 255, 255)),
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
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(9),
                      ],
                      onSaved: (String? value) {},
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Escribe un número de teléfono'
                            : null;
                      },
                    ),
                  ),
                ],
              ),
              _infoUser("Email", "Email", emailNewUserController, 300),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text("Fecha",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 20),
                    width: 200,
                    child: DateTimeField(
                      style: const TextStyle(
                          color: Color.fromARGB(226, 255, 255, 255),
                          fontSize: 13),
                      resetIcon: const Icon(
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
                      controller: nacimientoNewUserController,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                          prefixIcon: const Icon(
                            Icons.date_range,
                            color: Color.fromARGB(125, 255, 255, 255),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(244, 134, 122, 210))),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(244, 134, 122, 210))),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(125, 255, 255, 255),
                              fontSize: 13),
                          hintText: selectedDate == null
                              ? 'Fecha de nacimiento'
                              : DateFormat.EEEE(selectedDate).toString()),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text("Contraseña",
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
                      controller: password1NewUserController,
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
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text("Contraseña",
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
                      controller: password2NewUserController,
                      obscureText: !_visible2,
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
                        labelText: 'Repetir contraseña',
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoUser(
      String ref, String info, TextEditingController controlador, double size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          alignment: Alignment.bottomLeft,
          child: Text(ref,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
        ),
        Container(
          height: 47,
          width: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromARGB(0, 243, 243, 243),
              border: Border.all(
                  color: const Color.fromARGB(244, 134, 122, 210), width: 1)),
          margin: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: controlador,
            decoration: InputDecoration(
              hintText: info,
              hintStyle: TextStyle(
                  fontSize: 13, color: Color.fromARGB(214, 255, 255, 255)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(244, 134, 122, 210))),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(244, 134, 122, 210))),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
            ),
            onSaved: (String? value) {},
            validator: (value) {
              return (value == null || value.isEmpty) ? 'Write a $ref' : null;
            },
          ),
        ),
      ],
    );
  }
}
