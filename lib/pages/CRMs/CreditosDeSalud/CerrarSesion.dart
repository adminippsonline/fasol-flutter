import 'package:flutter/material.dart';

import 'headers.dart';
import 'menu_lateral.dart';
import 'menu_footer.dart';
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

import 'home_page.dart';


//PAra validar
//void main() => runApp(const CerrarSesion());

class CerrarSesion extends StatefulWidget {
  const CerrarSesion({super.key});

  @override
  State<CerrarSesion> createState() => _CerrarSesionState();
}

class _CerrarSesionState extends State<CerrarSesion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      drawer: MenuLateralPage(),
      bottomNavigationBar: MenuFooterPage(),
      body: const MyCustomCerrarSesion(),
    );
  }
}

// Create a Form widget.
class MyCustomCerrarSesion extends StatefulWidget {
  const MyCustomCerrarSesion({super.key});

  @override
  MyCustomCerrarSesionState createState() {
    return MyCustomCerrarSesionState();
  }
}

class MyCustomCerrarSesionState
    extends State<MyCustomCerrarSesion> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();
  //Los controladores para los input
  final Correo = TextEditingController();
  final Contrasena = TextEditingController();
  //Variables para datos que se reciben del input
  String CorreoRecibe = "";
  String ContrasenaRecibe = "";

  String email = "";

  void Ingresar() async {
    Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => HomePageCreditosDeSalud()));
    FocusScope.of(context).unfocus();
  }

  

  //Esto es un metodo
  //se usa para mostrar los datos del estado
  int id_medico = 0;
  int id_credito = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String ContrasenaSession = "";
  String TelefonoSession = "";
  Future<void> mostrar_datos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Ingresar();
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
