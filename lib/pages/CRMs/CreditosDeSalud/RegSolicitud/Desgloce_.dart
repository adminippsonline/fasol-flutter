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

class Desgloce extends StatefulWidget {
  //const Desgloce({super.key});

  String CantidadGET = "";
  String PeriodoGET = "";
  String QuincenalGET = "";
  String MensualGET = "";

  Desgloce(this.CantidadGET, this.PeriodoGET,this.QuincenalGET, this.MensualGET);

  @override
  State<Desgloce> createState() => _DesgloceState(); 

} 


class _DesgloceState extends State<Desgloce> {
  //TextStyle EstiloBotones = TextStyle(color: Colors.amber);



  String status="";
  String MontoSolicitado="";
  String Etiqueta="";
  String APagar="";
  String Cuota="";
  String TotalAPagar=""; 
  String TasaPromedio="";
  String CatPromedio="";
  String ComisionPorApertura="";
  String ComisionPorTardio="";
  String Resultado="";
  
  String statusSession="";
  String MontoSolicitadoSession="";
  String EtiquetaSession="";
  String APagarSession="";
  String CuotaSession="";
  String TotalAPagarSession=""; 
  String TasaPromedioSession="";
  String CatPromedioSession="";
  String ComisionPorAperturaSession="";
  String ComisionPorTardioSession="";
  String ResultadoSession="";

  void initState() {
    super.initState();
    Ingresar(widget.CantidadGET, widget.PeriodoGET, widget.QuincenalGET,widget.MensualGET);
    mostrar_datos();
  }

  void Ingresar(
      Cantidad,
      Periodo,
      Quincenal,
      Mensual) async {
    try {
      var url =  Uri.https('fasoluciones.mx', 'ApiApp/Solicitud/SGS/Consultar.php');
      var data ={
        'Cantidad': "$Cantidad",
        'Periodo': Periodo,
        'Quincenal': "$Quincenal",
        'Mensual': "$Mensual",
      };          
      var response = await http
          .post(url, body: data)
          .timeout(const Duration(seconds: 90));
      //print("llego aqui 111");
      //print(response.body);

      if (response.body != "0" && response.body != "") {
        var Respuesta = jsonDecode(response.body);
          print(Respuesta);
        String status = Respuesta['status'];  
        if (status == "OK") {
          //print('si existe aqui -----');
          /*showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Registrado correctamente'),
                );
              }); */

          

          String MontoSolicitado = Respuesta['MontoSolicitado'];   
          String Etiqueta = Respuesta['Etiqueta'];   
          String APagar = Respuesta['APagar'];   
          String Cuota = Respuesta['Cuota'];   
          String TotalAPagar = Respuesta['TotalAPagar'];          
          String TasaPromedio = Respuesta['TasaPromedio'];
          String CatPromedio = Respuesta['CatPromedio'];
          String ComisionPorApertura = Respuesta['ComisionPorApertura'];
          String ComisionPorTardio = Respuesta['ComisionPorTardio'];
          String Resultado = Respuesta['ComisionPorTardio'];
          
          
          guardar_datos(
            status,
            MontoSolicitado, 
            Etiqueta,
            APagar, 
            Cuota, 
            TotalAPagar, 
            TasaPromedio, 
            CatPromedio,
            ComisionPorApertura,
            ComisionPorTardio,
            Resultado
          );    

        } else {
          //print('Error en el registro');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error en el registro'),
                );
              });
        }
      }
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
    await prefs.setString('ComisionPorAperturaSession', ComisionPorAperturaSession);
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


  void mostrar_datos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() { 
      statusSession =prefs.getString('statusSession') ?? '';
      MontoSolicitadoSession =prefs.getString('MontoSolicitadoSession') ?? '';
      EtiquetaSession =prefs.getString('EtiquetaSession') ?? '';
      APagarSession =prefs.getString('APagarSession') ?? '';
      CuotaSession =prefs.getString('CuotaSession') ?? '';
      TotalAPagarSession =prefs.getString('TotalAPagarSession') ?? '';
      TasaPromedioSession =prefs.getString('TasaPromedioSession') ?? '';
      CatPromedioSession =prefs.getString('CatPromedioSession') ?? '';
      ComisionPorAperturaSession =prefs.getString('ComisionPorAperturaSession') ?? '';
      ComisionPorTardioSession =prefs.getString('ComisionPorTardioSession') ?? '';
      ResultadoSession =prefs.getString('ResultadoSession') ?? '';
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
        title:  Text("Fasol Crédito y Préstamos Personales"),
      ),
      drawer: MenuLateralPage(),
      bottomNavigationBar: MenuFooterPage(),
      //body: Center(child: _builTable(),),
      body: Column(
        children: <Widget>[
          SizedBox(
                  height: 20,
                ),
          Text("Desglose de la solicitud ",
                textAlign:TextAlign.center,
                style:const TextStyle(
                  color:Color.fromARGB(255, 54, 54, 54),
                  fontWeight: FontWeight.bold,fontSize: 20
                ),
                ),
           //Padding(padding: const EdgeInsets.only(top: 20),),
          SingleChildScrollView(
            child: DataTable(
                    //sortAscending: true,
                    sortColumnIndex: 0,
                    //columnSpacing: 2.0,
                   dataRowHeight: 53.0,
                   headingRowHeight: 30.0,
              columns: [
                DataColumn(label: Text("",
                textAlign:TextAlign.start,
                style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
                tooltip: "",
                ),
                DataColumn(label: Text("",textAlign:TextAlign.start,
                style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
                numeric: true)
              ],
             rows: [
               DataRow(cells: [
                 DataCell(Text("Monto solicitado "),
                 placeholder: true,
                 ),
                 DataCell(Text(MontoSolicitadoSession))
               ]),
               DataRow(cells: [
                 DataCell(Text("a pagar")),
                 DataCell(Text(APagarSession))
               ]),
               DataRow(cells: [
                 DataCell(Text("Cuota")),
                 DataCell(Text(CuotaSession))
               ]),
               DataRow(cells: [
                 DataCell(Text("Total a pagar")),
                 DataCell(Text(TotalAPagarSession))
               ]),
               DataRow(cells: [
                 DataCell(Text("Tasa promedio")),
                 DataCell(Text(TasaPromedioSession))
               ]),
               DataRow(cells: [
                 DataCell(Text("Cat promedio")),
                 DataCell(Text(CatPromedioSession))
               ]),
               DataRow(cells: [
                 DataCell(Text("Comisión por apertura")),
                 DataCell(Text(ComisionPorAperturaSession))
               ]),
               DataRow(cells: [
                 DataCell(Text("Comisión pago tardío")),
                 DataCell(Text(ComisionPorTardioSession))
               ])
             ]),
          ),
           Padding(padding: const EdgeInsets.only(top: 80),),
          

        ],
      ),
    );
  } 

}




