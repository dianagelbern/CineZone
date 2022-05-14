import 'dart:io';
import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:cine_zone/bloc/reserva_bloc/reserva_bloc.dart';
import 'package:cine_zone/models/reserva/reservas_response.dart';
import 'package:cine_zone/repository/reserva_repository/reserva_repository.dart';
import 'package:cine_zone/repository/reserva_repository/reserva_repository_impl.dart';
import 'package:cine_zone/ui/screens/menu_screen.dart';
import 'package:cine_zone/ui/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  late ReservaRepository reservaRepository;

  String get page => '0';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reservaRepository = ReservaRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ReservaBloc(reservaRepository)..add(FetchReservaWithPage(page));
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
          title: Text('Tickets'),
        ),
        body: _createTicketView(context),
      ),
    );
  }

  Widget _createTicketView(BuildContext context) {
    return BlocBuilder<ReservaBloc, ReservaState>(builder: (context, state) {
      if (state is ReservaInitial) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      } else if (state is ReservaFetchError) {
        return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<ReservaBloc>()..add(FetchReservaWithPage(page));
            });
      } else if (state is ReservaFetched) {
        return _ticketList(
            context, state.reservas.map((e) => e as Reserva).toList());
      } else {
        return Text('Not support');
      }
    });
  }

  Widget _ticketList(BuildContext context, List<Reserva> reservas) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _ticketCard(context, reservas.elementAt(index));
      },
      itemCount: reservas.length,
    );
  }

  /*
  Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2F2C44),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        leadingWidth: 100,
        title: Text('Tickets'),
      ),
      body: _ticketCard(),
    );
  */

  Widget _ticketCard(BuildContext context, Reserva reserva) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text('Fecha y hora: ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  //reserva.fecha
                  child: Text(
                      DateFormat.yMd()
                          .add_jm()
                          .format(DateTime.parse('${reserva.fecha}')),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: BarcodeWidget(
              barcode: Barcode.code128(), // Barcode type and settings
              data: reserva.id,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              color: Colors.white, // Content
              width: 380,
              height: 80,
            ),
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(reserva.sala,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14)),
                    ),
                    Text(reserva.movie,
                        style: TextStyle(color: Colors.white, fontSize: 13))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(reserva.butaca,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14))),
                    Container(
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 50),
                              child: Text("Formato",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13))),
                          Text(reserva.formato,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.centerLeft,
              child: Text(reserva.cine,
                  style: TextStyle(color: Colors.white, fontSize: 13))),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: const Divider(
              height: 3,
              color: Color.fromARGB(255, 73, 73, 73),
            ),
          )
        ],
      ),
    );
  }
}
