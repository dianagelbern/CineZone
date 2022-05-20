import 'package:cine_zone/bloc/tarjeta_bloc/tarjeta_bloc.dart';
import 'package:cine_zone/models/tarjeta/tarjeta_response.dart';
import 'package:cine_zone/repository/tarjeta_repository/tarjeta_repository.dart';
import 'package:cine_zone/repository/tarjeta_repository/tarjeta_repository_impl.dart';
import 'package:cine_zone/ui/screens/menu_screen.dart';
import 'package:cine_zone/ui/widgets/error_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late TarjetaRepository tarjetaRepository;

  String get page => '0';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tarjetaRepository = TarjetaRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TarjetaBloc(tarjetaRepository)..add(FetchTarjetaWithPage(page));
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
          title: Text('Walllet'),
        ),
        body: _createTarjetasView(context),
      ),
    );
  }

  Widget _createTarjetasView(BuildContext context) {
    return BlocBuilder<TarjetaBloc, TarjetaState>(builder: (context, state) {
      if (state is TarjetaInitial) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      } else if (state is TarjetaFetchError) {
        return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<TarjetaBloc>()..add(FetchTarjetaWithPage(page));
            });
      } else if (state is TarjetaFetched) {
        return SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tarjetas y cuentas',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text('+ Añadir',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600)))
                    ],
                  ),
                ),
                _walletList(context, state.tarjetas.map((e) => e).toList()),
              ],
            ),
          ),
        );
      } else {
        return Text('Not support');
      }
    });
  }

  /*
  Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tarjetas y cuentas',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text('+ Añadir',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600)))
                  ],
                ),
              ),
              _walletList(
                  context, state.tarjetas.map((e) => e as Tarjeta).toList()),
              Divider(color: Colors.grey, height: 3),
            ],
          ),
        );
  */

  Widget _walletList(BuildContext context, List<Tarjeta> tarjetas) {
    return Flexible(
      child: Container(
          margin: EdgeInsets.only(bottom: 70),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _walletCard(context, tarjetas.elementAt(index));
            },
            itemCount: tarjetas.length,
          )),
    );
  }

  Widget _walletCard(BuildContext context, Tarjeta tarjeta) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            width: 330,
            height: 212,
            child: Stack(
              children: [
                Container(
                    decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/card1.png"),
                      fit: BoxFit.cover),
                )),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tarjeta.noTarjeta.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 25),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    tarjeta.titular,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 25, right: 90),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    tarjeta.fechaCad,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Eliminar tarjeta',
                style: TextStyle(
                    color: Color(0xFFD74343),
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Divider(color: Colors.grey, height: 3),
          )
        ],
      ),
    );
  }

  Widget suscription() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            width: 330,
            height: 212,
            child: Stack(
              children: [
                Container(
                    decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/suscripcion.png"),
                      fit: BoxFit.cover),
                )),
                Container(
                  margin: EdgeInsets.only(right: 40, bottom: 40),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '5519 1997 1053 4218',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, top: 20),
                  alignment: Alignment.topRight,
                  child: Text(
                    'Fanático',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Eliminar Suscripción',
                style: TextStyle(
                    color: Color(0xFFD74343),
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
