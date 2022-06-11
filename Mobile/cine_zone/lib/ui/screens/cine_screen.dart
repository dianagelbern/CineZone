import 'package:cine_zone/bloc/shows_by_cine_bloc/shows_by_cine_bloc.dart';
import 'package:cine_zone/models/cine/cines_response.dart';
import 'package:cine_zone/models/show/show_by_cine_response.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository_impl.dart';
import 'package:cine_zone/repository/show_repository/show_repository.dart';
import 'package:cine_zone/repository/show_repository/show_repository_impl.dart';
import 'package:cine_zone/ui/screens/menu_screen.dart';
import 'package:cine_zone/ui/screens/sala_screen.dart';
import 'package:cine_zone/ui/widgets/error_page.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import "package:collection/collection.dart";
import 'package:cached_network_image/cached_network_image.dart';

class CineScreen extends StatefulWidget {
  CineScreen({Key? key, required this.cineId, required this.cineNombre})
      : super(key: key);

  int cineId;
  String cineNombre;
  @override
  State<CineScreen> createState() => _CineScreenState();
}

class _CineScreenState extends State<CineScreen> {
  late ShowRepository showRepository;
  List<CineShow> cines = [];
  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  String fecha = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
  String page = '0';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ShowsByCineBloc(showRepository)
          ..add(FetchShowsByCineWithPage(widget.cineId, fecha, page));
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF2F2C44),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            leadingWidth: 100,
            title: Text(widget.cineNombre),
          ),
          body: _createCineView(context)),
    );
  }

  Widget _createCineView(BuildContext context) {
    return BlocBuilder<ShowsByCineBloc, ShowsByCineState>(
        builder: (context, state) {
      if (state is ShowsByCineInitial) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      } else if (state is ShowsByCineFetchError) {
        print(state.message);
        return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<ShowsByCineBloc>()
                ..add(FetchShowsByCineWithPage(
                    widget.cineId,
                    DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
                    page));
            });
      } else if (state is ShowsByCineFetched) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: datePicker(context),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: const Divider(
                      color: Color.fromARGB(158, 158, 158, 158), height: 5)),
              state.shows.isNotEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          _movieList(
                              context, state.shows.map((e) => e).toList())
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

  Widget _movieList(BuildContext context, List<CineShow> movies) {
    var newMap = movies.groupListsBy((element) => element.idMovie);
    List<CineShow> shows = newMap.entries.elementAt(0).value;

    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        // return cineItem(context, cinemas.elementAt(index));
        return _type(context, newMap.entries.elementAt(index).value);
      },
      itemCount: shows.length,
    );
  }

  Widget _type(BuildContext context, List<CineShow> shows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              shows.first.formato,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w700),
            )),
        _movieItem(context, shows)
      ],
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
          BlocProvider.of<ShowsByCineBloc>(context)
              .add(FetchShowsByCineWithPage(widget.cineId, fecha, page));
        },
      ),
    );
  }

  Widget _movieItem(BuildContext context, List<CineShow> shows) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 117,
          height: 167,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              errorWidget: (context, url, error) => Icon(Icons.error),
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              imageUrl: shows.first.movieImagen,
              width: 100,
              //height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: 200,
                child: Text(
                  shows.first.movieTitulo,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(shows.first.formato,
                    style: TextStyle(
                      color: Color.fromARGB(104, 255, 255, 255),
                      fontSize: 12,
                    )),
              ),
              Container(
                width: 200,
                height: 110,
                /*
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(85, 255, 255, 255)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                */
                child: _typeFormat(context, shows),
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget _typeFormat(BuildContext context, List<CineShow> shows) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          runSpacing: 10,
          children: [for (var s in shows) _buttonTime(context, s)],
        ),
      ),
    );

    /* ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: shows.length,
        itemBuilder: ((context, index) {
          return _buttonTime(context, shows.elementAt(index));
        })); */
  }

  Widget _buttonTime(BuildContext context, CineShow show) {
    return Container(
      height: 30,
      width: 60,
      margin: const EdgeInsets.only(bottom: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFF6C61AF),
      ),
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
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }
}
