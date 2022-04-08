import 'dart:async';

import 'package:cine_zone/ui/screens/cine_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.3826, -5.99629),
    zoom: 15.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.3846066, -5.9733626),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          left: 10,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CineScreen()),
                );
              },
              child: Container(
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
                height: 132.0,
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
                                    text: 'Cine Zona',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '\nSevilla Este',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12)),
                                    ],
                                  ),
                                ),

                                /* 
                                Text(
                                  'Cine Zona',
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  'Sevilla este',
                                  textAlign: TextAlign.left,
                                ),*/
                              ],
                            ),
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.location_on_sharp),
                              color: Colors.white,
                              onPressed: () {
                                _goToTheLake();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(8),
                        child: Text(
                          'Gta. Palacio de Congresos, 1, 41020 Sevilla',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
          ),
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
        );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
