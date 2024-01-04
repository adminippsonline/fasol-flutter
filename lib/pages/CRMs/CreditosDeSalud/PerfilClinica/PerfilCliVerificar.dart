import 'package:flutter/material.dart';
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

import 'PerfilCli.dart';
import 'PerfilClinicaWebView.dart';

import '../RegClinica/FinClinicas3.dart';
import '../RegClinica/FinClinicas4.dart';
import '../RegClinica/FinClinicas4_1.dart';
import '../RegClinica/FinClinicas5_0.dart';
import '../RegClinica/FinClinicas5.dart';
import '../RegClinica/FinClinicas6.dart';
import '../RegClinica/FinClinicas7.dart';
import '../RegClinica/FinClinicas8.dart';
import '../RegClinica/FinClinicas9.dart';
import '../RegClinica/FinClinicas10.dart';
import '../RegClinica/FinClinicas14.dart';
import '../RegClinica/FinClinicas14_1.dart';
import '../RegClinica/FinClinicas15.dart';
import '../RegClinica/FinClinicas16.dart';
import '../RegClinica/FinClinicas17_0.dart';
import '../RegClinica/FinClinicas17_1.dart';

import '../RegClinica/FirmarClinica.dart';
import 'PerfilClinicaWebView.dart';

import '../VerificarCuenta.dart';

//PAra validar
//void main() => runApp(const PerfilCliVerificar());

class PerfilCliVerificar extends StatefulWidget {
  const PerfilCliVerificar({super.key});

  @override
  State<PerfilCliVerificar> createState() => _PerfilCliVerificarState();
}

class _PerfilCliVerificarState extends State<PerfilCliVerificar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: COLOR_PRINCIPAL,
      ),
      drawer: MenuLateralPage(),
      bottomNavigationBar: MenuFooterPage(),
      body: const MyCustomPerfilCliVerificar(),
    );
  }
}

// Create a Form widget.
class MyCustomPerfilCliVerificar extends StatefulWidget {
  const MyCustomPerfilCliVerificar({super.key});

  @override
  MyCustomPerfilCliVerificarState createState() {
    return MyCustomPerfilCliVerificarState();
  }
}

class MyCustomPerfilCliVerificarState
    extends State<MyCustomPerfilCliVerificar> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();
  //Los controladores para los input
  final Correo = TextEditingController();
  final Contrasena = TextEditingController();
  //Variables para datos que se reciben del input
  String CorreoRecibe = "";
  String ContrasenaRecibe = "";

  String email = "";

  void Ingresar(Corr, Pass, id_cli) async {
    try {
      var data = {'Correo': Corr, 'Contrasena': Pass, 'id_clinica': '$id_cli'};
      var url = Uri.https('fasoluciones.mx', 'api/Clinica/Verificar');
      var response = await http.post(url, body: data).timeout(const Duration(seconds: 90));
      if (response.body != "0" && response.body != "") {
          var Respuesta = jsonDecode(response.body);
          String Redireccionar = Respuesta['Redireccionar'];
          String status = Respuesta['status'];
          
          if (status == "Error") {
            //if (Redireccionar == "Verificar") {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => VerificarCuenta()));
                FocusScope.of(context).unfocus();
              //}

          } 
          else if (status == "OK") {
              int id_clinica = Respuesta['id_clinica'];
              String NombreCompleto = Respuesta['NombreCompleto'] ?? "";
              if (NombreCompleto == "") {
                NombreCompleto = "";
              }
              guardar_datos(
                id_clinica,
                NombreCompleto,
                Respuesta['data']['Correo'],
                Pass,
                Respuesta['data']['Telefono']);
                if (Redireccionar == "Firmar") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas3()));
                  FocusScope.of(context).unfocus();
                } else if(Redireccionar == "PerfilClinica") {
                   Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return new PerfilClinicaWebView(
                        Corr, Pass, id_cli);
                  }));
                } else if(Redireccionar == "FinClinicas3") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas3()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinClinicas4") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas4()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinClinicas4_1") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas4_1()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinClinicas5_0") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas5_0()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinClinicas5_1") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas5_0()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinClinicas5") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas5()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinClinicas6") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas6()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinClinicas7") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas7()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinClinicas8") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas8()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinClinicas9") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas9()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinClinicas10") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas10()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinClinicas14") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas14()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinClinicas14_1") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas14_1()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinClinicas15") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas15()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinClinicas16") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas16()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinClinicas17_1") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinClinicas17_1()));
                  FocusScope.of(context).unfocus();
                } else {
                  //print(Redireccionar);
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return new PerfilClinicaWebView(
                        Corr, Pass, id_cli);
                  }));
                }              
          }
          else{
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error en el login'),
                  );
                });
            /*Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => PerfilCliVerificar()));
          FocusScope.of(context).unfocus();  */  

          } 
      } 
      else{
         showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error en el login"),
                );
              });
          /*Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => PerfilCliVerificar()));
          FocusScope.of(context).unfocus();  */  

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
          Navigator.of(context).push(
              MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new PerfilCliVerificar();
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
           Navigator.of(context).push(
              MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new PerfilCliVerificar();
          }));
    }
  }

  //Esto es iun metodo
  //se usa para guarar dtos es tipo sesiones
  Future<void> guardar_datos(id_clinica, NombreCompletoSession,
      CorreoSession, ContrasenaSession, TelefonoSession) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id_clinica', id_clinica);
    await prefs.setString('NombreCompletoSession', NombreCompletoSession);
    await prefs.setString('CorreoSession', CorreoSession);
    await prefs.setString('ContrasenaSession', ContrasenaSession);
    await prefs.setString('TelefonoSession', TelefonoSession);
  }

  //Esto es un metodo
  //se usa para mostrar los datos del estado
  int id_clinica = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String ContrasenaSession = "";
  String TelefonoSession = "";
  Future<void> mostrar_datos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id_clinica = await prefs.getInt('id_clinica');
    var NombreCompletoSession = await prefs.getString('NombreCompletoSession');
    var CorreoSession = await prefs.getString('CorreoSession');
    var ContrasenaSession = await prefs.getString('ContrasenaSession');
    var TelefonoSession = await prefs.getString('TelefonoSession');
 
    Ingresar(CorreoSession, ContrasenaSession, id_clinica);
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
