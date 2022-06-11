import 'package:cine_zone/bloc/create_reserva_bloc/create_reserva_bloc.dart';
import 'package:cine_zone/bloc/tarjeta_bloc/tarjeta_bloc.dart';
import 'package:cine_zone/models/asientos_show/asientos_show_response.dart';
import 'package:cine_zone/models/reserva/reserva_item_dto.dart';
import 'package:cine_zone/models/tarjeta/tarjeta_response.dart';
import 'package:cine_zone/repository/reserva_repository/reserva_repository.dart';
import 'package:cine_zone/repository/reserva_repository/reserva_repository_impl.dart';
import 'package:cine_zone/repository/tarjeta_repository/tarjeta_repository.dart';
import 'package:cine_zone/repository/tarjeta_repository/tarjeta_repository_impl.dart';
import 'package:cine_zone/ui/screens/menu_screen.dart';
import 'package:cine_zone/ui/screens/tickets_screen.dart';
import 'package:cine_zone/ui/widgets/error_page.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';

class CompraScreen extends StatefulWidget {
  CompraScreen(
      {Key? key,
      required this.idShow,
      required this.nombreCine,
      required this.hora,
      required this.fecha,
      required this.formato,
      required this.nombre,
      required this.nombreSala,
      required this.asientosSeleccionados,
      required this.idCine})
      : super(key: key);

  String idShow;
  String nombreCine;
  String hora;
  String fecha;
  String formato;
  String nombre;
  String nombreSala;
  String idCine;
  List<AsientoShow> asientosSeleccionados;

  @override
  State<CompraScreen> createState() => _CompraScreenState();
}

class _CompraScreenState extends State<CompraScreen> {
  late TarjetaRepository tarjetaRepository;
  late ReservaRepository reservaRepository;
  late TarjetaBloc _tarjetaBloc;
  late CreateReservaBloc _createReservaBloc;

  bool tarjetaSelected = false;
  bool newTarjetaSelected = false;

  ReservaItemDto reservaDto = ReservaItemDto(
      showId: "",
      cineId: "",
      asientoId: "",
      tarjetaId: "",
      no_tarjeta: "",
      fecha_cad: "",
      titular: "");
  String page = '0';

  int _stackIndex = 0;
  String tarjetaSeleccionada = "";

  String _singleValue = "Text alignment right";

  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreTitularController = TextEditingController();
  TextEditingController numTarjetaController = TextEditingController();
  TextEditingController fechaVencimientoController = TextEditingController();
  TextEditingController showIdController = TextEditingController();
  TextEditingController cineIdController = TextEditingController();
  TextEditingController asientoIdController = TextEditingController();
  TextEditingController tarjetaIdController = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tarjetaRepository = TarjetaRepositoryImpl();
    reservaRepository = ReservaRepositoryImpl();

