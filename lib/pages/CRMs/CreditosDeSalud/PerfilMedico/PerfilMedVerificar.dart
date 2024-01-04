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

import 'PerfilMedicoWebView.dart';
import '../RegMedico/FirmarMedico.dart';

import '../RegMedico/FinRegMedico30.dart';
import '../RegMedico/FinRegMedico30_1.dart';
import '../RegMedico/FinRegMedico31.dart';
import '../RegMedico/FinRegMedico32.dart';
import '../RegMedico/FinRegMedico33.dart';
import '../RegMedico/FinRegMedico33_1.dart';
import '../RegMedico/FinRegMedico34.dart';
import '../RegMedico/FinRegMedico35_INE.dart';
import '../RegMedico/FinRegMedico36.dart';

import '../VerificarCuenta.dart';

//PAra validar
//void main() => runApp(const PerfilMedVerificar());

class PerfilMedVerificar extends StatefulWidget {
  const PerfilMedVerificar({super.key});

  @override
  State<PerfilMedVerificar> createState() => _PerfilMedVerificarState();
}

class _PerfilMedVerificarState extends State<PerfilMedVerificar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: COLOR_PRINCIPAL,
      ),
      drawer: MenuLateralPage(),
      bottomNavigationBar: MenuFooterPage(),
      body: const MyCustomPerfilMedVerificar(),
    );
  }
}

// Create a Form widget.
class MyCustomPerfilMedVerificar extends StatefulWidget {
  const MyCustomPerfilMedVerificar({super.key});

  @override
  MyCustomPerfilMedVerificarState createState() {
    return MyCustomPerfilMedVerificarState();
  }
}

class MyCustomPerfilMedVerificarState
    extends State<MyCustomPerfilMedVerificar> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();
  //Los controladores para los input
  final Correo = TextEditingController();
  final Contrasena = TextEditingController();
  //Variables para datos que se reciben del input
  String CorreoRecibe = "";
  String ContrasenaRecibe = "";

  String email = "";

  void Ingresar(Corr, Pass, id_med) async {
    try {
      var data = {'Correo': Corr, 'Contrasena': Pass, 'id_medico': '$id_med'};
      var url = Uri.https('fasoluciones.mx', 'api/Medico/Verificar');
      var response = await http.post(url, body: data).timeout(const Duration(seconds: 90));
      if (response.body != "0" && response.body != "") {
          print(response.body);
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
              int id_medico = Respuesta['id_medico'];
              String NombreCompleto = Respuesta['NombreCompleto'] ?? "";
              if (NombreCompleto == "") {
                NombreCompleto = "";
              }
              guardar_datos(
                id_medico,
                NombreCompleto,
                Respuesta['data']['Correo'],
                Pass,
                Respuesta['data']['Telefono']);
                //print("llego aqui");
                if (Redireccionar == "Firmar") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinRegMedico30()));
                  FocusScope.of(context).unfocus();
                } else if(Redireccionar == "PerfilMedico") {
                   Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return new PerfilMedicoWebView(
                        Corr, Pass, id_med);
                  }));
                } else if (Redireccionar == "FinRegMedico30") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinRegMedico30()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinRegMedico30_1") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinRegMedico30_1()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinRegMedico33") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinRegMedico33()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinRegMedico33_1") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinRegMedico33_1()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinRegMedico34") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinRegMedico34()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinRegMedico35") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinRegMedico35_INE()));
                  FocusScope.of(context).unfocus();
                } else if (Redireccionar == "FinRegMedico36") {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => FinRegMedico36()));
                  FocusScope.of(context).unfocus();
                } else {
                  //print(Redireccionar);
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return new PerfilMedicoWebView(
                        CorreoSession, ContrasenaSession,id_medico);
                  }));
                }                
          }
          else{
            //print('Error en el registro');
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error en el login'),
                  );
                });
            /*Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => PerfilMedVerificar()));
          FocusScope.of(context).unfocus();*/    

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
              MaterialPageRoute(builder: (_) => PerfilMedVerificar()));
          FocusScope.of(context).unfocus(); */  
      } 
    } on TimeoutException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('La conexión tardo mucho'),
            );
          });
          Navigator.of(context).push(
              MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new PerfilMedVerificar();
          }));
    } on Error catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('Error: HTTP://'),
            );
          });
           Navigator.of(context).push(
              MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new PerfilMedVerificar();
          }));
    }
  }

  //Esto es iun metodo
  //se usa para guarar dtos es tipo sesiones
  Future<void> guardar_datos(id_medico, NombreCompletoSession,
      CorreoSession, ContrasenaSession, TelefonoSession) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id_medico', id_medico);
    await prefs.setString('NombreCompletoSession', NombreCompletoSession);
    await prefs.setString('CorreoSession', CorreoSession);
    await prefs.setString('ContrasenaSession', ContrasenaSession);
    await prefs.setString('TelefonoSession', TelefonoSession);
  }

  //Esto es un metodo
  //se usa para mostrar los datos del estado
  int id_medico = 0;
  int id_info = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String ContrasenaSession = "";
  String TelefonoSession = "";
  Future<void> mostrar_datos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id_medico = await prefs.getInt('id_medico');
    var NombreCompletoSession = await prefs.getString('NombreCompletoSession');
    var CorreoSession = await prefs.getString('CorreoSession');
    var ContrasenaSession = await prefs.getString('ContrasenaSession');
    var TelefonoSession = await prefs.getString('TelefonoSession');

    Ingresar(CorreoSession, ContrasenaSession, id_medico);
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
