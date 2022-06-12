import 'package:cine_zone/bloc/get_users_bloc/get_users_bloc.dart';
import 'package:cine_zone/models/user/users_response.dart';
import 'package:cine_zone/repository/user_repository/user_repository.dart';
import 'package:cine_zone/repository/user_repository/user_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({Key? key}) : super(key: key);

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  late UserRepository userRepository;
  late GetUsersBloc getUsersBloc;
  int page = 0;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userRepository = UserRepositoryImpl();

    getUsersBloc = GetUsersBloc(userRepository)
      ..add(DoGetUsersEvent(page.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getUsersBloc,
      child: Scaffold(
          body: Column(
        children: [
          _opciones(),
          _blocBuilderUsers(context),

          //
        ],
      )),
    );
  }

  _blocBuilderUsers(BuildContext buildContext) {
    return BlocBuilder<GetUsersBloc, GetUsersState>(
      builder: (context, state) {
        if (state is GetUsersInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetUsersErrorState) {
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
        } else if (state is GetUsersSuccessState) {
          return Container(
            width: 1030,
            height: 580,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    children: [
                      _modelTableHead("ID"),
                      _modelTableHead("Nombre"),
                      _modelTableHead("Email"),
                      _modelTableHead("Teléfono"),
                      _modelTableHead("FechaNacimiento"),
                      _modelTableHead("Más"),
                    ],
                  ),
                ),
                _movieList(context, state.userList),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.grey,
                          )),
                      IconButton(
                          onPressed: () {
                            /*
                            setState(() {
                              page = page + 1;
                            });
                            BlocProvider.of<GetMoviesBloc>(context)
                                .add(DoGetMoviesEvent(page.toString()));
                            print(page);
                            */
                          },
                          icon: Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.grey))
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Text("Algo salió mal");
        }
      },
    );
  }

  Widget _movieList(BuildContext context, List<User> users) {
    return Flexible(
      child: Container(
          child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _movieItem(context, users.elementAt(index));
        },
        itemCount: users.length,
      )),
    );
  }

  Widget _movieItem(BuildContext context, User user) {
    return GestureDetector(
      onTap: () {
        print(user.id);
      },
      child: Row(
        children: [
          _modelTable(user.id.toString()),
          _modelTable(user.nombre),
          _modelTable(user.email),
          _modelTable(user.telefono),
          _modelTable(user.fechaNacimiento),
          Container(
            width: 150,
            margin: EdgeInsets.only(left: 20),
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: Color.fromARGB(255, 107, 97, 175),
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _modelTable(String dato) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      width: 150,
      alignment: Alignment.center,
      child: Text(dato),
    );
  }

  Widget _modelTableHead(String dato) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      width: 150,
      alignment: Alignment.center,
      child: Text(
        dato,
        style: TextStyle(fontWeight: FontWeight.w800),
      ),
    );
  }

  Widget _opciones() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 50),
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Text(
              "Usuarios",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          Container(
            child: Row(
              children: [_search(), _boton()],
            ),
          )
        ],
      ),
    );
  }

  Widget _search() {
    return Container(
      height: 47,
      width: 368,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFF2F2C44),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: searchController,
        decoration: const InputDecoration(
          hintText: 'Buscar usuario',
          hintStyle: TextStyle(
              fontSize: 13, color: Color.fromARGB(125, 255, 255, 255)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromARGB(244, 134, 122, 210))),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
          prefixIcon: Icon(
            Icons.search,
            color: Color.fromARGB(55, 255, 255, 255),
          ),
        ),
        onSaved: (String? value) {},
        validator: (value) {
          return (value == null || value.isEmpty)
              ? 'Escribe el nombre del usuario'
              : null;
        },
      ),
    );
  }

  Widget _boton() {
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
        onPressed: () {},
        child: Text(
          'Añadir usuario',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
