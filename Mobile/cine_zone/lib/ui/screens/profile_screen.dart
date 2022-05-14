import 'package:cine_zone/bloc/profile_bloc/profile_bloc.dart';
import 'package:cine_zone/models/user/user_response.dart';
import 'package:cine_zone/repository/user_repository/user_repository.dart';
import 'package:cine_zone/repository/user_repository/user_repository_impl.dart';
import 'package:cine_zone/ui/screens/config_screen.dart';
import 'package:cine_zone/ui/screens/tickets_screen.dart';
import 'package:cine_zone/ui/screens/wallet_screen.dart';
import 'package:cine_zone/ui/widgets/error_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserRepository userRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userRepository = UserRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProfileBloc(userRepository)..add(ProfileFetchEvent());
      },
      child: Scaffold(body: _createProfileView(context)),
    );
  }

  Widget _createProfileView(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileInitial) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      } else if (state is ProfileFetchError) {
        return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<ProfileBloc>()..add(ProfileFetchEvent());
            });
      } else if (state is ProfileFetchedState) {
        return _body(context, state.userResponse);
      } else {
        return const Text('Not Support');
      }
    });
  }

  Widget _body(BuildContext context, UserResponse userResponse) {
    return SingleChildScrollView(
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
            Container(
              margin: EdgeInsets.only(top: 50),
              child: _formulario(context, userResponse),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: const Divider(
                height: 5,
                color: Colors.grey,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextButton(
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
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40),
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
    );
  }

  Widget _formulario(BuildContext context, UserResponse user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            _infoUsuario("Nombre", user.nombre.toString()),
            _infoUsuario("Email", user.email.toString()),
            _infoUsuario("Telefono", user.telefono.toString()),
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
                  'Editar perfil',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _infoUsuario(String ref, String info) {
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
            width: MediaQuery.of(context).size.width,
            height: 47,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color.fromARGB(0, 243, 243, 243),
                border: Border.all(
                    color: const Color.fromARGB(244, 134, 122, 210), width: 1)),
            margin: const EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: EdgeInsets.only(top: 15, left: 20),
              child: Text(
                info,
                style: TextStyle(
                    fontSize: 13, color: Color.fromARGB(125, 255, 255, 255)),
              ),
            )),
      ],
    );
  }
}
