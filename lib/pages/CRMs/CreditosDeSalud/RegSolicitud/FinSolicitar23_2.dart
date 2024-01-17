import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:developer' as dev;

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

//import 'FinSolicitar23_2_sui_imagen_no_irve.dart';

import 'FinSolicitar23_2.dart';

import '../PerfilSolicitud/PerfilSolicitudWebView.dart';

import 'package:intl/intl.dart';
import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:dio/dio.dart';

class FinSolicitar23_2 extends StatefulWidget {
  const FinSolicitar23_2({super.key});

  @override
  State<FinSolicitar23_2> createState() => _FinSolicitar23_2State();
}

class _FinSolicitar23_2State extends State<FinSolicitar23_2> {
  //se usa para mostrar los datos del estado
  int id_solicitud = 0;
  int id_credito = 0;
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
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_credito = prefs.getInt('id_credito') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomFormFinSolicitar23_2();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(NombreCompletoSession),
    //   ),
    //   drawer: MenuLateralPage(""),
    //   bottomNavigationBar: MenuFooterPage(),
    //   body: const MyCustomFormFinSolicitar23_2(),
    // );
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar23_2 extends StatefulWidget {
  const MyCustomFormFinSolicitar23_2({super.key});

  @override
  MyCustomFormFinSolicitar23_2State createState() {
    return MyCustomFormFinSolicitar23_2State();
  }
}

class MyCustomFormFinSolicitar23_2State
    extends State<MyCustomFormFinSolicitar23_2> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDLR = TextEditingController();
  final IDInfo = TextEditingController();

  String PantallaRecibe = "";
  String IDLRRecibe = "";
  String IDInfoRecibe = "";

  void Ingresar(Pantalla, IDLR, IDInfo) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');
      var response = await http.post(url, body: {
        'Pantalla': Pantalla,
        'id_solicitud': IDLR,
        'id_credito': IDInfo
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
              builder: (_) => PerfilSolicitudWebView(
                  CorreoSession, ContrasenaSession, id_solicitud)));
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
  int id_solicitud = 0;
  int id_credito = 0;
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
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_credito = prefs.getInt('id_credito') ?? 0;

      NombreCompletoSession =
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      CorreoSession = prefs.getString('CorreoSession') ?? 'vacio';
      ContrasenaSession = prefs.getString('ContrasenaSession') ?? 'vacio';
      TelefonoSession = prefs.getString('TelefonoSession') ?? 'vacio';
    });

    Pantalla.text = 'FinSolicitar38';
    IDLR.text = "$id_solicitud";
    IDInfo.text = "$id_credito";
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
                    SubitleCards("Estimado Cliente $NombreCompletoSession"),
                    SizedBox(
                      height: 20,
                    ),
                    _Pantalla(),
                    _IDLR(),
                    _IDInfo(),
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
                    //_Avanzar
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

  Widget _IDLR() {
    return Visibility(
        visible: false,
        child: Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: IDLR,
            decoration: InputDecoration(
                labelText: 'IDLR',
                border: OutlineInputBorder(),
                isDense: false,
                contentPadding: EdgeInsets.all(10),
                hintText: ''),
          ),
        ));
  }

  Widget _IDInfo() {
    return Visibility(
        visible: false,
        child: Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: IDInfo,
            decoration: InputDecoration(
                labelText: 'IDInfo',
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
            dev.log(id_solicitud.toString());
            dev.log(ContrasenaSession.toString());
            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //     builder: (_) => PerfilSolicitudWebView(
            //         CorreoSession, ContrasenaSession, id_solicitud)));
            // FocusScope.of(context).unfocus();

            // if (_formKey.currentState!.validate()) {
            //   PantallaRecibe = Pantalla.text;
            //   IDLRRecibe = IDLR.text;
            //   IDInfoRecibe = IDInfo.text;

            //   if (PantallaRecibe == "" ||
            //       IDLRRecibe == "" ||
            //       IDInfoRecibe == "") {
            //     showDialog(
            //         context: context,
            //         builder: (BuildContext context) {
            //           return AlertDialog(
            //             title: Text('Error: Todos los campos son obligatorios'),
            //           );
            //         });
            //   } else {
            //     //print(CorreoSession);
            //     //print(ContrasenaSession);
            //     //Ingresar(PantallaRecibe, IDLRRecibe, IDInfoRecibe);
            //     /*Navigator.of(context).pushReplacement(MaterialPageRoute(
            //       builder: (_) =>
            //           PerfilMedicoWebView(CorreoSession, ContrasenaSession)));
            //   FocusScope.of(context).unfocus();*/
            //   }
            // }
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
