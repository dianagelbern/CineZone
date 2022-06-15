import 'package:cine_zone/bloc/create_show_bloc/create_show_bloc.dart';
import 'package:cine_zone/bloc/get_shows_from_sala_bloc/get_shows_from_sala_bloc.dart';
import 'package:cine_zone/models/movie/movies_response.dart';
import 'package:cine_zone/models/show/show_by_sala_response.dart';
import 'package:cine_zone/models/show/show_dto.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository_impl.dart';
import 'package:cine_zone/repository/show_repository/show_repository.dart';
import 'package:cine_zone/repository/show_repository/show_repository_impl.dart';
import 'package:cine_zone/ui/screens/cines_screen.dart';
import 'package:cine_zone/ui/screens/menu_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class ShowsScreen extends StatefulWidget {
  ShowsScreen({Key? key, required this.salaId, required this.cineId})
      : super(key: key);

  int salaId;
  int cineId;
  @override
  State<ShowsScreen> createState() => _ShowsScreenState();
}

class _ShowsScreenState extends State<ShowsScreen> {
  String? selectedValue;
  DatePickerController _controller = DatePickerController();
  late ShowRepository showRepository;
  late MovieRepository movieRepository;
  late GetShowsFromSalaBloc getShowsFromSalaBloc;
  int page = 0;
  TextEditingController searchController = TextEditingController();
  String fecha = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();

  TextEditingController movieController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController horaController = TextEditingController();
  TextEditingController formatoController = TextEditingController();
  TextEditingController idiomaController = TextEditingController();
  var movieSelected;
  DateTime? selectedDate;
  TimeOfDay? horaSelected;
  TimeOfDay selectedTime = TimeOfDay.now();
  final _formKey = GlobalKey<FormState>();
  var formatoSelected;
  DateTime _selectedValue = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieRepository = MovieRepositoryImpl();
    showRepository = ShowRepositoryImpl();
    getShowsFromSalaBloc = GetShowsFromSalaBloc(showRepository)
      ..add(DoGetShowsFromSalaEvent(
          page.toString(), widget.salaId.toString(), fecha));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getShowsFromSalaBloc,
        ),
        BlocProvider(
          create: (context) => CreateShowBloc(showRepository),
        ),
      ],
      child: Scaffold(
          body: Column(
        children: [
          createShowBlocConsumer(context),
          _blocBuilderShow(context),
        ],
      )),
    );
  }

  Widget createShowBlocConsumer(BuildContext context) {
    return BlocConsumer<CreateShowBloc, CreateShowState>(
        listenWhen: (context, state) {
      return state is CreateShowSuccesState || state is CreateShowErrorState;
    }, listener: (context, state) {
      if (state is CreateShowSuccesState) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ShowsScreen(
                      salaId: widget.salaId,
                      cineId: widget.cineId,
                    )));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Se añadió el show correctamente",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800)),
            backgroundColor: Color(0xFF867AD2),
          ),
        );
      } else if (state is CreateShowErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Algo salió mal, vuelve a intentarlo")),
        );
      }
    }, buildWhen: (context, state) {
      return state is CreateShowInitial && state is CreateShowSuccesState;
    }, builder: (context, state) {
      return _opciones(context);
    });
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

  Widget datePicker(BuildContext context) {
    int mes;
    String mesResult = "";
    int dia;
    String diaResult = "";
    return Container(
      //  width: MediaQuery.of(context).size.width,
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
          BlocProvider.of<GetShowsFromSalaBloc>(context).add(
              DoGetShowsFromSalaEvent(
                  page.toString(), widget.salaId.toString(), fecha));
        },
      ),
    );
  }

  Widget _showList(BuildContext context, List<Show> shows) {
    return Flexible(
      child: Container(
          child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _showItem(context, shows.elementAt(index));
        },
        itemCount: shows.length,
      )),
    );
  }

  Widget _showItem(BuildContext context, Show show) {
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

  Widget _opciones(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 30),
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
                        MaterialPageRoute(
                            builder: (context) => const MenuScreen()),
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
              )),
              Container(
                child: Row(
                  children: [_search(), _boton(context)],
                ),
              )
            ],
          ),
        ),
        Container(
          width: 600,
          margin: EdgeInsets.only(bottom: 30),
          child: datePicker(context),
        )
      ],
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
          hintText: 'Buscar Show',
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
          return (value == null || value.isEmpty) ? 'Escribe el show' : null;
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
                      'Añadir Show',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  content: Container(
                    alignment: Alignment.center,
                    width: 310,
                    height: 500,
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
                              final createShow = ShowDto(
                                  idMovie: movieSelected,
                                  idCine: widget.cineId,
                                  idSala: widget.salaId,
                                  fecha: fechaController.text,
                                  hora: horaController.text,
                                  formato: "DIGITAL",
                                  idioma: idiomaController.text);

                              BlocProvider.of<CreateShowBloc>(ctx)
                                  .add(CreateShow(createShow));
                              print(createShow.toJson().toString());
                            },
                            child: Text(
                              'Añadir Show',
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
          'Añadir Show',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  _movieSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TypeAheadField<Movie>(
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            color: Colors.white,
            shadowColor: Color.fromARGB(255, 255, 255, 255),
          ),
          textFieldConfiguration: TextFieldConfiguration(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              hintText: "Busca película",
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
                Radius.circular(20),
              )),
            ),
            controller: movieController,
          ),
          debounceDuration: Duration(milliseconds: 500),
          onSuggestionSelected: (Movie? movie) {},
          noItemsFoundBuilder: (context) => const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("No se encontró ninguna película"),
              ),
          suggestionsCallback: (value) async =>
              movieRepository.fetchMovies(value),
          itemBuilder: (context, Movie? movie) {
            return ListTile(
              onTap: () {
                movieController.text = movie!.titulo.toString();

                setState(() {
                  //variable idSelected = movie!.id;
                  //idSelected irá al DTO de la pelicula
                  movieSelected = movie.id;
                });
              },
              title: Text(
                "${movie!.titulo}",
                style: const TextStyle(color: Colors.black),
              ),
            );
          }),
    );
  }

  Widget _formCreateMovie(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            children: [
              _movieSearch(context),
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
                            firstDate: DateTime.now(),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                      controller: fechaController,
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
                              ? 'Fecha de emisión'
                              : DateFormat.EEEE(selectedDate).toString()),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text("Hora",
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
                      format: DateFormat.Hm(),
                      onShowPicker: (context, currentValue) async {
                        final TimeOfDay? timeOfDay = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                          initialEntryMode: TimePickerEntryMode.dial,
                        );
                        if (timeOfDay != null && timeOfDay != selectedTime) {
                          print(timeOfDay);
                          setState(() {
                            selectedTime = timeOfDay;
                          });
                        }
                        return DateTimeField.convert(selectedTime);
                      },
                      controller: horaController,
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
                          hintText: horaSelected == null
                              ? 'Fecha de vencimiento'
                              : DateFormat.EEEE(horaSelected).toString()),
                    ),
                  ),
                ],
              ),
              //selectValue(context),
              //_infoShow("Formato", "Formato", formatoController, 300),
              _infoShow("Idioma", "Idioma", idiomaController, 300),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoShow(
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
