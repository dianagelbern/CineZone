import 'package:cine_zone/bloc/movie_item/movie_item_bloc.dart';
import 'package:cine_zone/bloc/movies_bloc/movies_bloc.dart';
import 'package:cine_zone/models/movie/movie_dto.dart';
import 'package:cine_zone/models/movie/movie_response.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository_impl.dart';
import 'package:cine_zone/ui/screens/cine_screen.dart';
import 'package:cine_zone/ui/screens/cines_screen.dart';
import 'package:cine_zone/ui/widgets/error_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key? key, required this.id}) : super(key: key);

  String id;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late MovieRepository movieRepository;
  //String get id => "1";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieRepository = MovieRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return MovieItemBloc(movieRepository)
            ..add(MovieItemFetchEvent(widget.id));
        },
        child: Scaffold(
          body: _createMovieView(context),
        ));
  }

  Widget _createMovieView(BuildContext context) {
    return BlocBuilder<MovieItemBloc, MovieItemState>(
        builder: (context, state) {
      if (state is MovieItemInitial) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      } else if (state is MovieItemFetchError) {
        return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<MovieItemBloc>()
                ..add(MovieItemFetchEvent(widget.id));
            });
      } else if (state is MovieItemfetchedState) {
        return principal(context, state.movie);
      } else {
        return Text('Not support');
      }
    });
  }

  Widget principal(BuildContext context, MovieItem movie) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: cuerpo(movie),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 40),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color.fromARGB(0, 28, 26, 41),
                          Color.fromARGB(60, 28, 26, 41),
                          Color.fromARGB(100, 28, 26, 41),
                          Color(0xFF1C1A29),
                          Color(0xFF1C1A29),
                          Color(0xFF1C1A29),
                          Color(0xFF1C1A29)
                        ]))),
                Container(
                  width: 325,
                  height: 47,
                  decoration: BoxDecoration(
                      color: const Color(0xFF867AD2),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CinesScreen()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/ticket.svg',
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Comprar",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          )
                        ],
                      )),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Widget cuerpo(MovieItem movie) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 212,
              child: Stack(
                children: [
                  Container(
                    width: 800,
                    child: Image.network(
                      movie.imagen,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    width: 800,
                    color: const Color.fromARGB(171, 28, 26, 41),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                margin: const EdgeInsets.only(top: 190),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            movie.imagen,
                            fit: BoxFit.cover,
                            width: 130,
                            height: 189,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 150,
                                child: Text(movie.titulo,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25)),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              'Director',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    64, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              'Género',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    64, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              'Productora',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    64, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 60,
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              movie.director,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    150, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 60,
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              movie.genero,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    150, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 60,
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              movie.productora,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    150, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                width: 98,
                height: 58,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(50, 253, 253, 253)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Duración',
                      style: const TextStyle(
                          color: Color.fromARGB(113, 212, 212, 212),
                          fontSize: 13),
                    ),
                    Text(
                      movie.duracion.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                width: 98,
                height: 58,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(50, 253, 253, 253)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'P-G',
                      style: TextStyle(
                          color: const Color.fromARGB(113, 212, 212, 212),
                          fontSize: 13),
                    ),
                    Text(
                      movie.clasificacion,
                      style: const TextStyle(color: Colors.white, fontSize: 17),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('Sinopsis',
                    style: const TextStyle(fontSize: 18, color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 130),
                child: Text(
                  movie.sinopsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13, color: Color.fromARGB(113, 212, 212, 212)),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
