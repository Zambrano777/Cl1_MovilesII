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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controlador1 = TextEditingController();
  final controlador2 = TextEditingController();
  final controlador3 = TextEditingController();
  final controlador4 = TextEditingController();
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
                        hintText: "Ingresar Nombres", labelText: "Nombre")),
                TextField(
                    controller: controlador2,
                    decoration: const InputDecoration(
                        hintText: "Ingresar Apellidos",
                        labelText: "Apellidos")),
                TextField(
                    controller: controlador3,
                    decoration: const InputDecoration(
                        hintText: "Ingresar Edad", labelText: "Edad")),
                TextField(
                    controller: controlador4,
                    decoration: const InputDecoration(
                        hintText: "Ingresar Estado Civil",
                        labelText: "Estado Civil")),
                const Text("Registrar"),
                // ignore: deprecated_member_use
                RaisedButton(
                  child: const Text(
                    "Guardar",
                    style: TextStyle(fontSize: 18, fontFamily: "rbold"),
                  ),
                  onPressed: () {
                     controlador1.clear();
                     controlador2.clear();
                     controlador3.clear();
                     controlador4.clear();
                    _showAlert("[Registrado]");
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
