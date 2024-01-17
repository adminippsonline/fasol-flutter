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

//import 'FinRegMedico38_sui_imagen_no_irve.dart';

import 'FinRegMedico38.dart';

import '../PerfilMedico/PerfilMedicoWebView.dart';

import 'package:intl/intl.dart';
import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:dio/dio.dart';

class FinRegMedico38 extends StatefulWidget {
  const FinRegMedico38({super.key});

  @override
  State<FinRegMedico38> createState() => _FinRegMedico38State();
}

class _FinRegMedico38State extends State<FinRegMedico38> {
  //se usa para mostrar los datos del estado
  int id_medico = 0;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomFormFinRegMedico38();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(NombreCompletoSession),
    //   ),
    //   drawer: MenuLateralPage(""),
    //   bottomNavigationBar: MenuFooterPage(),
    //   body: const MyCustomFormFinRegMedico38(),
    // );
  }
}

// Create a Form widget.
class MyCustomFormFinRegMedico38 extends StatefulWidget {
  const MyCustomFormFinRegMedico38({super.key});

  @override
  MyCustomFormFinRegMedico38State createState() {
    return MyCustomFormFinRegMedico38State();
  }
}

class MyCustomFormFinRegMedico38State
    extends State<MyCustomFormFinRegMedico38> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDMedico = TextEditingController();

  String PantallaRecibe = "";
  String IDMedicoRecibe = "";

  void Ingresar(Pantalla, IDMedico) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Medico/Agregar');
      var response = await http.post(url, body: {
        'Pantalla': Pantalla,
        'id_medico': IDMedico
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
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => PerfilMedicoWebView(
                  CorreoSession, ContrasenaSession, id_medico)));
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
  }

  //Esto es un metodo
  //se usa para mostrar los datos del estado
  int id_medico = 0;
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
      id_medico = prefs.getInt('id_medico') ?? 0;

      NombreCompletoSession =
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      CorreoSession = prefs.getString('CorreoSession') ?? 'vacio';
      ContrasenaSession = prefs.getString('ContrasenaSession') ?? 'vacio';
      TelefonoSession = prefs.getString('TelefonoSession') ?? 'vacio';
    });

    Pantalla.text = 'FinSolicitar38';
    IDMedico.text = "$id_medico";
  }

  @override
  Widget build(BuildContext context) {
    return BuildScreens(
        '${NombreCompletoSession}', '', '', '!Felicidades!', '', _formulario());
  }

  Widget _formulario() {
    return Container(
        padding: EdgeInsets.all(5),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //headerTop("Médicos", "Estimado Dr $NombreCompletoSession"),
                    SubitleCards("Estimado Dr $NombreCompletoSession"),
                    SizedBox(
                      height: 20,
                    ),
                    _Pantalla(),
                    _IDMedico(),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: const Text(
                        "Estamos validando su documentación para poder continuar con la firma del convenio. ",
                        //textAlign:  TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 56, 56, 56)),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(15),
                      child: const Text(
                        "En breve se le notificará vía correo electrónico para terminar la afiliación. ",
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
                    //_Avanzar()
                  ]),
            )));
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

  Widget _IDMedico() {
    return Visibility(
        visible: false,
        child: Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: IDMedico,
            decoration: InputDecoration(
                labelText: 'IDMedico',
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
                builder: (_) => PerfilMedicoWebView(
                    CorreoSession, ContrasenaSession, id_medico)));
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
