import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/home_page.dart';
import '../Includes/colors/colors.dart';
import '../headers.dart';
import '../menu_lateral.dart';
import '../menu_footer.dart';
//estas dos creo son para las apis que se consumen
import 'package:http/http.dart' as http;
import 'dart:async';
//Me parece que es para convertir el json
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
//Paqueteria para sesiones tipo cookies
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../home_page.dart';
import 'PerfilSol.dart';
import 'PerfilSolicitudWebView.dart';

import '../RegSolicitud/FinSolicitar10.dart';
import '../RegSolicitud/FinSolicitar11.dart';
import '../RegSolicitud/FinSolicitar12.dart';
import '../RegSolicitud/FinSolicitar13.dart';
import '../RegSolicitud/FinSolicitar13_0.dart';
import '../RegSolicitud/FinSolicitar13_1.dart';
import '../RegSolicitud/FinSolicitar14.dart';
import '../RegSolicitud/FinSolicitar15.dart';
import '../RegSolicitud/FinSolicitar16.dart';
import '../RegSolicitud/FinSolicitar17.dart';
import '../RegSolicitud/FinSolicitar17_1.dart';
import '../RegSolicitud/FinSolicitar19.dart';
import '../RegSolicitud/FinSolicitar20.dart';
import '../RegSolicitud/FinSolicitar21.dart';
import '../RegSolicitud/FinSolicitar22.dart';
import '../RegSolicitud/FinSolicitar22_1.dart';
import '../RegSolicitud/FinSolicitar23.dart';
import '../RegSolicitud/FinSolicitar23_4.dart';
import '../RegSolicitud/FinSolicitar23_1.dart';
import '../RegSolicitud/FinSolicitar23_0.dart';
import '../RegSolicitud/FinSolicitar23_1.dart';

import "PerfilSolicitudWebView.dart";

import '../VerificarCuenta.dart';

//PAra validar
//void main() => runApp(const PerfilSolVerificar());

class PerfilSolVerificar extends StatefulWidget {
  String idCredito = "";
  PerfilSolVerificar(this.idCredito);

  @override
  State<PerfilSolVerificar> createState() => _PerfilSolVerificarState();
}

class _PerfilSolVerificarState extends State<PerfilSolVerificar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: COLOR_PRINCIPAL,
      ),
      drawer: MenuLateralPage(widget.idCredito),
      bottomNavigationBar: MenuFooterPage(),
      body: MyCustomPerfilSolVerificar(widget.idCredito),
    );
  }
}

// Create a Form widget.
class MyCustomPerfilSolVerificar extends StatefulWidget {
  String idCredito = "";
  MyCustomPerfilSolVerificar(this.idCredito);

  @override
  MyCustomPerfilSolVerificarState createState() {
    return MyCustomPerfilSolVerificarState();
  }
}

