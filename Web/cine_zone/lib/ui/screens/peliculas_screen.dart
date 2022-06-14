import 'dart:typed_data';

import 'package:cine_zone/bloc/create_movie_bloc/create_movie_bloc.dart';
import 'package:cine_zone/bloc/get_movies_bloc/get_movies_bloc.dart';
import 'package:cine_zone/bloc/image_pick_bloc/image_pick_bloc.dart';
import 'package:cine_zone/models/movie/movie_dto.dart';
import 'package:cine_zone/models/movie/movies_response.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository_impl.dart';
import 'package:cine_zone/ui/screens/salas_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class PeliculasScreen extends StatefulWidget {
  const PeliculasScreen({Key? key}) : super(key: key);

  @override
  State<PeliculasScreen> createState() => _PeliculasScreenState();
}

class _PeliculasScreenState extends State<PeliculasScreen> {
  String? path = '';
  late MovieRepository movieRepository;
  late GetMoviesBloc getMoviesBloc;
  late CreateMovieBloc createMovieBloc;
  int page = 0;
  TextEditingController searchController = TextEditingController();

  TextEditingController generoController = TextEditingController();
  TextEditingController tituloController = TextEditingController();
  TextEditingController directorController = TextEditingController();
  TextEditingController clasificacionController = TextEditingController();
  TextEditingController productoraController = TextEditingController();
  TextEditingController sinopsisController = TextEditingController();
  TextEditingController duracionController = TextEditingController();
  XFile? _selectedFile;
  File _file = File("zz");
  Uint8List webImage = Uint8List(8);

