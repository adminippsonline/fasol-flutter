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
//import 'package:email_validator/email_validator.dart';
//import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
//import 'package:dropdown_button2/dropdown_button2.dart';

//import 'FinRegMedico31.dart';

//import 'package:intl/intl.dart';
import '../../RegSolicitud/RegistroSol.dart';

class HomePageCreditosDeSalud extends StatefulWidget {
  const HomePageCreditosDeSalud({super.key});

  @override
  State<HomePageCreditosDeSalud> createState() =>
      _HomePageCreditosDeSaludState();
}

class _HomePageCreditosDeSaludState extends State<HomePageCreditosDeSalud> {
  //se usa para mostrar los datos del estado
  int id_medico = 0;
  int id_info = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String TelefonoSession = "";

  @override
  void initState() {
    super.initState();
    mostrar_datos();
  }

  void mostrar_datos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      NombreCompletoSession =
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      id_medico = prefs.getInt('id_medico') ?? 0;
      id_info = prefs.getInt('id_info') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido $id_medico $id_info  $NombreCompletoSession"),
      ),
      drawer: MenuLateralPage(),
      bottomNavigationBar: MenuFooterPage(),
      body: const MyCustomFormHomePageCreditosDeSalud(),
    );
  }
}

// Create a Form widget.
class MyCustomFormHomePageCreditosDeSalud extends StatefulWidget {
  const MyCustomFormHomePageCreditosDeSalud({super.key});

  @override
  MyCustomFormHomePageCreditosDeSaludState createState() {
    return MyCustomFormHomePageCreditosDeSaludState();
  }
}

class MyCustomFormHomePageCreditosDeSaludState
    extends State<MyCustomFormHomePageCreditosDeSalud> {
 
  List categoryItemlist = [];

  Future getAllCategory() async {
    var baseUrl = "https://fasoluciones.mx/ApiApp/Catalogos/Profesion.php"; 

    http.Response response = await http.get(Uri.parse(baseUrl));
    print(response); 
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemlist = jsonData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllCategory();
  }

  var dropdownvalue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecciona ****"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              hint: Text('hooseNumber ******'),
              items: categoryItemlist.map((item) {
                return DropdownMenuItem(
                  value: item['NombreProfesion'].toString(),
                  child: Text(item['NombreProfesion'].toString()),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  dropdownvalue = newVal;
                  print(dropdownvalue);
                });
              },
              value: dropdownvalue,
            ),
          ],
        ),
      ),
    );
  }
}