class MyCustomPerfilSolVerificarState
    extends State<MyCustomPerfilSolVerificar> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();
  //Los controladores para los input
  final Correo = TextEditingController();
  final Contrasena = TextEditingController();
  final IDSolicitud = TextEditingController();
  //Variables para datos que se reciben del input
  String CorreoRecibe = "";
  String ContrasenaRecibe = "";
  String IDSolicitudRecibe = "";

  String email = "";
  int id_sol = 0;

  void Ingresar(Corr, Pass, id_sol) async {
    try {
      var data = {
        'Correo': Corr,
        'Contrasena': Pass,
        'id_solicitud': '$id_sol'
      };
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Verificar');
      var response =
          await http.post(url, body: data).timeout(const Duration(seconds: 90));
      if (response.body != "0" && response.body != "") {
        //print(response.body);
        var Respuesta = jsonDecode(response.body);
        String Redireccionar = Respuesta['Redireccionar'];
        String status = Respuesta['status'];

        //print(status);
        //print(Redireccionar);
        if (status == "Error") {
          if (Redireccionar == "Verificar") {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => VerificarCuenta()));
            FocusScope.of(context).unfocus();
          } else if (Redireccionar == "Calculadora") {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => HomePageCreditosDeSalud()));
            FocusScope.of(context).unfocus();
          }
        } else if (status == "OK") {
          int id_solicitud = Respuesta['id_solicitud'];
          int id_credito = Respuesta['id_credito'];
          String NombreCompleto = Respuesta['NombreCompleto'] ?? "";
          if (NombreCompleto == "") {
            NombreCompleto = "";
          }
          guardar_datos(id_solicitud, id_credito, NombreCompleto,
              Respuesta['data']['Correo'], Pass, Respuesta['data']['Telefono']);
          print("llego aqui");

          /*Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => FinSolicitar10(widget.idCredito)));
                      FocusScope.of(context).unfocus();*/
          //print(id_credito);
          if (id_credito >= 1) {
            if (Redireccionar == "FinSolicitar10") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar10(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else if (Redireccionar == "FinSolicitar11") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar11(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else if (Redireccionar == "FinSolicitar12") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar12(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else if (Redireccionar == "FinSolicitar13_1") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar13_1(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else if (Redireccionar == "FinSolicitar14") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar14(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else if (Redireccionar == "FinSolicitar15") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar15(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else if (Redireccionar == "FinSolicitar16") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar16(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else if (Redireccionar == "FinSolicitar17") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar17(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else if (Redireccionar == "FinSolicitar19") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar19(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else if (Redireccionar == "FinSolicitar20") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar20(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else if (Redireccionar == "FinSolicitar21") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar20(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else if (Redireccionar == "FinSolicitar22_1") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar22_1(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else if (Redireccionar == "FinSolicitar23") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar23(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else if (Redireccionar == "FinSolicitar23_0") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar23_0(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else if (Redireccionar == "FinSolicitar23_1") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar23_1(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else {
              //print(Redireccionar);
              Navigator.of(context).push(
                  MaterialPageRoute<Null>(builder: (BuildContext context) {
                return new PerfilSolicitudWebView(
                    CorreoSession, ContrasenaSession, id_solicitud);
              }));
            }
          } else {
            //print("notiene credito");
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => HomePageCreditosDeSalud()));
            FocusScope.of(context).unfocus();
          }
        } else {
          //print('Error en el registro');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error en el login'),
                );
              });
          //Navigator.of(context).pushReplacement(
          //MaterialPageRoute(builder: (_) => PerfilSolVerificar()));
          //FocusScope.of(context).unfocus();
        }
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error en el login"),
              );
            });
        /*Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => PerfilSolVerificar()));
          FocusScope.of(context).unfocus();*/
      }
    } on TimeoutException catch (e) {
      //print('Tardo muco la conexion');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('La conexión tardo mucho'),
            );
          });
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new PerfilSolVerificar(widget.idCredito);
      }));
    } on Error catch (e) {
      //print('http error');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('Error: HTTP://'),
            );
          });
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new PerfilSolVerificar(widget.idCredito);
      }));
    }
  }

  //Esto es iun metodo
  //se usa para guarar dtos es tipo sesiones
  Future<void> guardar_datos(id_solicitud, id_credito, NombreCompletoSession,
      CorreoSession, ContrasenaSession, TelefonoSession) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id_solicitud', id_solicitud);
    await prefs.setInt('id_credito', id_credito);
    await prefs.setString('NombreCompletoSession', NombreCompletoSession);
    await prefs.setString('CorreoSession', CorreoSession);
    await prefs.setString('ContrasenaSession', ContrasenaSession);
    await prefs.setString('TelefonoSession', TelefonoSession);
  }

  //Esto es un metodo
  //se usa para mostrar los datos del estado
  int id_solicitud = 0;
  int id_credito = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String ContrasenaSession = "";
  String TelefonoSession = "";
  Future<void> mostrar_datos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id_solicitud = await prefs.getInt('id_solicitud');
    var id_credito = await prefs.getInt('id_credito');
    var NombreCompletoSession = await prefs.getString('NombreCompletoSession');
    var CorreoSession = await prefs.getString('CorreoSession');
    var ContrasenaSession = await prefs.getString('ContrasenaSession');
    var TelefonoSession = await prefs.getString('TelefonoSession');

    Ingresar(CorreoSession, ContrasenaSession, id_solicitud);
  }

  //Pra pintar datos initState() es un estado es como sesiones valida que haya sesiones, si exite te redirecciona al ligin
  @override
  void initState() {
    super.initState();
    mostrar_datos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.deepPurple[100],
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularPercentIndicator(
              animation: true,
              animationDuration: 4000,
              radius: 150,
              lineWidth: 40,
              percent: 1,
              progressColor: Colors.deepPurple,
              backgroundColor: Colors.deepPurple.shade200,
              circularStrokeCap: CircularStrokeCap.round,
              center: new Icon(
                Icons.person_pin,
                size: 50.0,
                color: Colors.blue,
              ),
              /*center: const Text('100%',
                  style: TextStyle(
                    fontSize: 65,
                    color: Colors.deepPurple,
                  )),*/
            )
          ],
        ),
      )),
    );
  }
}
