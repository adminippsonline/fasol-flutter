import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:developer' as dev;

//estas dos creo son para las apis que se consumen
import 'package:http/http.dart' as http;
import 'dart:async';
//Me parece que es para convertir el json
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
//Paqueteria para sesiones tipo cookies
import 'package:shared_preferences/shared_preferences.dart';

import '../menu_lateral.dart';
import '../menu_footer.dart';
import '../Includes/colors/colors.dart';
import 'includes/Desgloce.dart';

import '../PerfilSolicitud/LoginSol.dart';
import 'RegistroSol.dart';

import 'FinSolicitar10.dart';

class Desgloce extends StatefulWidget {
  //const Desgloce({super.key});

  String CantidadGET = "";
  String PeriodoGET = "";
  String PlazoGET = "";
  String direccionIpGET = "";

  Desgloce(
      this.CantidadGET, this.PeriodoGET, this.PlazoGET, this.direccionIpGET);

  @override
  State<Desgloce> createState() => _DesgloceState();
}

class _DesgloceState extends State<Desgloce> {
  //TextStyle EstiloBotones = TextStyle(color: Colors.amber);

  String status = "";
  String MontoSolicitado = "";
  String Etiqueta = "";
  String APagar = "";
  String Cuota = "";
  String TotalAPagar = "";
  String TasaPromedio = "";
  String CatPromedio = "";
  String ComisionPorApertura = "";
  String ComisionPorTardio = "";
  String Resultado = "";

  String statusSession = "";
  String MontoSolicitadoSession = "";
  String EtiquetaSession = "";
  String APagarSession = "";
  String CuotaSession = "";
  String TotalAPagarSession = "";
  String TasaPromedioSession = "";
  String CatPromedioSession = "";
  String ComisionPorAperturaSession = "";
  String ComisionPorTardioSession = "";
  String ResultadoSession = "";

  void initState() {
    super.initState();
    // Ingresar(widget.CantidadGET, widget.PeriodoGET, widget.QuincenalGET,
    //     widget.MensualGET);
    mostrar_datos();
    mostrarDesglose();
  }

