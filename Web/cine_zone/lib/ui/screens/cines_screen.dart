import 'package:cine_zone/bloc/get_cines_bloc/get_cines_bloc.dart';

import 'package:cine_zone/models/cine/cine_response.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository_impl.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

//List<Cine> _paginatedCines = [];
//List<Cine> _cines = [];
//int _rowsPerPage = 10;
//List<Cine> cinesData = [];

class CinesScreen extends StatefulWidget {
  const CinesScreen({Key? key}) : super(key: key);

  @override
  State<CinesScreen> createState() => _CinesScreenState();
}

class _CinesScreenState extends State<CinesScreen> {
  TextEditingController searchController = TextEditingController();
  final key = new GlobalKey<PaginatedDataTableState>();
  var _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  late CinesResponse _cine;

  late GetCinesBloc _getCinesBloc;
  late CineRepository cineRepository;

  //CineDataSource? cineDataSource;
  int page = 0;
  List<Cine> cinesData = [];
  /*
  
  List<Cine> cines = <Cine>[];


  List<DataGridRow> dataGridRows = [];
  final double _dataPagerHeight = 60.0;
  */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cineRepository = CineRepositoryImpl();
    _getCinesBloc = GetCinesBloc(cineRepository)..add(DoGetCinesEvent("$page"));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getCinesBloc,
      child: Scaffold(
        body: Column(
          children: [
            _opciones(),
            _blocBuilderCines(context),
          ],
        ),
      ),
    );
  }

  _blocBuilderCines(BuildContext context) {
    return BlocBuilder<GetCinesBloc, GetCinesState>(
      builder: (context, state) {
        if (state is GetCinesInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetCinesErrorState) {
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
        } else if (state is GetCinesSuccessState) {
          //cineDataSource = CineDataSource(cineData: state.cineList);
          //cinesData = state.cineList;
          return _tabla(context, state.cineList);
          //_tabla(context, CineDataSource(cineData: state.cineList));
        } else {
          return Text("");
        }
      },
    );
  }

  Widget _tabla(BuildContext context, CinesResponse cines) {
    cinesData = cines.content;
    return Container(
      width: 1000,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          PaginatedDataTable(
            key: key,
            source: CineDataSource(cineData: cinesData),
            columns: const [
              DataColumn(
                  label: Text(
                'ID',
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              )),
              DataColumn(
                  label: Text('Nombre del cine',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 14))),
              DataColumn(
                  label: Text('Dirección',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 14))),
              DataColumn(
                  label: Text('Latitud-Longitud',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 14))),
              DataColumn(
                  label: Text('Plaza',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 14))),
              DataColumn(
                  label: Text('Más',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 14))),
            ],
            columnSpacing: 100,
            horizontalMargin: 10,
            rowsPerPage: _rowsPerPage,
            initialFirstRowIndex: 0,
            showCheckboxColumn: false,
            arrowHeadColor: Color(0xFF848484),
            onPageChanged: (int n) {
              //cines.last != false
              setState(() {
                if (page != null) {
                  if (CineDataSource(cineData: cinesData)._rowCount - page <
                      _rowsPerPage) {
                    _rowsPerPage =
                        CineDataSource(cineData: cinesData)._rowCount - page;
                  } else {
                    _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
                  }
                } else {
                  _rowsPerPage = 0;
                }
              });
            },

            /*
            onPageChanged: (int n) {
              BlocProvider.of<GetCinesBloc>(context)
                  .add(DoGetCinesEvent(n.toString()));
              //setState(() {});
              key.currentState!.pageTo(n);
              setState(() {
                page = page + 1;
              });
            },
            */
          ),
        ],
      ),
    );
  }

  /*
  _tabla(BuildContext context, CineDataSource cineDataSource) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          margin: EdgeInsets.all(30),
          child: SfDataGrid(
            footer: Row(children: [
              ElevatedButton(
                  onPressed: () {
                    if (page >= 0) {
                      setState(() {
                        page--;
                      });
                    }
                  },
                  child: Text("<-")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      page = page + 1;
                    });
                    BlocProvider.of<GetCinesBloc>(context)
                        .add(DoGetCinesEvent("$page"));
                    print("Pulsado, $page");
                  },
                  child: Text("->"))
            ]),
            source: cineDataSource,
            columnWidthMode: ColumnWidthMode.fill,
            allowMultiColumnSorting: true,
            columns: <GridColumn>[
              GridColumn(
                  columnName: 'ID',
                  label: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: Text(
                        'ID',
                      ))),
              GridColumn(
                  columnName: 'Nombre',
                  label: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text('Nombre'))),
              GridColumn(
                  columnName: 'Direccion',
                  label: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(
                        'Direccion',
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                  columnName: 'Plaza',
                  label: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text('Plaza'))),
            ],
            selectionMode: SelectionMode.single,
            rowsPerPage: 10,
          ),
        )
      ],
    );
  }

  */

  Widget _opciones() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 50),
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Text(
              "Cines",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          Container(
            child: Row(
              children: [_search(), _boton()],
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
          hintText: 'Buscar cine',
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
          return (value == null || value.isEmpty)
              ? 'Escribe el nombre del cine'
              : null;
        },
      ),
    );
  }

  Widget _boton() {
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
        onPressed: () {},
        child: Text(
          'Añadir cine',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class CineDataSource extends DataTableSource {
  CineDataSource({required List<Cine> cineData}) {
    _cineData = cineData;
  }
  List<Cine> _cineData = [];
  final _rowCount = 10;

  @override
  DataRow? getRow(int index) {
    if (index < _rowCount) {
      return DataRow(
        onLongPress: () =>
            print("Seleccionada toda la fila ${_cineData[index].id}"),
        cells: [
          DataCell(Text(_cineData[index].id.toString())),
          DataCell(Text(_cineData[index].nombre)),
          DataCell(Text(_cineData[index].direccion.toString())),
          DataCell(Text(_cineData[index].latLon.toString())),
          DataCell(Text(_cineData[index].plaza.toString())),
          DataCell(Row(
            children: [
              TextButton(
                  onPressed: () {
                    print("seleccionado ${_cineData[index].id}");
                  },
                  child: Icon(
                    Icons.edit,
                    color: Color(0xFF624DE3),
                  )),
            ],
          ))
        ],
      );
    } else {
      return null;
    }
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => true;

  @override
  // TODO: implement rowCount
  int get rowCount => _rowCount;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