    _tarjetaBloc = TarjetaBloc(tarjetaRepository)
      ..add(FetchTarjetaWithPage(page));
    _createReservaBloc = CreateReservaBloc(reservaRepository)
      ..add(CreateReserva(reservaDto));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _tarjetaBloc,
        ),
        BlocProvider(
          create: (context) => _createReservaBloc,
        ),
      ],
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
          title: const Text('Comprar entrada'),
        ),
        body: SingleChildScrollView(child: _createBody(context)),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return BlocConsumer<CreateReservaBloc, CreateReservaState>(
      listenWhen: (context, state) {
        return state is CreateReservaSuccesState ||
            state is CreateReservaErrorState;
      },
      listener: (context, state) {
        if (state is CreateReservaSuccesState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MenuScreen()),
          );
        } else if (state is CreateReservaErrorState) {
          ErrorPage(
              message: state.message,
              retry: () {
                context.watch<CreateReservaBloc>()
                  ..add(CreateReserva(reservaDto));
              });
        }
      },
      buildWhen: (context, state) {
        return state is CreateReservaInitial;
      },
      builder: (context, state) {
        if (state is CreateReservaInitial) {
          return cuerpo(context);
        } else {
          return cuerpo(context);
        }
      },
    );
  }

  Widget cuerpo(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Column(
        children: [_resumen(context), _formaPago(context)],
      ),
    );
  }

  Widget _formaPago(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: const Text(
              'Pagar con',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: ExpansionWidget(
                    initiallyExpanded: tarjetaSelected,
                    titleBuilder: (double animationValue, _, bool isExpanded,
                        toogleFunction) {
                      return InkWell(
                          onTap: () => toogleFunction(animated: true),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Expanded(
                                    child: Text(
                                  'Tarjeta asociada',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )),
                                Transform.rotate(
                                  angle: math.pi * animationValue / 1,
                                  child: const Icon(
                                    Icons.keyboard_arrow_up_outlined,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                )
                              ],
                            ),
                          ));
                    },
                    content: BlocBuilder<TarjetaBloc, TarjetaState>(
                        bloc: _tarjetaBloc,
                        builder: (context, state) {
                          if (state is TarjetaInitial) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          } else if (state is TarjetaFetchError) {
                            return ErrorPage(
                                message: state.message,
                                retry: () {
                                  context.watch<TarjetaBloc>()
                                    ..add(FetchTarjetaWithPage(page));
                                });
                          } else if (state is TarjetaFetched) {
                            return (Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _tarjetasList(context, state.tarjetas),
                                boton_compra(context)
                              ],
                            ));
                          } else {
                            return Text('Not support');
                          }
                        })),
              ),
              ExpansionWidget(
                initiallyExpanded: newTarjetaSelected,
                titleBuilder: (double animationValue, _, bool isExpanded,
                    toogleFunction) {
                  return InkWell(
                      onTap: () => toogleFunction(animated: true),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(
                                child: Text(
                              'Nueva tarjeta',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            )),
                            Transform.rotate(
                              angle: math.pi * animationValue / 1,
                              child: const Icon(
                                Icons.keyboard_arrow_up_outlined,
                                size: 30,
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                            )
                          ],
                        ),
                      ));
                },
                content: _formularioTarjeta(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tarjetasList(BuildContext context, List<Tarjeta> tarjetas) {
    return SizedBox(
        //height: MediaQuery.of(context).size.height,
        child: ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return _tarjetasAsociadas(context, tarjetas.elementAt(index));
      },
      itemCount: tarjetas.length,
    ));
  }

  Widget _tarjetasAsociadas(BuildContext context, Tarjeta tarjeta) {
    return RadioButton(
      description: tarjeta.noTarjeta,
      value: tarjeta.id.toString(),
      groupValue: _singleValue,
      onChanged: (value) => setState(() {
        _singleValue = value as String;
        print(value);
        tarjetaSeleccionada = tarjeta.id.toString();
      }),
      activeColor: const Color.fromARGB(255, 134, 122, 210),
      textStyle: const TextStyle(fontSize: 15, color: Colors.white),
    );
  }

  Widget _formularioTarjeta(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Nombre del titular',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 47,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color.fromARGB(0, 243, 243, 243),
                    border: Border.all(
                        color: const Color.fromARGB(244, 134, 122, 210),
                        width: 1)),
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: nombreTitularController,
                  decoration: const InputDecoration(
                    labelText: 'Ingresa el nombre del titular',
                    labelStyle: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(125, 255, 255, 255)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(244, 134, 122, 210))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(244, 134, 122, 210))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                  ),
                  onSaved: (String? value) {},
                  validator: (value) {
                    return (value == null || value.isEmpty)
                        ? 'Write a name'
                        : null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Número de tarjeta',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 47,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color.fromARGB(0, 243, 243, 243),
                    border: Border.all(
                        color: const Color.fromARGB(244, 134, 122, 210),
                        width: 1)),
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(15)
                  ],
                  style: const TextStyle(color: Colors.white),
                  controller: numTarjetaController,
                  decoration: const InputDecoration(
                    labelText: 'Número de tarjeta',
                    labelStyle: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(125, 255, 255, 255)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(244, 134, 122, 210))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(244, 134, 122, 210))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                  ),
                  onSaved: (String? value) {},
                  validator: (value) {
                    return (value == null || value.isEmpty)
                        ? 'Write a name'
                        : null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Fecha de vencimiento',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 20),
                width: 200,
                child: DateTimeField(
                  style: const TextStyle(
                      color: Color.fromARGB(226, 255, 255, 255), fontSize: 13),
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
                  controller: fechaVencimientoController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
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
                          ? 'Fecha de vencimiento'
                          : DateFormat.EEEE(selectedDate).toString()),
                ),
              ),
              boton_compra(context)
            ],
          )),
    );
  }

  Widget _resumen(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 47, 44, 68),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        height: 220,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.domain,
                    color: Colors.white,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      widget.nombreCine + " - " + widget.nombreSala,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cineInfo('Hora', widget.hora.replaceRange(4, 7, '')),
                    cineInfo('Fecha',
                        DateFormat.MMMd().format(DateTime.parse(widget.fecha))),
                    cineInfo(
                        'Entrada',
                        widget.formato[0] +
                            widget.formato.toLowerCase().substring(1))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Lugares',
                      style: TextStyle(
                          color: Color.fromARGB(113, 212, 212, 212),
                          fontSize: 14),
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        height: 15,
                        width: 250,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.asientosSeleccionados.length,
                            itemBuilder: (context, index) {
                              var num = widget.asientosSeleccionados
                                  .elementAt(index)
                                  .num
                                  .toString();
                              var fila = widget.asientosSeleccionados
                                  .elementAt(index)
                                  .fila
                                  .toString();

                              return Text("$fila - $num,  ",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14));
                            }))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                          color: Color.fromARGB(113, 212, 212, 212),
                          fontSize: 14),
                    ),
                    Container(
                      child: Row(
                        children: [
                          const Text('17.00€',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget cineInfo(String infoEstatica, String info) {
    return Container(
      width: 98,
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(50, 253, 253, 253)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            infoEstatica,
            style: const TextStyle(
                color: Color.fromARGB(113, 212, 212, 212), fontSize: 13),
          ),
          Text(
            info,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          )
        ],
      ),
    );
  }

  Widget boton_compra(BuildContext context) {
    String show = "";
    String cine = "";
    String asiento = "";
    String tarjeta = "";
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      height: 47,
      decoration: BoxDecoration(
          color: const Color(0xFF867AD2),
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
          onPressed: () {
            for (var element in widget.asientosSeleccionados) {
              final createReservaDto = ReservaItemDto(
                showId: widget.idShow,
                cineId: widget.idCine,
                asientoId: element.asientoId.toString(),
                tarjetaId: tarjetaSeleccionada,
                //TODO: si existe la tarjeta que la seleccione, si no creala 1 vez
                no_tarjeta: numTarjetaController.text,
                fecha_cad: fechaVencimientoController.text,
                titular: nombreTitularController.text,
              );
              BlocProvider.of<CreateReservaBloc>(context)
                  .add(CreateReserva(createReservaDto));

              print(createReservaDto.toJson().toString());
            }
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
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            ],
          )),
    );
  }
}
