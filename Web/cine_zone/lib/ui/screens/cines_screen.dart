import 'package:cine_zone/bloc/create_cine_bloc/create_cine_bloc.dart';
import 'package:cine_zone/bloc/get_cines_bloc/get_cines_bloc.dart';
import 'package:cine_zone/models/cine/cine_dto.dart';

import 'package:cine_zone/models/cine/cine_response.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository_impl.dart';
import 'package:cine_zone/ui/screens/salas_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  TextEditingController nombreController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController latLonController = TextEditingController();
  TextEditingController numSalasController = TextEditingController();
  TextEditingController plazaController = TextEditingController();

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getCinesBloc),
        BlocProvider(
          create: (context) => CreateCineBloc(cineRepository),
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            createCineBlocConsumer(context),
            _blocBuilderCines(context),
          ],
        ),
      ),
    );
  }

  Widget createCineBlocConsumer(BuildContext context) {
    return BlocConsumer<CreateCineBloc, CreateCineState>(
        listenWhen: (context, state) {
      return state is CreateCineSuccesState || state is CreateCineErrorState;
    }, listener: (context, state) {
      if (state is CreateCineSuccesState) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CinesScreen()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Se añadió un cine correctamente",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800)),
            backgroundColor: Color(0xFF867AD2),
          ),
        );
      } else if (state is CreateCineErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Algo salió mal, vuelve a intentarlo")),
        );
      }
    }, buildWhen: (context, state) {
      return state is CreateCineInitial && state is CreateCineSuccesState;
    }, builder: (context, state) {
      return _opciones(context);
    });
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
                    idCine: cine.id,
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

  Widget _opciones(BuildContext context) {
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
              children: [_search(), _boton(context)],
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
                      'Añadir Cine',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  content: Container(
                    alignment: Alignment.center,
                    width: 310,
                    height: 600,
                    child: Column(
                      children: [
                        _formCreateMovie(context),
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
                              final createCine = CineDto(
                                  nombre: nombreController.text,
                                  direccion: direccionController.text,
                                  latLon: latLonController.text,
                                  numSalas: int.parse(numSalasController.text),
                                  plaza: plazaController.text);

                              BlocProvider.of<CreateCineBloc>(ctx)
                                  .add(CreateCine(createCine));
                              print(createCine.toJson().toString());
                            },
                            child: Text(
                              'Añadir Cine',
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
          'Añadir Cine',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _formCreateMovie(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Column(
            children: [
              _infoCine("Nombre", "Nombre del cine", nombreController, 300),
              _infoCine("Dirección", "Dirección", direccionController, 300),
              _infoCine("Latitud y longitud", "Latitud y longitud",
                  latLonController, 300),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text("Número de salas",
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
                      controller: numSalasController,
                      decoration: InputDecoration(
                        hintText: "Número de salas",
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
                        LengthLimitingTextInputFormatter(2),
                      ],
                      onSaved: (String? value) {},
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Escribe el num de salas'
                            : null;
                      },
                    ),
                  ),
                ],
              ),
              _infoCine("Plaza", "Nombre de la plaza", plazaController, 300),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoCine(
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
