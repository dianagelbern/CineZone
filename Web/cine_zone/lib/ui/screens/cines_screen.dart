import 'package:cine_zone/bloc/get_cines_bloc/get_cines_bloc.dart';

import 'package:cine_zone/models/cine/cine_response.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository_impl.dart';
import 'package:cine_zone/ui/screens/salas_screen.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

//List<Cine> _paginatedCines = [];
//List<Cine> _cines = [];
//int _rowsPerPage = 10;
//List<Cine> cinesData = [];

class CinesScreen extends StatefulWidget {
  const CinesScreen({Key? key}) : super(key: key);

  @override
  State<CinesScreen> createState() => _CinesScreenState();
}

class _CinesScreenState extends State<CinesScreen> {
  TextEditingController searchController = TextEditingController();
  final key = new GlobalKey<PaginatedDataTableState>();
  var _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  late CinesResponse _cine;

  late GetCinesBloc _getCinesBloc;
  late CineRepository cineRepository;

  int page = 0;
  List<Cine> cinesData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cineRepository = CineRepositoryImpl();
    _getCinesBloc = GetCinesBloc(cineRepository)..add(DoGetCinesEvent("$page"));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getCinesBloc,
      child: Scaffold(
        body: Column(
          children: [
            _opciones(),
            _blocBuilderCines(context),
          ],
        ),
      ),
    );
  }

  _blocBuilderCines(BuildContext context) {
    return BlocBuilder<GetCinesBloc, GetCinesState>(
      builder: (context, state) {
        if (state is GetCinesInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetCinesErrorState) {
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
        } else if (state is GetCinesSuccessState) {
          //cineDataSource = CineDataSource(cineData: state.cineList);
          //cinesData = state.cineList;
          return Container(
            width: 1050,
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
                      _modelTableHead("Dirección"),
                      _modelTableHead("Plaza"),
                      _modelTableHead("LatLon"),
                      _modelTableHead("Más"),
                    ],
                  ),
                ),
                _cineList(context, state.cineList),
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

  Widget _cineList(BuildContext context, List<Cine> cines) {
    return Flexible(
      child: Container(
          child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _cineItem(context, cines.elementAt(index));
        },
        itemCount: cines.length,
      )),
    );
  }

  Widget _cineItem(BuildContext context, Cine cine) {
    return GestureDetector(
      onTap: () {
        print(cine.id);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SalasScreen(
                    idCine: cine.id.toString(),
                    nombreCine: cine.nombre,
                    nombrePlaza: cine.plaza)));
      },
      child: Row(
        children: [
          _modelTable(cine.id.toString()),
          _modelTable(cine.nombre),
          _modelTable(cine.direccion),
          _modelTable(cine.plaza),
          _modelTable(cine.latLon),
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
      width: 175,
      alignment: Alignment.center,
      child: Text(dato),
    );
  }

  Widget _modelTableHead(String dato) {
    return Container(
      width: 175,
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
              "Cines",
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
          hintText: 'Buscar cine',
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
              ? 'Escribe el nombre del cine'
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
          'Añadir cine',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
