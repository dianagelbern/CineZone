import 'dart:async';

import 'package:cine_zone/bloc/cines_bloc/cines_bloc.dart';
import 'package:cine_zone/models/cine/cines_response.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository_impl.dart';
import 'package:cine_zone/ui/screens/cine_screen.dart';
import 'package:cine_zone/ui/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  late CineRepository cineRepository;
  String get page => '0';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cineRepository = CineRepositoryImpl();
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.3826, -5.99629),
    zoom: 15.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.3846066, -5.9733626),
      //LatLng(37.3846066, -5.9733626)
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return CinesBloc(cineRepository)..add(FetchCineWithType(page));
        },
        child: Scaffold(
            body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (LatLng posicion) {
                //TODO
              },
            ),
            Positioned(
              bottom: 10,
              left: 0,
              child: _createCines(context),
            ),
          ],
        )
            /*
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
      */
            ));
  }

  Widget _createCines(BuildContext context) {
    return BlocBuilder<CinesBloc, CinesState>(
      builder: (context, state) {
        if (state is CinesInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CinesFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<CinesBloc>().add(FetchCineWithType(page));
            },
          );
        } else if (state is CinesFetched) {
          return _maps(context, state.cine);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _maps(BuildContext context, List<Cine> cines) {
    return SizedBox(
      height: 125,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return _cineItem(context, cines[index]);
        },
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        itemCount: cines.length,
        shrinkWrap: true,
      ),
    );
  }

  Widget _cineItem(BuildContext context, Cine cine) {
    return InkWell(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CineScreen(cineId: cine.id, cineNombre: cine.nombre)),
            ),
        child: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            gradient: LinearGradient(
              colors: [Color(0xFF867AD2), Color(0xff494080)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          width: 250.0,
          height: 100.0,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: cine.nombre,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '\n${cine.plaza}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.location_on_sharp),
                        color: Colors.white,
                        onPressed: () {
                          _goToTheLake(cine.latLon);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.all(8),
                  child: Text(
                    cine.direccion,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white),
                  ))
            ],
          ),
        ));
  }

  Future<void> _goToTheLake(String latlon) async {
    var latLong = LatLng(double.parse(latlon.split(",").first),
        double.parse(latlon.split(",").last));
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: latLong,
        //LatLng(37.3846066, -5.9733626)
        tilt: 59.440717697143555,
        zoom: 19.151926040649414)));
  }
}
