// ignore_for_file: must_be_immutable, non_constant_identifier_names, use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';
import '../models/cliente_model.dart';
import '../providers/cliente_provider.dart';

class NuevoVEN_Cliente extends StatefulWidget {
  String titulo;
  Cliente oCliente = Cliente();
  final _provider = VEN_ClienteProvider();
  int codigoVEN_ClienteSeleccionado = 0;
  String mensaje = "";
  bool validacion = false;
  NuevoVEN_Cliente(this.titulo, this.codigoVEN_ClienteSeleccionado);
  @override
  _NuevoVEN_Cliente createState() => _NuevoVEN_Cliente();
}

class _NuevoVEN_Cliente extends State<NuevoVEN_Cliente> {
  final _tfCodigoServicio = TextEditingController();
  final _tfNombre = TextEditingController();
  final _tfNumeroServicio = TextEditingController();
  final _tfFechaProgramada = TextEditingController();
  final _tfLinea = TextEditingController();
  final _tfEstado = TextEditingController();
  final _tfObservaciones = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.oCliente.inicializar();
    if (widget.codigoVEN_ClienteSeleccionado > 0) {
      _listarKeyProvider();
    }
  }

  Future<String> _listarKeyProvider() async {
    Cliente oClienteModel = Cliente();
    oClienteModel.inicializar();
    var oClienteModeltmp =
        await widget._provider.listarKey(widget.codigoVEN_ClienteSeleccionado);

    // ignore: avoid_print
    print(oClienteModeltmp);
    setState(() {
      widget.oCliente = oClienteModeltmp;
      if (widget.oCliente.codigoServicio! > 0) {
        widget.mensaje = "Estas actualizando los datos";
        _mostrarDatos();
      }
    });
    return "Procesado";
  }

  void _mostrarDatos() {
    _tfCodigoServicio.text = widget.oCliente.codigoServicio.toString();
    _tfNombre.text = widget.oCliente.nombreCliente.toString();
    _tfNumeroServicio.text = widget.oCliente.numeroOrdenServicio.toString();
    _tfFechaProgramada.text = widget.oCliente.fechaProgramada.toString();
    _tfLinea.text = widget.oCliente.linea.toString();
    _tfEstado.text = widget.oCliente.estado.toString();
    _tfObservaciones.text = widget.oCliente.observaciones.toString();
  }

  void _cargarEntidad() {
    widget.oCliente.codigoServicio = int.parse(_tfCodigoServicio.text);
    widget.oCliente.nombreCliente = _tfNombre.text;
    widget.oCliente.numeroOrdenServicio = _tfNumeroServicio.text;
    widget.oCliente.fechaProgramada = _tfFechaProgramada.text;
    widget.oCliente.linea = _tfLinea.text;
    widget.oCliente.estado = _tfEstado.text;
    widget.oCliente.observaciones = _tfObservaciones.text;
  }

  bool _validarRegistro() {
    if (_tfCodigoServicio.text.toString() == "") {
      widget.validacion = false;
      setState(() {
        widget.mensaje = "Falta completar CodigoCliente ";
      });
      return false;
    }
    if (_tfNombre.text.toString() == "") {
      widget.validacion = false;
      setState(() {
        widget.mensaje = "Falta completar RazonSocial ";
      });
      return false;
    }
    if (_tfNumeroServicio.text.toString() == "") {
      widget.validacion = false;
      setState(() {
        widget.mensaje = "Falta completar Ruc ";
      });
      return false;
    }
    if (_tfFechaProgramada.text.toString() == "") {
      widget.validacion = false;
      setState(() {
        widget.mensaje = "Falta completar Direccion ";
      });
      return false;
    }
    if (_tfLinea.text.toString() == "") {
      widget.validacion = false;
      setState(() {
        widget.mensaje = "Falta completar Contacto ";
      });
      return false;
    }
    if (_tfEstado.text.toString() == "") {
      widget.validacion = false;
      setState(() {
        widget.mensaje = "Falta completar Telefono ";
      });
      return false;
    }
    if (_tfObservaciones.text.toString() == "") {
      widget.validacion = false;
      setState(() {
        widget.mensaje = "Falta completar Anexo ";
      });
      return false;
    }

    return true;
  }

  void _grabarRegistro() {
    if (_validarRegistro()) {
      _ejecutar_ClienteGrabadoProvider();
    }
  }

  // ignore: non_constant_identifier_names
  Future<String> _ejecutar_ClienteGrabadoProvider() async {
    String accion = "N";
    if (widget.oCliente.codigoServicio! > 0) {
      accion = "A";
    }
    _cargarEntidad();
    Cliente oClienteModeltmp = Cliente();
    oClienteModeltmp.inicializar();
    var oClienteModeltmpReg =
        await widget._provider.registraModifica(widget.oCliente, accion);
    // ignore: avoid_print
    print(oClienteModeltmpReg);
    setState(() {
      widget.oCliente = oClienteModeltmpReg;
      if (widget.oCliente.codigoServicio! > 0) {
        widget.mensaje = "Grabado correctamente";
      }
      // ignore: avoid_print
      print(widget.oCliente);
    });
    return "Procesado";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Registro de Clientes " + widget.titulo),
          actions: [
            IconButton(icon: const Icon(Icons.save), onPressed: _grabarRegistro),
          ],
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(" Código de Cliente:" +
                  widget.oCliente.codigoServicio.toString()),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                children: <Widget>[
                  TextField(
                      controller: _tfNombre,
                      decoration: const InputDecoration(
                        hintText: "Ingrese Nombre",
                        labelText: "NombreCliente",
                      )),
                  TextField(
                      controller: _tfNumeroServicio,
                      decoration: const InputDecoration(
                        hintText: "Numero Orden Servicio",
                        labelText: "Orden",
                      )),
                  TextField(
                      controller: _tfFechaProgramada,
                      decoration: const InputDecoration(
                        hintText: "Fecha Progrmada",
                        labelText: "Fecha",
                      )),
                  TextField(
                      controller: _tfLinea,
                      decoration: const InputDecoration(
                        hintText: "Estado",
                        labelText: "Estado",
                      )),
                  TextField(
                      controller: _tfEstado,
                      decoration: const InputDecoration(
                        hintText: "Ingrese Contacto ",
                        labelText: "Contacto",
                      )),
                  TextField(
                      controller: _tfObservaciones,
                      decoration: const InputDecoration(
                        hintText: "Ingrese Telefono ",
                        labelText: "Telefono",
                      )),
                  Text("Mensaje:" + widget.mensaje),
                ],
              ),
            )
          ],
        ));
  }
}
