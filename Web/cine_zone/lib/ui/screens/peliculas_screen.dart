import 'package:cine_zone/bloc/get_movies_bloc/get_movies_bloc.dart';
import 'package:cine_zone/models/movie/movies_response.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository_impl.dart';
import 'package:cine_zone/ui/screens/salas_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeliculasScreen extends StatefulWidget {
  const PeliculasScreen({Key? key}) : super(key: key);

  @override
  State<PeliculasScreen> createState() => _PeliculasScreenState();
}

class _PeliculasScreenState extends State<PeliculasScreen> {
  late MovieRepository movieRepository;
  late GetMoviesBloc getMoviesBloc;
  int page = 0;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieRepository = MovieRepositoryImpl();

    getMoviesBloc = GetMoviesBloc(movieRepository)
      ..add(DoGetMoviesEvent("$page"));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getMoviesBloc,
      child: Scaffold(
          body: Column(
        children: [
          _opciones(),
          _blocBuilderMovies(context),

          //
        ],
      )),
    );
  }

  _blocBuilderMovies(BuildContext buildContext) {
    return BlocBuilder<GetMoviesBloc, GetMoviesState>(
      builder: (context, state) {
        if (state is GetMoviesInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetMoviesErrorState) {
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
        } else if (state is GetMoviesSuccessState) {
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
                      _modelTableHead("Título"),
                      _modelTableHead("Género"),
                      _modelTableHead("Clasificación"),
                      _modelTableHead("Productora"),
                      _modelTableHead("Director"),
                      _modelTableHead("Más"),
                    ],
                  ),
                ),
                _movieList(context, state.movieList),
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

  Widget _movieList(BuildContext context, List<Movie> movies) {
    return Flexible(
      child: Container(
          child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _movieItem(context, movies.elementAt(index));
        },
        itemCount: movies.length,
      )),
    );
  }

  Widget _movieItem(BuildContext context, Movie movie) {
    return GestureDetector(
      onTap: () {
        print(movie.id);
      },
      child: Row(
        children: [
          _modelTable(movie.id.toString()),
          _modelTable(movie.titulo),
          _modelTable(movie.genero),
          _modelTable(movie.clasificacion),
          _modelTable(movie.productora),
          _modelTable(movie.director),
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
            child: Text(
              "Películas",
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
          hintText: 'Buscar película',
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
          return (value == null || value.isEmpty) ? 'Escribe tu nombre' : null;
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
          'Añadir película',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
