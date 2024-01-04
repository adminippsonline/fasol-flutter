import 'package:flutter/material.dart';

import '../../headers.dart';
import '../../menu_lateral.dart';
import '../../menu_footer.dart';
//estas dos creo son para las apis que se consumen
import 'package:http/http.dart' as http;
import 'dart:async';
//Me parece que es para convertir el json
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
//Paqueteria para sesiones tipo cookies
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../home_page.dart';
//import 'package:email_validator/email_validator.dart';
//import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
//import 'package:dropdown_button2/dropdown_button2.dart';

//import 'FinRegMedico31.dart';

//import 'package:intl/intl.dart';

class CargandoCreditosDeSalud extends StatefulWidget {
  const CargandoCreditosDeSalud({super.key});

  @override
  State<CargandoCreditosDeSalud> createState() =>
      _CargandoCreditosDeSaludState();
}

class _CargandoCreditosDeSaludState extends State<CargandoCreditosDeSalud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MyCustomFormCargandoCreditosDeSalud(),
    );
  }
}

// Create a Form widget.
class MyCustomFormCargandoCreditosDeSalud extends StatefulWidget {
  const MyCustomFormCargandoCreditosDeSalud({super.key});

  @override
  MyCustomFormCargandoCreditosDeSaludState createState() {
    return MyCustomFormCargandoCreditosDeSaludState();
  }
}

class MyCustomFormCargandoCreditosDeSaludState
    extends State<MyCustomFormCargandoCreditosDeSalud> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*backgroundColor: Colors.deepPurple[100],*/
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularPercentIndicator(
              animation: true,
              animationDuration: 4000,
              radius: 200,
              lineWidth: 40,
              percent: 1,
              progressColor: Colors.deepPurple,
              backgroundColor: Colors.deepPurple.shade200,
              circularStrokeCap: CircularStrokeCap.round,

              /*center: new Icon(
              Icons.person_pin,
              size: 50.0,
              color: Colors.blue,

            ),*/
              center: const Text('100%',
                  style: TextStyle(
                    fontSize: 65,
                    color: Colors.deepPurple,
                  )),
            )
          ],
        ),
      )),
    );
  }
}
