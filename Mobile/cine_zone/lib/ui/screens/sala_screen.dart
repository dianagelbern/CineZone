import 'package:cine_zone/bloc/fetch_asientos_show_bloc/fetch_asientos_show_bloc.dart';
import 'package:cine_zone/models/asientos_show/asientos_show_response.dart';
import 'package:cine_zone/repository/asientos_show_repository/asientos_show_repository.dart';
import 'package:cine_zone/repository/asientos_show_repository/asientos_show_repository_impl.dart';
import 'package:cine_zone/ui/screens/compra_screen.dart';
import 'package:cine_zone/ui/widgets/error_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SalaScreen extends StatefulWidget {
  SalaScreen(
      {Key? key,
      required this.idShow,
      required this.fecha,
      required this.hora,
      required this.formato,
      required this.nombre,
      required this.nombreCine,
      required this.nombreSala,
      required this.idCine})
      : super(key: key);

  String idShow;
  String nombre;
  String hora;
  String fecha;
  String formato;
  String nombreCine;
  String nombreSala;
  String idCine;

  @override
  State<SalaScreen> createState() => _SalaScreenState();
}

class _SalaScreenState extends State<SalaScreen> {
  late AsientosShowRepository asientosShowRepository;
  List<AsientoShow> asientosSeleccionados = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asientosShowRepository = AsientosShowRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return FetchAsientosShowBloc(asientosShowRepository)
          ..add(FetchAsientosShowWithShow(widget.idShow));
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF2F2C44),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          leadingWidth: 100,
          title: Text(widget.nombre),
        ),
        body: _createSeatsView(context),
      ),
    );
  }

  Widget _createSeatsView(BuildContext context) {
    return BlocBuilder<FetchAsientosShowBloc, FetchAsientosShowState>(
        builder: (context, state) {
      if (state is FetchAsientosShowInitial) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      } else if (state is FetchAsientosShowError) {
        return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<FetchAsientosShowBloc>()
                ..add(FetchAsientosShowWithShow(widget.idShow));
            });
      } else if (state is FetchAsientosShowFetched) {
        return _sala(context, state.asientosShow);
      } else {
        return Text("Not Support");
      }
    });
  }

  Widget _sala(BuildContext context, List<AsientoShow> asientos) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          screen(),
          _listOfAsientos(context, asientos),
          _info(),
          Padding(
            padding: EdgeInsets.all(20),
            child: _info_compra(),
          )
        ],
      ),
    ));
  }

  Widget screen() {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: SvgPicture.asset('assets/images/pantalla.svg')),
        Text(
          'Pantalla',
          style: TextStyle(
              color: Color.fromARGB(148, 255, 255, 255), fontSize: 14),
        ),
      ],
    );
  }

  Widget _listOfAsientos(BuildContext context, List<AsientoShow> asientos) {
    return Center(
        child: Container(
      margin: EdgeInsets.only(top: 30, left: 20, right: 10),
      height: 370,
      child: GridView.builder(
          itemCount: asientos.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 45,
              childAspectRatio: 8 / 8,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1),
          itemBuilder: (BuildContext context, int index) {
            return _asiento(context, asientos.elementAt(index));
          }),
    ));
  }

  Widget _asiento(BuildContext context, AsientoShow asiento) {
    if (asiento.esOcupado) {
      return Container(
        child: Stack(
          children: [
            Image.asset('assets/images/ocupado.png', height: 35),
            Center(
                child: Container(
              padding: EdgeInsets.only(bottom: 8, right: 8),
              child: Text(asiento.num.toString(),
                  style: TextStyle(
                      color: Color.fromARGB(155, 255, 255, 255),
                      fontSize: 13,
                      fontWeight: FontWeight.w800)),
            )),
            Positioned(
                top: 0,
                right: 10,
                child: Text(asiento.fila.toString(),
                    style: TextStyle(
                      color: Color.fromARGB(80, 255, 255, 255),
                      fontSize: 11,
                    )))
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          if (!asientosSeleccionados.contains(asiento)) {
            setState(() {
              asientosSeleccionados.add(asiento);
            });
          } else if (asientosSeleccionados.contains(asiento)) {
            setState(() {
              asientosSeleccionados.remove(asiento);
            });
          }
        },
        child: Container(
          child: Stack(
            children: [
              asientosSeleccionados.contains(asiento)
                  ? Image.asset('assets/images/seleccionado.png', height: 35)
                  : Image.asset('assets/images/libre.png', height: 35),
              Center(
                  child: Container(
                padding: EdgeInsets.only(bottom: 8, right: 8),
                child: Text(asiento.num.toString(),
                    style: TextStyle(
                        color: Color.fromARGB(155, 255, 255, 255),
                        fontSize: 13,
                        fontWeight: FontWeight.w800)),
              )),
              Positioned(
                  top: 0,
                  right: 10,
                  child: Text(asiento.fila.toString(),
                      style: TextStyle(
                        color: Color.fromARGB(80, 255, 255, 255),
                        fontSize: 11,
                      )))
            ],
          ),
        ),
      );
    }
  }

  Widget _info() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Divider(color: Color.fromARGB(52, 255, 255, 255), height: 3),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              asiento_info('assets/images/libre.png', 'Libre'),
              asiento_info('assets/images/ocupado.png', 'Ocupado'),
              asiento_info('assets/images/seleccionado.png', 'Seleccionado')
            ],
          ),
        )
      ],
    );
  }

  Widget asiento_info(String image, String info) {
    return Row(
      children: [
        Image.asset(
          image,
          width: 20,
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            info,
            style: TextStyle(
                color: Color.fromARGB(155, 255, 255, 255), fontSize: 11),
          ),
        )
      ],
    );
  }

  Widget _info_compra() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      height: 47,
      decoration: BoxDecoration(
          color: Color(0xFF867AD2), borderRadius: BorderRadius.circular(10)),
      child: asientosSeleccionados.isNotEmpty
          ? TextButton(
              onPressed: () => showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 47, 44, 68),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        height: 280,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.domain,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      widget.nombreCine +
                                          " - " +
                                          widget.nombreSala,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    cineInfo('Hora',
                                        widget.hora.replaceRange(4, 7, '')),
                                    cineInfo(
                                        'Fecha',
                                        DateFormat.MMMd().format(
                                            DateTime.parse(widget.fecha))),
                                    cineInfo(
                                        'Formato',
                                        widget.formato[0] +
                                            widget.formato
                                                .toLowerCase()
                                                .substring(1))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Lugares',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              113, 212, 212, 212),
                                          fontSize: 14),
                                    ),
                                    Container(
                                        alignment: Alignment.centerRight,
                                        height: 15,
                                        width: 250,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                asientosSeleccionados.length,
                                            itemBuilder: (context, index) {
                                              var num = asientosSeleccionados
                                                  .elementAt(index)
                                                  .num
                                                  .toString();
                                              var fila = asientosSeleccionados
                                                  .elementAt(index)
                                                  .fila
                                                  .toString();

                                              return Text("$fila - $num,  ",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14));
                                            }))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              113, 212, 212, 212),
                                          fontSize: 14),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Text('17.00€',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              boton_compra()
                            ],
                          ),
                        ));
                  }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/ticket.svg',
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Comprar",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )
                ],
              ))
          : TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/ticket.svg',
                    color: Color.fromARGB(115, 255, 255, 255),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Comprar",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(115, 255, 255, 255)),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget cineInfo(String infoEstatica, String info) {
    return Container(
      width: 98,
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(50, 253, 253, 253)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            infoEstatica,
            style: TextStyle(
                color: Color.fromARGB(113, 212, 212, 212), fontSize: 13),
          ),
          Text(
            info,
            style: TextStyle(color: Colors.white, fontSize: 15),
          )
        ],
      ),
    );
  }

  Widget boton_compra() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      height: 47,
      decoration: BoxDecoration(
          color: Color(0xFF867AD2), borderRadius: BorderRadius.circular(10)),
      child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CompraScreen(
                      idShow: widget.idShow.toString(),
                      nombre: widget.nombre,
                      hora: widget.hora,
                      fecha: widget.fecha,
                      formato: widget.formato,
                      nombreCine: widget.nombreCine,
                      nombreSala: widget.nombreSala,
                      asientosSeleccionados: asientosSeleccionados,
                      idCine: widget.idCine)),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/ticket.svg',
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Comprar",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            ],
          )),
    );
  }
}
