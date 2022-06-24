// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter_application_1/ClienteObject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/NuevoCliente.dart';
import 'package:http/http.dart' as http;
import 'package:json_table/json_table.dart';

// ignore: must_be_immutable
class ListadoClientes extends StatefulWidget {
  List<ClienteObject> oListaClientes = [];
  int codigoClienteSeleccionado = 0;
  String urlGeneral = 'http://wscibertec2022.somee.com';
  String urlController = '/Servicio/';
  String urlListado = '/Listar?NombreCliente=';
  String jsonCliente =
      '[{"CodigoServicio": 0,"NombreCliente": "","NumeroOrdenServicio": "","FechaProgramada": "","Linea": "","Estado": "","Observaciones": ""}]';
  // ignore: use_key_in_widget_constructors
  String titulo;
  // ignore: use_key_in_widget_constructors
  ListadoClientes(this.titulo);

  @override
  _ListadoClientes createState() => _ListadoClientes();
}

class _ListadoClientes extends State<ListadoClientes> {
  final _tfNombre = TextEditingController();
  bool toggle = true;

  @override
  void initState() {
    super.initState();
  }

  Future<String> _consultarClientes() async {
    // ignore: unused_local_variable
    try {
      String urlListaClientes = widget.urlGeneral +
          widget.urlController +
          widget.urlListado +
          _tfNombre.text.toString();
      var respuesta = await http.get(Uri.parse(urlListaClientes));
      // ignore: unused_local_variable
      var data = respuesta.body;
      // ignore: unused_local_variable
      var oLista = List<ClienteObject>.from(
          json.decode(data).map((x) => ClienteObject.fromJson(x)));

      for (ClienteObject item in oLista) {
        print("Nombres " + item.nombreCliente.toString());
      }
      setState(() {
        widget.oListaClientes = oLista;
        widget.jsonCliente = data;

        if (widget.oListaClientes.isEmpty) {
          widget.jsonCliente =
              '[{"CodigoServicio": 0,"NombreCliente": "","NumeroOrdenServicio": "","FechaProgramada": "","Linea": "","Estado": "","Observaciones": "","Eliminado": true, "CodigoError": 0,"DescripcionError": "","MensajeError": ""}]';
        }
      });
    } catch (e) {
      return e.toString();
    }

    return "Procesado";
  }

  void _verRegistroCliente(int codigo) {
    Navigator.of(context).push(
     
        // ignore: prefer_void_to_null
        MaterialPageRoute<Null>(builder: (BuildContext pContexto) {
      // ignore: unnecessary_new
      return NuevoCliente("", codigo);
    }));

  }

  void _nuevoCliente() {
    Navigator.of(context).push(
        // ignore: prefer_void_to_null
        MaterialPageRoute<Null>(builder: (BuildContext pContexto) {
      // ignore: unnecessary_new
      return new NuevoCliente("", widget.codigoClienteSeleccionado);
    }));
  }

  @override
  Widget build(BuildContext context) {
    var json = jsonDecode(widget.jsonCliente);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Consulta de Clientes",
            style: TextStyle(fontSize: 14),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Llenar Nombre para consultar",
                style: TextStyle(fontSize: 12),
              ),
              TextField(
                  controller: _tfNombre,
                  decoration: const InputDecoration(
                      hintText: "Ingrese el nombre", labelText: "Nombre")),
              Text("Se encontraron " +
                  widget.oListaClientes.length.toString() +
                  " Clientes"),
              Table(
                children: [
                  TableRow(children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10.0),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        color: Colors.greenAccent,
                        child: const Text(
                          "Consultar",
                          style: TextStyle(fontSize: 10, fontFamily: "rbold"),
                        ),
                        onPressed: () {
                          _consultarClientes();
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 10.0),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        color: Colors.greenAccent,
                        child: const Text(
                          "Registrar",
                          // ignore: unnecessary_const
                          style: TextStyle(fontSize: 10, fontFamily: "rbold"),
                        ),
                        onPressed: () {
                          _nuevoCliente();
                        },
                      ),
                    )
                  ])
                ],
              ),
              JsonTable(
                json,
                columns: [
                  JsonTableColumn("CodigoServicio", label: "CodigoServicio"),
                  JsonTableColumn("NombreCliente", label: "NombreCliente"),
                  JsonTableColumn("NumeroOrdenServicio", label: "NumeroOrdenServicio"),
                  JsonTableColumn("FechaProgramada", label: "FechaProgramada"),
                  JsonTableColumn("Linea", label: "Linea"),
                  JsonTableColumn("Estado", label: "Estado"),
                  JsonTableColumn("Observaciones", label: "Observaciones"),
                ],
                showColumnToggle: true,
                allowRowHighlight: true,
                rowHighlightColor: Colors.yellow[500]!.withOpacity(0.7),
                paginationRowCount: 10,
                onRowSelect: (index, map) {
                 // widget.codigoClienteSeleccionado =
                      
                  //print("demo" + map["CodigoServicio"].toString());

                  /*Navigator.of(context).push(
                      // ignore: prefer_void_to_null
                      MaterialPageRoute<Null>(
                          builder: (BuildContext pContexto) {
                    // ignore: unnecessary_new
                    return new NuevoCliente(
                        "CodigoServicio", widget.codigoClienteSeleccionado);
                  }));*/
                  //print(widget.codigoClienteSeleccionado);
                  _verRegistroCliente(int.parse(map["CodigoServicio"].toString()));
                  print(index);
                  print(map);
                },
              )
            ],
          ),
        ));
  }
}
