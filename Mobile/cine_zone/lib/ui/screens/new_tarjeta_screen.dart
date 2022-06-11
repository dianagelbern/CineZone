import 'package:cine_zone/bloc/create_tarjeta_bloc/create_tarjeta_bloc.dart';
import 'package:cine_zone/models/tarjeta/tarjeta_dto.dart';
import 'package:cine_zone/repository/tarjeta_repository/tarjeta_repository.dart';
import 'package:cine_zone/repository/tarjeta_repository/tarjeta_repository_impl.dart';
import 'package:cine_zone/ui/screens/wallet_screen.dart';
import 'package:cine_zone/ui/widgets/error_page.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class NewTarjetaScreen extends StatefulWidget {
  const NewTarjetaScreen({Key? key}) : super(key: key);

  @override
  State<NewTarjetaScreen> createState() => _NewTarjetaScreenState();
}

class _NewTarjetaScreenState extends State<NewTarjetaScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreTitularController = TextEditingController();
  TextEditingController numTarjetaController = TextEditingController();
  TextEditingController fechaVencimientoController = TextEditingController();
  late TarjetaRepository tarjetaRepository;
  late CreateTarjetaBloc _createTarjetaBloc;
  DateTime? selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tarjetaRepository = TarjetaRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => (CreateTarjetaBloc(tarjetaRepository)),
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
          title: const Text('Registrar tarjeta'),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: _createBody(context),
        )),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return BlocConsumer<CreateTarjetaBloc, CreateTarjetaState>(
      listenWhen: (context, state) {
        return state is CreateTarjetaSuccesState ||
            state is CreateTarjetaErrorState;
      },
      listener: (context, state) {
        if (state is CreateTarjetaSuccesState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WalletScreen()),
          );
          final snackBar = SnackBar(
            backgroundColor: Color(0xFF867AD2),
            content: const Text(
              'Nueva tarjeta añadida con éxito',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            ),
            action: SnackBarAction(
              label: 'Entendido',
              textColor: Colors.white,
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is CreateTarjetaErrorState) {
          /*
          ErrorPage(
              message: state.message,
              retry: () {
                context.watch<CreateTarjetaBloc>()
                  ..add(CreateTarjeta(tarjetaDto));
              });
          */
        }
      },
      buildWhen: (context, state) {
        return state is CreateTarjetaInitial;
      },
      builder: (context, state) {
        if (state is CreateTarjetaInitial) {
          return _formulario(context);
        } else {
          return _formulario(context);
        }
      },
    );
  }

  Widget _formulario(BuildContext context) {
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
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime.now());
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
              boton_registro(context)
            ],
          )),
    );
  }

  Widget boton_registro(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      height: 47,
      decoration: BoxDecoration(
          color: const Color(0xFF867AD2),
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
          onPressed: () {
            final createTarjeta = TarjetaDto(
              noTarjeta: numTarjetaController.text,
              fechaCad: fechaVencimientoController.text,
              titular: nombreTitularController.text,
            );
            BlocProvider.of<CreateTarjetaBloc>(context)
                .add(CreateTarjeta(createTarjeta));
            print(createTarjeta.toJson().toString());
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Registar",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          )),
    );
  }
}
