// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import '../models/cliente_model.dart';
import '../providers/cliente_provider.dart';
import './nuevo_cliente.dart';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:json_table/json_table.dart';

class listadoVEN_Cliente extends StatefulWidget {
  String titulo;
  final _provider = VEN_ClienteProvider();
  List<Cliente> oListaVEN_Cliente = [];
  int codigoVEN_ClienteSeleccionado = 0;
  Cliente oCliente = Cliente();
  String jSonVEN_Cliente = "";
  listadoVEN_Cliente(this.titulo);
  @override
  State<StatefulWidget> createState() => _ListadoVEN_Cliente();
}

class _ListadoVEN_Cliente extends State<listadoVEN_Cliente> {
  final _tfNombreCliente = TextEditingController();
 
  @override
  void initState() {
    super.initState();
    widget.oCliente.inicializar();
    widget.jSonVEN_Cliente = '[${widget.oCliente.toModelString()}]';
  }

  Future<String> _consultarRegistros() async {
    Cliente pCliente = Cliente();
    pCliente.inicializar();
    pCliente.nombreCliente = _tfNombreCliente.text;

    var oListaVEN_ClienteTmp = await widget._provider.listar(pCliente);
    // ignore: avoid_print
    print(oListaVEN_ClienteTmp);
    setState(() {
      widget.oListaVEN_Cliente = oListaVEN_ClienteTmp;
      widget.jSonVEN_Cliente = widget._provider.jsonResultado;
      if (widget.oListaVEN_Cliente.isEmpty) {
        widget.jSonVEN_Cliente = '[${widget.oCliente.toModelString()}]';
      }
    });
    return "Procesado";
  }

  void _nuevoRegistro() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext pContexto) {
      return NuevoVEN_Cliente("", 0);
    }));
  }

  void _verRegistro(int pCodigoCliente) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext pContexto) {
      return NuevoVEN_Cliente("", pCodigoCliente);
    }));
  }

  @override
  Widget build(BuildContext context) {
    var json = jsonDecode(widget.jSonVEN_Cliente);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Consulta de Clientes "),
          actions: [
            IconButton(
                icon: const Icon(Icons.search), onPressed: _consultarRegistros),
            IconButton(
                icon: const Icon(Icons.assignment_outlined),
                onPressed: _nuevoRegistro),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Para consultar completar el nombre del cliente y dar click en consultar",
                style: TextStyle(fontSize: 12),
              ),
              TextField(
                  controller: _tfNombreCliente,
                  decoration: const InputDecoration(
                    hintText: "Ingrese Nombre",
                    labelText: "RazonSocial",
                  )),
              Text(
                "Se encontraron " +
                    widget.oListaVEN_Cliente.length.toString() +
                    " Clientes",
                style: const TextStyle(fontSize: 9),
              ),
              JsonTable(
                json,
                columns: [
                  JsonTableColumn("CodigoServicio", label: "CodigoCliente"),
                  JsonTableColumn("NombreCliente", label: "NombreCliente"),
                  JsonTableColumn("NumeroOrdenServicio", label: "NumeroOrdenServicio"),
                  JsonTableColumn("FechaProgramada", label: "FechaProgramada"),
                  JsonTableColumn("Linea", label: "Linea"),
                  JsonTableColumn("Estado", label: "Estado"),
                  JsonTableColumn("Observaciones", label: "Observaciones"),
                ],
                showColumnToggle: false,
                allowRowHighlight: true,
                rowHighlightColor: Colors.yellow[500]!.withOpacity(0.7),
                paginationRowCount: 10,
                onRowSelect: (index, map) {
                  _verRegistro(int.parse(map["CodigoServicio"].toString()));
                },
              ),
            ],
          ),
        ));
  }
}
