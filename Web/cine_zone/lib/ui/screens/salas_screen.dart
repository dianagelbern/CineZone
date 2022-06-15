import 'package:cine_zone/bloc/get_salas_from_cine_bloc/get_salas_from_cine_bloc.dart';
import 'package:cine_zone/models/sala/sala_from_cine_response.dart';
import 'package:cine_zone/repository/sala_repository.dart/salas_repository.dart';
import 'package:cine_zone/repository/sala_repository.dart/salas_repository_impl.dart';
import 'package:cine_zone/ui/screens/shows_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalasScreen extends StatefulWidget {
  SalasScreen(
      {Key? key,
      required this.idCine,
      required this.nombreCine,
      required this.nombrePlaza})
      : super(key: key);

  int idCine;
  String nombreCine;
  String nombrePlaza;
  @override
  State<SalasScreen> createState() => _SalasScreenState();
}

class _SalasScreenState extends State<SalasScreen> {
  late SalaRepository salaRepository;
  late GetSalasFromCineBloc getSalasFromCineBloc;
  int page = 0;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    salaRepository = SalaRepositoryImpl();
    getSalasFromCineBloc = GetSalasFromCineBloc(salaRepository)
      ..add(DoGetSalasFromCineEvent(page.toString(), widget.idCine.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getSalasFromCineBloc,
      child: Scaffold(
          body: Column(
        children: [
          _opciones(),
          _blocBuilderSalas(context),

          //
        ],
      )),
    );
  }

  _blocBuilderSalas(BuildContext buildContext) {
    return BlocBuilder<GetSalasFromCineBloc, GetSalasFromCineState>(
      builder: (context, state) {
        if (state is GetSalasFromCineInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetSalasFromCineErrorState) {
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
        } else if (state is GetSalasFromCineSuccessState) {
          return Container(
            width: 750,
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
                      _modelTableHead("Nombre de la sala"),
                      _modelTableHead("Nombre del cine"),
                      _modelTableHead("Nombre de la plaza"),
                      _modelTableHead("Más"),
                    ],
                  ),
                ),
                _salaList(context, state.salaList),
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

  Widget _salaList(BuildContext context, List<Sala> salas) {
    return Flexible(
      child: Container(
          child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _SalaItem(context, salas.elementAt(index));
        },
        itemCount: salas.length,
      )),
    );
  }

  Widget _SalaItem(BuildContext context, Sala sala) {
    return GestureDetector(
      onTap: () {
        print(sala.id);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ShowsScreen(salaId: sala.id, cineId: widget.idCine)));
      },
      child: Row(
        children: [
          _modelTable(sala.id.toString()),
          _modelTable(sala.nombre),
          _modelTable(widget.nombreCine),
          _modelTable(widget.nombrePlaza),
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
                  Navigator.pop(context);
                },
                child: Text(
                  "Cines /",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Salas",
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
