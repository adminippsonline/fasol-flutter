import 'package:flutter/material.dart';
import 'Includes/colors/colors.dart';
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







//PAra validar
//void main() => runApp(const VerificarCuenta());

class VerificarCuenta extends StatefulWidget {
  const VerificarCuenta({super.key});

  @override
  State<VerificarCuenta> createState() => _VerificarCuentaState();
}

class _VerificarCuentaState extends State<VerificarCuenta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: COLOR_PRINCIPAL,
      ),
      drawer: MenuLateralPage(),
      bottomNavigationBar: MenuFooterPage(),
      body: const MyCustomVerificarCuenta(),
    );
  }
}

// Create a Form widget.
class MyCustomVerificarCuenta extends StatefulWidget {
  const MyCustomVerificarCuenta({super.key});

  @override
  MyCustomVerificarCuentaState createState() {
    return MyCustomVerificarCuentaState();
  }
}

class MyCustomVerificarCuentaState
    extends State<MyCustomVerificarCuenta> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();
  //Los controladores para los input
  final Correo = TextEditingController();
  final Contrasena = TextEditingController();
  //Variables para datos que se reciben del input
  String CorreoRecibe = "";
  String ContrasenaRecibe = "";

  String email = "";

 
 



  
  

  //Pra pintar datos initState() es un estado es como sesiones valida que haya sesiones, si exite te redirecciona al ligin
  @override
  void initState() {
    super.initState();
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
              /*center: new Icon(
                Icons.person_pin,
                size: 50.0,
                color: Color.fromARGB(255, 56, 180, 7),
              ),*/
              center: const Text('La cuenta aún no ha sido verificada',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.deepPurple,
                  )),
            )
          ],
        ),
      )),
    );
  }
}
