import 'package:cine_zone/bloc/get_shows_from_sala_bloc/get_shows_from_sala_bloc.dart';
import 'package:cine_zone/models/show/show_by_sala_response.dart';
import 'package:cine_zone/repository/show_repository/show_repository.dart';
import 'package:cine_zone/repository/show_repository/show_repository_impl.dart';
import 'package:cine_zone/ui/screens/menu_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowsScreen extends StatefulWidget {
  ShowsScreen({Key? key, required this.salaId}) : super(key: key);

  String salaId;
  @override
  State<ShowsScreen> createState() => _ShowsScreenState();
}

class _ShowsScreenState extends State<ShowsScreen> {
  late ShowRepository showRepository;
  late GetShowsFromSalaBloc getShowsFromSalaBloc;
  int page = 0;
  TextEditingController searchController = TextEditingController();
  String fecha = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showRepository = ShowRepositoryImpl();
    getShowsFromSalaBloc = GetShowsFromSalaBloc(showRepository)
      ..add(DoGetShowsFromSalaEvent(page.toString(), widget.salaId, fecha));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getShowsFromSalaBloc,
      child: Scaffold(
          body: Column(
        children: [
          _opciones(),
          _blocBuilderShow(context),

          //
        ],
      )),
    );
  }

  _blocBuilderShow(BuildContext buildContext) {
    return BlocBuilder<GetShowsFromSalaBloc, GetShowsFromSalaState>(
      builder: (context, state) {
        if (state is GetShowsFromSalaInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetShowsFromSalaErrorState) {
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
        } else if (state is GetShowsFromSalaSuccessState) {
          return Container(
            width: 1070,
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
                      _modelTableHead("Nombre de la película"),
                      _modelTableHead("Hora de emisión"),
                      _modelTableHead("Nombre de la sala"),
                      _modelTableHead("Nombre del cine"),
                      _modelTableHead("Formato"),
                      _modelTableHead("Más"),
                    ],
                  ),
                ),
                _showList(context, state.showsList),
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

  Widget _showList(BuildContext context, List<Show> shows) {
    return Flexible(
      child: Container(
          child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _ShowItem(context, shows.elementAt(index));
        },
        itemCount: shows.length,
      )),
    );
  }

  Widget _ShowItem(BuildContext context, Show show) {
    return GestureDetector(
      onTap: () {
        print(show.id);
      },
      child: Row(
        children: [
          _modelTable(show.id.toString()),
          _modelTable(show.movieTitulo),
          _modelTable(show.hora),
          _modelTable(show.salaNombre),
          _modelTable(show.nombreCine),
          _modelTable(show.formato),
          Container(
            width: 150,
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
      width: 150,
      alignment: Alignment.center,
      child: Text(dato),
    );
  }

  Widget _modelTableHead(String dato) {
    return Container(
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
              child: Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MenuScreen()),
                  );
                },
                child: Text(
                  "Cines /",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Salas",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "/ Shows",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              )
            ],
          )
              /*
            Text(
              "Cines/ Salas",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            */
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
          hintText: 'Buscar Sala',
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
          return (value == null || value.isEmpty) ? 'Escribe la sala' : null;
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
          'Añadir sala',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
