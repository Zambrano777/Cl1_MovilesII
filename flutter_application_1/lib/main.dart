import 'package:flutter/material.dart';
import 'package:flutter_application_1/ListadoClientes.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // ignore: prefer_const_constructors
      home: MyHomePage(title: 'Listado de Clientes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: unused_element
  void _cargarPaginaClientes() {
    Navigator.of(context).push(
        // ignore: prefer_void_to_null
        MaterialPageRoute<Null>(builder: (BuildContext pContexto) {
      // ignore: unnecessary_new
      return new ListadoClientes("Listado Clientes");
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API REST"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              Navigator.of(context).push(
                  // ignore: prefer_void_to_null
                  MaterialPageRoute<Null>(builder: (BuildContext pContexto) {
                return ListadoClientes("Consulta de Cliente");
              }));
            },
          )
        ],
      ),
    );
  }
}
