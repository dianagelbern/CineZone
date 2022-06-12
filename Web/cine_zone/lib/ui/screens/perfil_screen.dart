import 'package:cine_zone/bloc/edit_user_bloc/edit_user_bloc.dart';
import 'package:cine_zone/bloc/profile_bloc/profile_bloc.dart';
import 'package:cine_zone/models/user/new_user_dto.dart';
import 'package:cine_zone/models/user/user_response.dart';
import 'package:cine_zone/repository/user_repository/user_repository.dart';
import 'package:cine_zone/repository/user_repository/user_repository_impl.dart';
import 'package:cine_zone/ui/screens/menu_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({Key? key}) : super(key: key);

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  late UserRepository userRepository;
  late ProfileBloc _profileBloc;
  late EditUserBloc _editUserBloc;

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController nacimientoController = TextEditingController();

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
                _boton(),
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

  Widget _boton() {
    return Container(
      margin: EdgeInsets.only(left: 430, bottom: 40),
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
        onPressed: () {},
        child: Text(
          'Añadir admin',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
