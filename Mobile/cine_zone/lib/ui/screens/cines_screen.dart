import 'package:cine_zone/bloc/show_by_movie/show_by_movie_bloc.dart';
import 'package:cine_zone/models/show/show_by_movie_response.dart';
import 'package:cine_zone/repository/show_repository/show_repository.dart';
import 'package:cine_zone/repository/show_repository/show_repository_impl.dart';
import 'package:cine_zone/ui/screens/home_screen.dart';
import 'package:cine_zone/ui/screens/sala_screen.dart';
import 'package:cine_zone/ui/widgets/error_page.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/extra/dimen.dart';
import 'package:expandable/expandable.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:expandable/expandable.dart';
import "package:collection/collection.dart";
import 'dart:math' as math;

class CinesScreen extends StatefulWidget {
  CinesScreen({Key? key, required this.id, required this.nombre})
      : super(key: key);

  int id;
  String nombre;
  @override
  State<CinesScreen> createState() => _CinesScreenState();
}

class _CinesScreenState extends State<CinesScreen> {
  late ShowRepository showRepository;
  List<MovieShow> shows = [];

  DatePickerController _controller = DatePickerController();
  TextEditingController cinesController = TextEditingController();
  bool _expanded = false;
  var _test = "Full Screen";
  String fecha = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();

  DateTime _selectedValue = DateTime.now();
  String page = '0';

  String nombrePeli = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showRepository = ShowRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

//DateFormat("yyyy-MM-dd").format(DateTime.now()).toString()
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ShowByMovieBloc(showRepository)
          ..add(FetchShowByMovieWithPage(widget.id, fecha, page));
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF2F2C44),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
            ),
            leadingWidth: 100,
            title: Text(widget.nombre),
          ),
          body: _createMovieView(context)),
    );
  }

  Widget _createMovieView(BuildContext context) {
    return BlocBuilder<ShowByMovieBloc, ShowByMovieState>(
        builder: (context, state) {
      if (state is ShowByMovieInitial) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      } else if (state is ShowsByMovieFetchError) {
        print(state.message);
        return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<ShowByMovieBloc>()
                ..add(FetchShowByMovieWithPage(
                    widget.id,
                    DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
                    page));
            });
      } else if (state is ShowByMovieFetched) {
        //nombrePeli = state.shows.first.movieTitulo;

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: datePicker(context),
              ),
              const Divider(color: Colors.grey, height: 3),
              state.shows.isNotEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          // _search(),
                          _cinemaList(
                              context, state.shows.map((e) => e).toList()),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                      children: [
                        Container(
                          width: 300,
                          child: Image.asset('assets/images/nada.png'),
                        ),
                        Text(
                          "No hay shows para este día aún",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ))
            ],
          ),
        );
      } else {
        return Text('Not support');
      }
    });
  }

  Widget _cinemaList(BuildContext context, List<MovieShow> cinemas) {
    var newMap = cinemas.groupListsBy((element) => element.idCine);
    List<MovieShow> shows = newMap.entries.elementAt(0).value;

    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        // return cineItem(context, cinemas.elementAt(index));
        return cineItem(context, newMap.entries.elementAt(index).value);
      },
      itemCount: shows.length,
    );
  }

  Widget cineItem(BuildContext context, List<MovieShow> shows) {
    return ExpansionWidget(
      initiallyExpanded: true,
      titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
        return InkWell(
            onTap: () => toogleFunction(animated: true),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        shows.first.nombreCine,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )),
                  Transform.rotate(
                    angle: math.pi * animationValue / 1,
                    child: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                  )
                ],
              ),
            ));
      },
      content: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(85, 255, 255, 255)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: _typeFormat(context, shows)),
    );
  }

  Widget _typeFormat(BuildContext context, List<MovieShow> shows) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Text(
            shows.first.formato,
            style: TextStyle(
                color: Color.fromARGB(122, 255, 255, 255), fontSize: 14),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width,
          height: 65,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: shows.length,
              itemBuilder: ((context, index) {
                return _buttonTime(context, shows.elementAt(index));
              })),
        )
      ],
    );
  }

  Widget _buttonTime(BuildContext context, MovieShow show) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFF6C61AF),
      ),
      width: 60,
      height: 65,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SalaScreen(
                    idShow: show.id.toString(),
                    nombre: show.movieTitulo,
                    hora: show.hora,
                    fecha: show.fecha,
                    formato: show.formato,
                    nombreCine: show.nombreCine,
                    idCine: show.idCine.toString(),
                    nombreSala: show.salaNombre)),
          );
        },
        child: Text(
          show.hora.replaceRange(4, 7, ''),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _search() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 47,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xFF2F2C44),
            border: Border.all(color: const Color(0xFF2F2C44), width: 1)),
        margin: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: cinesController,
          decoration: const InputDecoration(
            labelText: 'Buscar Cine',
            prefixIcon: Icon(
              Icons.search,
              color: Color.fromARGB(115, 255, 255, 255),
            ),
            labelStyle: TextStyle(
                fontSize: 14, color: Color.fromARGB(125, 255, 255, 255)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2F2C44))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2F2C44))),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
          ),
          onSaved: (String? value) {},
        ),
      ),
    );
  }

  Widget datePicker(BuildContext context) {
    int mes;
    String mesResult = "";
    int dia;
    String diaResult = "";
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: DatePicker(
        DateTime.now(),
        dateTextStyle: const TextStyle(
            color: Color.fromARGB(125, 255, 255, 255), fontSize: 12),
        monthTextStyle: const TextStyle(
            color: Color.fromARGB(125, 255, 255, 255), fontSize: 12),
        dayTextStyle: const TextStyle(
            color: Color.fromARGB(125, 255, 255, 255), fontSize: 12),
        width: 60,
        height: 80,
        daysCount: 9,
        controller: _controller,
        initialSelectedDate: DateTime.now(),
        selectionColor: const Color(0xFF2F2C44),
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          setState(() {
            _selectedValue = date;
            mes = date.month;
            dia = date.day;
            if (mes <= 9) {
              mesResult = "0" + mes.toString();
            } else {
              mesResult = mes.toString();
            }
            if (dia <= 9) {
              diaResult = "0" + dia.toString();
            } else {
              diaResult = dia.toString();
            }
            //dia = date.day.toString();

            fecha = date.year.toString() + "-" + mesResult + "-" + diaResult;

            print(fecha);
          });
          BlocProvider.of<ShowByMovieBloc>(context)
              .add(FetchShowByMovieWithPage(widget.id, fecha, page));
        },
      ),
    );
  }
}
