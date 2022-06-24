// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:convert';
import 'package:flutter_application_1/ClienteObject.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


// ignore: must_be_immutable
class NuevoCliente extends StatefulWidget {
  ClienteObject oCliente = ClienteObject(
      codigoServicio: 0,
      nombreCliente: "",
      numeroOrdenServicio: "",
      fechaProgramada: "",
      linea: "",
      estado: "",
      observaciones: "");
  String titulo;
  int codigoClienteSeleccionado = 0;
  String urlGeneral = 'http://wscibertec2022.somee.com';
  String urlController = '/Servicio/';
  String urlListarKey = '/Listar?CodigoServicio=';
  
  bool validacion = false;
  String mensaje = "";

  // ignore: use_key_in_widget_constructors
  NuevoCliente(this.titulo, this.codigoClienteSeleccionado);

  @override
  _NuevoCliente createState() => _NuevoCliente();
}

class _NuevoCliente extends State<NuevoCliente> {
  final _tfNombre = TextEditingController();
  final _tfNumeroOrdenServicio = TextEditingController();
  final _tfFecha = TextEditingController();
  final _tfLinea = TextEditingController();
  final _tfEstado = TextEditingController();
  final _tfObservaciones = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.codigoClienteSeleccionado > 0) {
      _listarKey();
    }
  }

  Future<String> _listarKey() async {
    try {
      String urlListaClientes = widget.urlGeneral +
          widget.urlController +
          widget.urlListarKey +
          widget.codigoClienteSeleccionado.toString();
      var respuesta = await http.get(Uri.parse(urlListaClientes));
      setState(() {
        widget.oCliente = ClienteObject.fromJson(json.decode(respuesta.body));
        if (widget.oCliente.codigoServicio! > 0) {
          widget.mensaje = "Actualizando datos";
          print(widget.mensaje);
          _mostrarDatos();
        }
        print(widget.oCliente);
      });
    } catch (e) {
      return e.toString();
    }
    return "Procesado";
  }

  void _mostrarDatos() {
    _tfNombre.text = widget.oCliente.nombreCliente!.toString();
    _tfNumeroOrdenServicio.text = widget.oCliente.numeroOrdenServicio!.toString();
    _tfFecha.text = widget.oCliente.fechaProgramada!.toString();
    _tfLinea.text = widget.oCliente.linea!.toString();
    _tfEstado.text = widget.oCliente.estado!.toString();
    _tfObservaciones.text = widget.oCliente.observaciones!.toString();
  }

  /*bool _validarRegistro() {
    if (_tfNombre.text.toString() == "" ||
        _tfEstado.text.toString() == "" ||
        _tfFecha.text.toString() == "" ||
        _tfLinea.text.toString() == "" ||
        _tfNumeroOrdenServicio.text.toString() == "" ||
        _tfObservaciones.text.toString() == "") {
      widget.validacion = false;
      setState(() {
        widget.mensaje = "Falta ingresar los campos";
      });
      return false;
    }
    return true;
  }*/

  void _grabarRegistro() {

      _ejecutarServicioGrabar();
    
  }

  Future<String> _ejecutarServicioGrabar() async {
    try {
      String accion = "N";

      if (widget.oCliente.codigoServicio! > 0) {
        accion = "A";
      }
      String strParametros = "/RegistraModifica?";
      strParametros += "Accion=" + accion;
      strParametros += "&CodigoServicio=" + widget.oCliente.codigoServicio.toString();
      strParametros += "&NombreCliente=" + _tfNombre.text;
      strParametros += "&NumeroOrdenServicio=" + _tfNumeroOrdenServicio.text;
      strParametros += "&FechaProgramada=" + _tfFecha.text;
      strParametros += "&Linea=" + _tfLinea.text;
      strParametros += "&Estado=" + _tfEstado.text;
      strParametros += "&Observaciones=" + _tfObservaciones.text;
     

      String urlRegistro = "";
      urlRegistro = widget.urlGeneral +
          widget.urlController +
          strParametros;
          print(urlRegistro);
      var respuesta = await http.get(Uri.parse(urlRegistro));
      var data = respuesta.body;
      setState(() {
        widget.oCliente = ClienteObject.fromJson(json.decode(data));
        if (widget.oCliente.codigoServicio! > 0) {
          widget.mensaje = "Registrado Correctamente";
        }
        print(widget.oCliente);
      });
    } catch (e) {
      print(e);
    }
    return widget.mensaje;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Clientes " + widget.titulo.toString()),
      ),
      body: ListView(
        children: [
          Container(
            // ignore: prefer_const_constructors
            padding: EdgeInsets.all(10),
            child: Text("Codigo de Cliente: " +
                widget.oCliente.codigoServicio.toString()),
          ),
          Container(
            // ignore: prefer_const_constructors
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: <Widget>[
                TextField(
                    controller: _tfNombre,
                    decoration: const InputDecoration(
                      hintText: "Ingresar Nombre",
                      labelText: "Nombre",
                    )),
                TextField(
                    controller: _tfNumeroOrdenServicio,
                    decoration: const InputDecoration(
                      hintText: "Ingresar Orden",
                      labelText: "Orden",
                    )),
                TextField(
                    controller: _tfFecha,
                    decoration: const InputDecoration(
                      hintText: "Ingresar Fecha",
                      labelText: "Fecha",
                    )),
                TextField(
                    controller: _tfLinea,
                    decoration: const InputDecoration(
                      hintText: "Ingresar Linea",
                      labelText: "Linea",
                    )),
                TextField(
                    controller: _tfEstado,
                    decoration: const InputDecoration(
                      hintText: "Ingresar Estado",
                      labelText: "Estado",
                    )),
                TextField(
                    controller: _tfObservaciones,
                    decoration: const InputDecoration(
                      hintText: "Ingresar Observaciones",
                      labelText: "Observaciones",
                    )),
                RaisedButton(
                  color: Colors.greenAccent,
                  child: const Text(
                    "Grabar",
                    style: TextStyle(fontSize: 18, fontFamily: "rbold"),
                  ),
                  onPressed: () {
                    _grabarRegistro;
                  },
                ),
                Text("Mensaje: " + widget.mensaje.toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