  void Enviar() async {
    if (id_LR >= 1) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => FinSolicitar10(idCredito)));
      FocusScope.of(context).unfocus();
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => RegistroSol(idCredito)));
      FocusScope.of(context).unfocus();
    }
  }

  Map<String, dynamic> apiResponse = {};
  Map<String, dynamic> jsonData = {};
  String idCredito = "";

  Future<void> mostrarDesglose() async {
    dev.log(widget.CantidadGET);
    dev.log(widget.PeriodoGET);
    dev.log(widget.PlazoGET);
    dev.log(widget.direccionIpGET);
    var url = Uri.parse(
        "https://fasoluciones.mx/api/Solicitud/SGS/Simular?_token=5MoflIzoklKaQDoafF3eZgpXzSId6FvxIImZzkbm&Cantidad=${widget.CantidadGET}&Periodicidad=${widget.PeriodoGET}&Plazo=${widget.PlazoGET}&AgregarProducto=1&IP=${widget.direccionIpGET}&id_solicitante=0");
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
        idCredito = jsonData['id_credito'];
        dev.log(idCredito);
        Map<String, dynamic> data = jsonData['data'];

        setState(() {
          apiResponse = data;
        });
        // setState(() {
        //   apiResponse = json.decode(response.body);
        // });
      } else {
        print(
            "Error en la solicitud. Código de estado: ${response.statusCode}");
      }
    } catch (error) {
      print("Error en la solicitud: $error");
    }
  }

  void Ingresar(Cantidad, Periodo, Quincenal, Mensual) async {
    try {
      var url =
          Uri.https('fasoluciones.mx', 'ApiApp/Solicitud/SGS/Consultar.php');
      var data = {
        'Cantidad': "$Cantidad",
        'Periodo': Periodo,
        'Quincenal': "$Quincenal",
        'Mensual': "$Mensual",
      };
      var response =
          await http.post(url, body: data).timeout(const Duration(seconds: 90));
      //print("llego aqui 111");
      dev.log(response.body);

      // if (response.body != "0" && response.body != "") {
      //   var Respuesta = jsonDecode(response.body);
      //     print(Respuesta);
      //   String status = Respuesta['status'];
      //   if (status == "OK") {
      //     //print('si existe aqui -----');
      //     /*showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //             title: Text('Registrado correctamente'),
      //           );
      //         }); */

      //     String MontoSolicitado = Respuesta['MontoSolicitado'];
      //     String Etiqueta = Respuesta['Etiqueta'];
      //     String APagar = Respuesta['APagar'];
      //     String Cuota = Respuesta['Cuota'];
      //     String TotalAPagar = Respuesta['TotalAPagar'];
      //     String TasaPromedio = Respuesta['TasaPromedio'];
      //     String CatPromedio = Respuesta['CatPromedio'];
      //     String ComisionPorApertura = Respuesta['ComisionPorApertura'];
      //     String ComisionPorTardio = Respuesta['ComisionPorTardio'];
      //     String Resultado = Respuesta['ComisionPorTardio'];

      //     guardar_datos(
      //       status,
      //       MontoSolicitado,
      //       Etiqueta,
      //       APagar,
      //       Cuota,
      //       TotalAPagar,
      //       TasaPromedio,
      //       CatPromedio,
      //       ComisionPorApertura,
      //       ComisionPorTardio,
      //       Resultado
      //     );

      //   } else {
      //     //print('Error en el registro');
      //     showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //             title: Text('Error en el registro'),
      //           );
      //         });
      //   }
      // }
    } on TimeoutException catch (e) {
      //print('Tardo muco la conexion');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('La conexión tardo mucho'),
            );
          });
    } on Error catch (e) {
      //print('http error');
      dev.log(e.stackTrace.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error: HTTP:// ${e.toString()}'),
            );
          });
    }
  }

  Future<void> guardar_datos(
      statusSession,
      MontoSolicitadoSession,
      EtiquetaSession,
      APagarSession,
      CuotaSession,
      TotalAPagarSession,
      TasaPromedioSession,
      CatPromedioSession,
      ComisionPorAperturaSession,
      ComisionPorTardioSession,
      ResultadoSession) async {
    //print("llego");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('statusSession', statusSession);
    await prefs.setString('MontoSolicitadoSession', MontoSolicitadoSession);
    await prefs.setString('EtiquetaSession', EtiquetaSession);
    await prefs.setString('APagarSession', APagarSession);
    await prefs.setString('CuotaSession', CuotaSession);
    await prefs.setString('TotalAPagarSession', TotalAPagarSession);
    await prefs.setString('TasaPromedioSession', TasaPromedioSession);
    await prefs.setString('CatPromedioSession', CatPromedioSession);
    await prefs.setString(
        'ComisionPorAperturaSession', ComisionPorAperturaSession);
    await prefs.setString('ComisionPorTardioSession', ComisionPorTardioSession);
    await prefs.setString('ResultadoSession', ResultadoSession);

    /*print("***++++++++");
      print(MontoSolicitadoSession);
      print(EtiquetaSession);
      print(APagarSession);
      print(CuotaSession);
      print(TotalAPagarSession);
      print(MontoSolicitadoSession);
      print(EtiquetaSession);
      print(APagarSession);
      print(CuotaSession);
      print(TotalAPagarSession);
      print("***++++++");*/
  }

  int id_LR = 0;
  int id_info = 0;
  String NombreCompletoSession = "";

  void mostrar_datos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      NombreCompletoSession = prefs.getString('NombreCompletoSession') ?? '';
      id_LR = prefs.getInt('id_LR') ?? 0;
      id_info = prefs.getInt('id_info') ?? 0;

      statusSession = prefs.getString('statusSession') ?? '';
      MontoSolicitadoSession = prefs.getString('MontoSolicitadoSession') ?? '';
      EtiquetaSession = prefs.getString('EtiquetaSession') ?? '';
      APagarSession = prefs.getString('APagarSession') ?? '';
      CuotaSession = prefs.getString('CuotaSession') ?? '';
      TotalAPagarSession = prefs.getString('TotalAPagarSession') ?? '';
      TasaPromedioSession = prefs.getString('TasaPromedioSession') ?? '';
      CatPromedioSession = prefs.getString('CatPromedioSession') ?? '';
      ComisionPorAperturaSession =
          prefs.getString('ComisionPorAperturaSession') ?? '';
      ComisionPorTardioSession =
          prefs.getString('ComisionPorTardioSession') ?? '';
      ResultadoSession = prefs.getString('ResultadoSession') ?? '';
    });

    //Pantalla.text = "$id_medico";
    //IDMedico.text = "$id_medico";
    //IDInfo.text = "$id_info";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_PRINCIPAL,
        title: Text("Fasol Crédito y Préstamos Personales"),
      ),
      drawer: MenuLateralPage(idCredito),
      bottomNavigationBar: MenuFooterPage(),
      //body: Center(child: _builTable(),),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Text(
            "Desglose de la solicitud ",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color.fromARGB(255, 54, 54, 54),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          //Padding(padding: const EdgeInsets.only(top: 20),),
          SingleChildScrollView(
            //     child: Column(
            //   children: [
            //     Text('Status: ${apiResponse['id_solicitud']}'),

            //     // Mostrar más propiedades según sea necesario
            //   ],
            // )
            child: DataTable(
                //sortAscending: true,
                //sortColumnIndex: 0,
                //columnSpacing: 2.0,
                //dataRowHeight: 53.0,
                //headingRowHeight: 30.0,
                columns: [
                  DataColumn(
                    label: Text(
                      "",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    tooltip: "",
                  ),
                  DataColumn(
                      label: Text(
                        "",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      numeric: true)
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(
                      Text("Monto solicitado "),
                    ),
                    DataCell(
                      Text('${apiResponse['MontoSolicitado']}'),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("A pagar")),
                    DataCell(
                      Text('${apiResponse['TotalAPagar']}'),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Cuota")),
                    DataCell(Text('${apiResponse["Cuota"]}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Total a pagar")),
                    DataCell(Text('${apiResponse["TotalAPagar"]}'))
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Tasa promedio")),
                    DataCell(Text('${apiResponse["TasaPromedio"]}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Cat promedio")),
                    DataCell(Text('${apiResponse["CatPromedio"]}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Comisión por apertura")),
                    DataCell(Text('${apiResponse["ComisionPorApertura"]}'))
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Comisión pago tardío")),
                    DataCell(Text('${apiResponse["ComisionPagoTardio"]}'))
                  ])
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
          ),

          _BotonEnviar()
        ],
      ),
    );
  }

  Widget _BotonEnviar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {
            Enviar();
          },
          child: const Text('Lo quiero')),
    );
  }
}
