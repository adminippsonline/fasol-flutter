import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Includes/widgets/build_screen.dart';

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
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

//import 'FinClinicas19_sui_imagen_no_irve.dart';

import 'FinClinicas19.dart';

import '../PerfilClinica/PerfilclinicaWebView.dart';

import 'package:intl/intl.dart';
import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:dio/dio.dart';

class FinClinicas19 extends StatefulWidget {
  const FinClinicas19({super.key});

  @override
  State<FinClinicas19> createState() => _FinClinicas19State();
}

class _FinClinicas19State extends State<FinClinicas19> {
  //se usa para mostrar los datos del estado
  int id_clinica = 0;
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
      id_clinica = prefs.getInt('id_clinica') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MyCustomFormFinClinicas19();
  }
}

// Create a Form widget.
class MyCustomFormFinClinicas19 extends StatefulWidget {
  const MyCustomFormFinClinicas19({super.key});

  @override
  MyCustomFormFinClinicas19State createState() {
    return MyCustomFormFinClinicas19State();
  }
}

class MyCustomFormFinClinicas19State
    extends State<MyCustomFormFinClinicas19> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDClinica = TextEditingController();

  String PantallaRecibe = "";
  String IDClinicaRecibe = "";

  /*void Ingresar(Pantalla, IDClinica, IDInfo) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Clinica/Agregar');
      var response = await http.post(url, body: {
        'Pantalla': Pantalla,
        'id_clinica': IDClinica,
        'id_info': IDInfo
      }).timeout(const Duration(seconds: 90));
      //print("llego aqui 111");
      //print(response.body);

      if (response.body != "0" && response.body != "") {
        var Respuesta = jsonDecode(response.body);
        print(Respuesta);
        String status = Respuesta['status'];
        if (status == "OK") {
          //print('si existe aqui -----');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Registrado correctamente'),
                );
              });
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => FinClinicas19()));
          FocusScope.of(context).unfocus();
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
      } else {
        //print('Error en el registro');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error en el registro"),
              );
            });
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
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error: HTTP://'),
            );
          });
    }
  }*/

  //Esto es un metodo
  //se usa para mostrar los datos del estado
  int id_clinica = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String ContrasenaSession = "";
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
      id_clinica = prefs.getInt('id_clinica') ?? 0;

      NombreCompletoSession =
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      CorreoSession =
          prefs.getString('CorreoSession') ?? 'vacio';
      ContrasenaSession =
          prefs.getString('ContrasenaSession') ?? 'vacio';
      TelefonoSession =
          prefs.getString('TelefonoSession') ?? 'vacio';

    });

    Pantalla.text = 'FinClinicas19';
    IDClinica.text = "$id_clinica";

    
  }

  Widget build(BuildContext context) {
    return BuildScreens(
        'Clínica', '', '', 'Datos de la clínica', '', _formulario());
  }
  
  Widget _formulario() {
    return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SubitleCards(
                        "En horabuena!"),
                    _Pantalla(),
                    _IDClinica(),

                    Container(
                      padding: EdgeInsets.all(15),
                      child: const Text(
                        "Ya eres parte de la red de clinica de Fasol Soluciones ",
                        //textAlign:  TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 56, 56, 56)),
                      ),
                    ),
                    

                    Container(
                      padding: EdgeInsets.all(15),
                      child: const Text(
                        "¡Gracias por confiar en nosotros!",
                        //textAlign:  TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 56, 56, 56)),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    _BotonEnviar(),
                    SizedBox(
                      height: 20,
                    ),
                    //_Avanzar
                  ]),
            ));
  }

  Widget _Pantalla() {
    return Visibility(
        visible: false,
        child: Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: Pantalla,
            decoration: InputDecoration(
                labelText: 'Pantalla',
                border: OutlineInputBorder(),
                isDense: false,
                contentPadding: EdgeInsets.all(10),
                hintText: ''),
          ),
        ));
  }

  Widget _IDClinica() {
    return Visibility(
        visible: false,
        child: Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: IDClinica,
            decoration: InputDecoration(
                labelText: 'IDClinica',
                border: OutlineInputBorder(),
                isDense: false,
                contentPadding: EdgeInsets.all(10),
                hintText: ''),
          ),
        ));
  }

  

  Widget _BotonEnviar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) =>
                    PerfilClinicaWebView(CorreoSession, ContrasenaSession, id_clinica)));
            
          },
          child: const Text('Ir a mi perfil')),
    );
  }
  /*Widget _Avanzar() {
    return Container(
      width: double.infinity,
      //padding: EdgeInsets.all(10),
      child: ListTile(
        title: new Center(
            child: new Text(
          "Avanzar",
          style: new TextStyle(fontSize: 12.0),
        )),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FinRegMedico31()));
        },
      ),
    );
  }*/
}