  File? _pickedFile;
  final ImagePicker _picker = ImagePicker();

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return getMoviesBloc;
          },
        ),
        BlocProvider(
          create: (context) {
            return CreateMovieBloc(movieRepository);
          },
        ),
        BlocProvider(create: (context) {
          return ImagePickBloc();
        }),
      ],
      child: Scaffold(
          body: Column(
        children: [
          createMovieBlocConsumer(context),
          _blocBuilderMovies(context),
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
              "Películas",
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
                    'Añadir película',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            _pickedFile == null
                                ? Image.asset(
                                    "assets/images/error.png",
                                    scale: 3,
                                  )
                                : Image.memory(
                                    webImage,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                            /* (kIsWeb)
                                    ? Image.memory(
                                        webImage,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.file(
                                        _pickedFile!,
                                        fit: BoxFit.fill,
                                      ), */

                            ElevatedButton(
                              onPressed: () {
                                _pickImage(setState);
                                print(_pickedFile?.path);
                              },
                              child: Text("Upload"),
                            )
                          ],
                        ),
                      ),
                      _formCreateMovie(context),
                      Container(
                        margin: EdgeInsets.only(left: 60),
                        width: 161,
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
                            final createMovie = MovieDto(
                                genero: generoController.text,
                                titulo: tituloController.text,
                                director: directorController.text,
                                clasificacion: clasificacionController.text,
                                productora: productoraController.text,
                                sinopsis: sinopsisController.text,
                                duracion: int.parse(duracionController.text));

                            BlocProvider.of<CreateMovieBloc>(ctx)
                                .add(CreateMovie(createMovie, _selectedFile!));
                            print(createMovie.toJson().toString());
                          },
                          child: Text(
                            'Añadir película',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      )
                      // createMovieBlocConsumer(context)
                    ],
                  );
                }),
              );
            }),
        child: Text(
          'Añadir película',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Future<void> _pickImage(StateSetter setState) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      var imageBytes = await image.readAsBytes();

      setState(() {
        _selectedFile = image;
        webImage = imageBytes;
        _pickedFile = File(image.path);
      });
      print(_pickedFile?.path);
    } else {
      Text("No file selected");
    }

    /*   if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);

        setState(() {
          _pickedFile = selected;
        });
      } else {
        Text("No file selected");
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedFile = File("a");
        });
      } else {
        Text("No file selected");
      }
    } else {
      print("Algo salio mal");
    } */
  }

  /*
  uploadImage() async {
    //var permissionStatus = requestPermissions();

    // MOBILE
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var selected = File(image.path);

        setState(() {
          _file = selected;
        });
      } else {
        Text("No file selected");
      }
    }
    // WEB
    else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          _file = File("a");
          webImage = f;
        });
      } else {
        Text("No file selected");
      }
    } else {
      Text("Permission not granted");
    }
  }
  */

  /* Widget imageBloc(BuildContext context) {
    return BlocConsumer<ImagePickBloc, ImagePickState>(
      buildWhen: (context, state) {
        return state is ImagePickInitial || state is ImageSelectedSuccessState;
      },
      builder: (context, state) {
        return _imagePickerBoton(context);
      },
      listenWhen: (context, state) {
        return state is ImageSelectedSuccessState || state is ImagePickInitial;
      },
      listener: (context, state) {},
      //TEXTO
    );
  }
 */
  /*
  _selectedImage() {
    if (_pickedFile != null) {
      return Image.asset(
        "assets/images/logo.svg",
        //File(_pickedFile!.path),
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        color: Colors.blue,
        width: 50,
        height: 50,
      );
    }
  }

  _pickImage() async {
    try {
      if (!kIsWeb) {
        final XFile? file =
            await _picker.pickImage(source: ImageSource.gallery);

        setState(() {
          _pickedFile = file;
        });
      } else if (kIsWeb) {
        final XFile? file =
            await _picker.pickImage(source: ImageSource.gallery);

        setState(() {
          _pickedFile = file;
        });
      } else {
        Text("No hay permiso para la operación");
      }

    } catch (e) {
      throw Exception("Hubo un error con la imagen");
    }
  }

  _imagePickerBoton(BuildContext context) {
    return Card(
        elevation: 0.0,
        color: Colors.white.withOpacity(0),
        child: InkWell(
          child: _selectedImage(),
          onTap: () => _pickImage(),
        ));
  }
 */

  /*  _imagePickerBoton(BuildContext context) {
    return Center(
      child: InkWell(
          onTap: () {
            BlocProvider.of<ImagePickBloc>(context)
                .add(SelectImageEvent(ImageSource.gallery));
          },
          child: Container(
              width: 100.0,
              height: 100.0,
              child: Stack(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(image: DecorationImage(image: AssetImage(
                            //Hacer un if para que si el usuario no selecciona una imagen salga como predeterminada esta
                            'assets/images/user_avatar.png'), fit: BoxFit.cover)),
                  ),
                  Positioned(
                      bottom: 3,
                      right: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            // The child of a round Card should be in round shape
                            shape: BoxShape.circle,
                            color: Colors.blue),
                        child: Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                          size: 35,
                        ),
                      ))
                ],
              ))),
    );
  }
 */
  Widget _formCreateMovie(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Column(
            children: [
              _infoMovie("Nombre", "Título", tituloController, 300),
              _infoMovie("Director", "Director", directorController, 300),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoMovie("Género", "Género", generoController, 200),
                  _infoMovie(
                      "Productora", "Productora", productoraController, 200),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoMovie("Clasificación", "Clasificación",
                      clasificacionController, 200),
                  _infoMovie("Duración", "Duración", duracionController, 200),
                ],
              ),
              _infoMovie("Sinopsis", "Sinopsis", sinopsisController, 300),
            ],
          ),
        ],
      ),
    );
  }

  /*
  _botonSubmit(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 60),
      width: 161,
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
          final createMovie = MovieDto(
              genero: generoController.text,
              titulo: tituloController.text,
              director: directorController.text,
              clasificacion: clasificacionController.text,
              productora: productoraController.text,
              sinopsis: sinopsisController.text,
              duracion: int.parse(duracionController.text));

          BlocProvider.of<CreateMovieBloc>(context)
              .add(CreateMovie(createMovie, path!));
          print(createMovie.toJson().toString());
        },
        child: Text(
          'Añadir película',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
  */

  Widget createMovieBlocConsumer(BuildContext context) {
    return BlocConsumer<CreateMovieBloc, CreateMovieState>(
        listenWhen: (context, state) {
      return state is CreateMovieSuccesState || state is CreateMovieErrorState;
    }, listener: (context, state) {
      if (state is CreateMovieSuccesState) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PeliculasScreen()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Se añadió una película correctamente",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800)),
            backgroundColor: Color(0xFF867AD2),
          ),
        );
      } else if (state is CreateMovieErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Algo salió mal, vuelve a intentarlo")),
        );
      }
    }, buildWhen: (context, state) {
      return state is CreateMovieInitial && state is CreateMovieSuccesState;
    }, builder: (context, state) {
      return _opciones(context);
    });
  }

/*   Widget imageBloc(BuildContext context) {
    return BlocConsumer<ImagePickBloc, ImagePickState>(
      buildWhen: (context, state) {
        return state is ImagePickInitial || state is ImageSelectedSuccessState;
      },
      builder: (context, state) {
        return _boton(context);
      },
      listenWhen: (context, state) {
        return state is ImageSelectedSuccessState || state is ImagePickInitial;
      },
      listener: (context, state) {},
      //TEXTO
    );
  } */
/* 
 

 

 
  _botonSubmit(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 60),
      width: 161,
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
          final createMovie = MovieDto(
              genero: generoController.text,
              titulo: tituloController.text,
              director: directorController.text,
              clasificacion: clasificacionController.text,
              productora: productoraController.text,
              sinopsis: sinopsisController.text,
              duracion: int.parse(duracionController.text));

          BlocProvider.of<CreateMovieBloc>(context)
              .add(CreateMovie(createMovie, path!));
          print(createMovie.toJson().toString());
        },
        child: Text(
          'Añadir película',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

 */
  Widget _infoMovie(
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
