import 'package:chewie/chewie.dart';
import 'package:cine_zone/bloc/movies_bloc/movies_bloc.dart';
import 'package:cine_zone/models/movie_response.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository_impl.dart';
import 'package:cine_zone/ui/screens/details_screen.dart';
import 'package:cine_zone/ui/widgets/error_page.dart';
import 'package:cine_zone/ui/widgets/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieRepository movieRepository;
  /*
  late VideoPlayerController _controller;
  late Future<void>? _initializeVideoPlayerFuture;
  */
  //late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    movieRepository = MovieRepositoryImpl();
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MoviesBloc(movieRepository)
          ..add(FetchMovieWithType(Constant.upcoming));
      },
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 70),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _head(),
                _trailers(),
                _createMovies(context),
                _createMovies(context)
              ]),
        ),
      )),
    );
  }

  Widget _createMovies(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context
                  .watch<MoviesBloc>()
                  .add(FetchMovieWithType(Constant.popular));
            },
          );
        } else if (state is MoviesFetched) {
          return _createPopularView(context, state.movies);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _createPopularView(BuildContext context, List<Movie> movies) {
    final contentHeight = 5.0 * (MediaQuery.of(context).size.width / 2.4) / 3;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 20.0, right: 16.0),
          height: 48.0,
          child: Row(
            children: const [
              Expanded(
                flex: 1,
                child: Text(
                  'Cartelera',
                  style: TextStyle(
                    color: Color.fromARGB(255, 241, 241, 241),
                    fontSize: 24.0,
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 12, color: Color.fromARGB(139, 241, 241, 241)),
            ],
          ),
        ),
        SizedBox(
          height: contentHeight,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return _createPopularViewItem(context, movies[index]);
            },
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
          ),
        ),
      ],
    );
  }

  Widget _createPopularViewItem(BuildContext context, Movie movie) {
    final width = MediaQuery.of(context).size.width / 2.6;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetailsScreen()),
        );
      },
      child: Column(
        children: [
          Container(
            width: width,
            //height: double.infinity,
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Card(
              elevation: 10.0,
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: SizedBox(
                width: width,
                //height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    width: width,
                    //height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 140,
            child: Text(
              movie.title!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _head() {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 20),
        child: Container(
          alignment: Alignment.center,
          child: SvgPicture.asset('assets/images/logo.svg', width: 150),
        ));
  }

  Widget _trailers() {
    return Container(
      height: 230,
      child: VideoPlayerItem(
        VideoPlayerItemController: VideoPlayerController.asset(
          'assets/videos/spiderman.mp4',
        ),
        looping: true,
      ),
    );
  }

  /*
  Widget _estrenos() {
    final width = MediaQuery.of(context).size.width / 2.6;
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estrenos',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
          ),
          Container(
              width: width,
              height: double.infinity,
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Card(
                  elevation: 10.0,
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: SizedBox(
                      width: width,
                      height: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          imageUrl:
                              'https://images-na.ssl-images-amazon.com/images/I/91vkH4q7ZPL.jpg',
                          width: width,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ))))
        ],
      ),
    );
  }
  */

  Widget _anuncio() {
    return Container();
  }

  Widget _populares() {
    return Container();
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
