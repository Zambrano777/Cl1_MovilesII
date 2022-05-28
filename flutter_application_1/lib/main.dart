// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Office Food',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Office Food'),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  String nombre = "";
  String pedido = "";
  double precio = 0;
  double cantidad = 0;
  bool isSwichet = true;
  String mensaje = "";
  double total = 0;
  double descuento = 0;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controlador1 = TextEditingController();
  final controlador2 = TextEditingController();
  final controlador3 = TextEditingController();
  final controlador4 = TextEditingController();

  void calcular() {
    setState(() { 
      widget.precio = double.parse(controlador3.text);
      widget.cantidad = double.parse(controlador4.text);

      if(widget.precio > 500){
          widget.total = (widget.cantidad * widget.precio);
          widget.total = widget.total - (widget.total * 0.05);
          widget.descuento = (widget.total * 0.05);
          widget.mensaje = "El total a pagar es: " + widget.total.toString() + " y Descuento es: " + widget.descuento.toString();
      }else if(widget.isSwichet){
          widget.total = (widget.cantidad * widget.precio);
          widget.total = widget.total + 20;
          widget.mensaje = "El total a pagar es: " + widget.total.toString();
      }else if (widget.isSwichet && widget.precio > 500) {
        widget.total = (widget.cantidad * widget.precio);
        widget.total = widget.total + 20;
        widget.total = widget.total - (widget.total * 0.05);
        widget.descuento = (widget.total * 0.05);
        widget.mensaje = "El total a pagar es: " + widget.total.toString() + " y Descuento es: " + widget.descuento.toString();
      }else{
        widget.total = (widget.cantidad * widget.precio);
        widget.mensaje = "El total a pagar es: " + widget.total.toString();
      }
    });
  }

  void _showAlert(String value) {
    AlertDialog dialog = new AlertDialog(
      content: new Text(value),
    );
    showDialog(builder: (context) => dialog, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("" + widget.title),
      ),
      body: Center(
          child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: const Text("Llene los datos y presione calcular"),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: <Widget>[
                TextField(
                    controller: controlador1,
                    decoration: const InputDecoration(
                        hintText: "Ingresar Nombres y Apellidos",
                        labelText: "Nombres y Apellidos",
                        )),
                TextField(
                    controller: controlador2,
                    decoration: const InputDecoration(
                        hintText: "Ingresar Pedido",
                        labelText: "Pedido",
                       )),
                TextField(
                    controller: controlador3,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        hintText: "Ingresar Precio",
                        labelText: "Precio",
                      )),
                TextField(
                    controller: controlador4,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        hintText: "Ingresar Cantidad",
                        labelText: "Cantidad",
                       )),
                Switch(value: widget.isSwichet, onChanged: (bool s){
                  setState(() {
                    widget.isSwichet = s;
                    
                  });
                }),

                const Text("Registrar"),
                // ignore: deprecated_member_use
                RaisedButton(
                  child: const Text(
                    "Guardar",
                    style: TextStyle(fontSize: 18, fontFamily: "rbold"),
                  ),
                  onPressed: () {
                    calcular();
                    _showAlert(widget.mensaje);
                    controlador1.clear();
                    controlador2.clear();
                    controlador3.clear();
                    controlador4.clear();
                  },
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
