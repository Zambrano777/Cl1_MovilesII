// ignore: file_names
class ClienteObject {
  int? codigoServicio;
  String? nombreCliente;
  String? numeroOrdenServicio;
  String? fechaProgramada;
  String? linea;
  String? estado;
  String? observaciones;
  bool? eliminado;
  int? codigoError;
  String? descripcionError;
  String? mensajeError;

  void inicializar() {
    codigoServicio = 0;
    nombreCliente = "";
    numeroOrdenServicio = "";
    fechaProgramada = "";
    linea = "";
    estado = "";
    observaciones = "";
    eliminado = true;
    codigoError = 0;
    descripcionError = "";
    mensajeError = "";
  }

  ClienteObject(
      {this.codigoServicio,
      this.nombreCliente,
      this.numeroOrdenServicio,
      this.fechaProgramada,
      this.linea,
      this.estado,
      this.observaciones});

  factory ClienteObject.fromJson(Map<String, dynamic> json) {
    return ClienteObject(
        codigoServicio: json["CodigoServicio"],
        nombreCliente: json["NombreCliente"],
        numeroOrdenServicio: json["NumeroOrdenServicio"],
        fechaProgramada: json["FechaProgramada"],
        linea: json["Linea"],
        estado: json["Estado"],
        observaciones: json["Observaciones"]);
  }
}
