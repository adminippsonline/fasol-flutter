import 'dart:io';

import 'package:dio/dio.dart';

import 'package:fad_bio/fad_bio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plugin/plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import '../includes/firebase_options.dart';

import 'package:http_parser/http_parser.dart';
import 'dart:developer' as dev;
import '../Includes/widgets/build_screen.dart';
import '../headers.dart';
import '../menu_lateral.dart';
import '../menu_footer.dart';
import '../../../../../Elementos/validaciones_formularios.dart';
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

import 'package:intl/intl.dart';

import 'dart:async';

import 'package:fad_bio/fad_bio.dart';
//import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plugin/plugin.dart';

import '../PerfilMedico/PerfilMedVerificar.dart';
import 'FirmarMedico.dart';

class FirmarMedico extends StatefulWidget {
  const FirmarMedico({super.key});

  @override
  State<FirmarMedico> createState() => _FirmarMedicoState();
}

class _FirmarMedicoState extends State<FirmarMedico> {
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
    return MyCustomFormFirmarMedico();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(NombreCompletoSession),
    //   ),
    //   drawer: MenuLateralPage(""),
    //   bottomNavigationBar: MenuFooterPage(),
    //   body: const MyCustomFormFinRegMedico35(),
    // );
  }
}

// Create a Form widget.
class MyCustomFormFirmarMedico extends StatefulWidget {
  const MyCustomFormFirmarMedico({super.key});

  @override
  MyCustomFormFirmarMedicoState createState() {
    return MyCustomFormFirmarMedicoState();
  }
}

class MyCustomFormFirmarMedicoState extends State<MyCustomFormFirmarMedico> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  String _fadResponse = "";
  final _plugin = FadMultisignPlugin();
  final _fadBioPlugin = FadBio();

  String ticket = "";
  String msg = "";
  void Consultar(IDMedico, IDInfo) async {
    /*print("****-------------------**********************");
    print(IDMedico);
    print(IDInfo);
    print("****-------------------**********************");*/
    if (IDMedico != 0 && IDInfo != 0) {
      try {
        var url = Uri.https('fasoluciones.mx', 'ApiApp/Medico/FirmarFAD.php');
        var data = {
          'Pantalla': 'Firmar',
          'id_medico': "$IDMedico",
          'id_info': "$IDInfo"
        };
        var response = await http
            .post(url, body: data)
            .timeout(const Duration(seconds: 90));
        //print("llego aqui 111");
        //print(response.body);
        if (response.body != "0" && response.body != "") {
          var Respuesta = jsonDecode(response.body);
          //print(Respuesta);
          String status = Respuesta['status'];
          String msg = Respuesta['msg'];

          if (status == "OK") {
            //print('Si recibo el ticket');
            print(ticket);
            ticket = Respuesta['ticket'];
          } else {
            //print('Error en el registro');
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error en el registro: $msg'),
                  );
                });
          }
        } else {
          //print('Error en el registro');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error en el registro: $msg'),
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
                title: Text('Error: HTTP:// $msg'),
              );
            });
      }
    } else {
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

  void Ingresar(Pantalla, IDMedico, IDInfo) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'ApiApp/Medico/Actualizar.php');
      var response = await http.post(url, body: {
        'Pantalla': 'Firmado',
        'id_medico': IDMedico,
        'id_info': IDInfo,
        'Firmado': 'OK'
      }).timeout(const Duration(seconds: 90));
      //print("llego aqui 111");
      //print(response.body);

      if (response.body != "0" && response.body != "") {
        var Respuesta = jsonDecode(response.body);
        //print(Respuesta);
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
              MaterialPageRoute(builder: (_) => PerfilMedVerificar()));
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

  Future<void> initMultiSign() async {
    String fadResponse;
    //String ticket="ñññññññññññññññññññññ";
    String config =
        '{"endpoint": "https://uat.firmaautografa.com","preventScreenCapture": false, "ticket": "$ticket","timeVideoAgreement":28}';

    print("----------------");
    print(config);
    print("----------------");

    try {
      fadResponse =
          await _plugin.initFAD(config) ?? 'Sin configuracion inicial';
      print(fadResponse);
    } on PlatformException {
      fadResponse = 'No se inicio FAD';
    }

    if (!mounted) return;

    setState(() {
      _fadResponse = fadResponse;
      if (_fadResponse ==
          '{"fadResultCode":"-3428","resultCode":"3","result":"null"}') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                    'Ocurrio un error intentelo nuevamente o contacte al administrador'),
              );
            });
      }
    });
  }

  String getPublicKey() {
    return "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5PxZ3DLj+zP6T6HFgzzk\nM77LdzP3fojBoLasw7EfzvLMnJNUlyRb5m8e5QyyJxI+wRjsALHvFgLzGwxM8ehz\nDqqBZed+f4w33GgQXFZOS4AOvyPbALgCYoLehigLAbbCNTkeY5RDcmmSI/sbp+s6\nmAiAKKvCdIqe17bltZ/rfEoL3gPKEfLXeN549LTj3XBp0hvG4loQ6eC1E1tRzSkf\nGJD4GIVvR+j12gXAaftj3ahfYxioBH7F7HQxzmWkwDyn3bqU54eaiB7f0ftsPpWM\nceUaqkL2DZUvgN0efEJjnWy5y1/Gkq5GGWCROI9XG/SwXJ30BbVUehTbVcD70+ZF\n8QIDAQAB\n-----END PUBLIC KEY-----";
  }

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDMedico = TextEditingController();
  final IDInfo = TextEditingController();
  final Ticket = TextEditingController();

  String PantallaRecibe = "";
  String IDMedicoRecibe = "";
  String IDInfoRecibe = "";
  String TicketRecibe = "";

  //se usa para mostrar los datos del estado
  int id_medico = 0;
  int id_info = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String TelefonoSession = "";

  //Esto es un metodo
  //se usa para mostrar los datos del estado

  Future<void> mostrar_datos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id_medico = await prefs.getInt('id_medico');
    var id_info = await prefs.getInt('id_info');
    var NombreCompletoSession = await prefs.getString('NombreCompletoSession');

    Pantalla.text = 'Firmado';
    IDMedico.text = "$id_medico";
    IDInfo.text = "$id_info";
    //print("aqui llegue");
    Consultar(id_medico, id_info);
  }

  @override
  void initState() {
    super.initState();
    mostrar_datos();
  }

  @override
  Widget build(BuildContext context) {
    return BuildScreens('${NombreCompletoSession}', '', '',
        'Información Personal', '', _formulario());
  }

  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SubitleCards('Firma'),
                const SizedBox(height: 30),
                SubitleCards(
                    "Para concluir tu registro sigue las indicaciones"),
                SizedBox(height: 20),

                Container(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(children: const <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '* Firma el contrato digital en todos los apartados obligatorios')),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '* Revisa tus datos ya qué son responsabilidad tuya que estén correctos')),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '* Verifica tus datos sensibles cuidadosamente')),
                    ]),
                  ),
                ),

                _Pantalla(),
                _IDMedico(),
                _IDInfo(),
                SizedBox(height: 30),

                if (_fadResponse == "" ||
                    _fadResponse ==
                        '{"fadResultCode":"-3428","resultCode":"3","result":"null"}')
                  ElevatedButton(
                    onPressed: () {
                      initMultiSign();
                    },
                    child: const Text('Iniciar Muiltifirma'),
                  ),
                /*const Text(
                  'Resultado',
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Text(
                      _fadResponse,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),*/

                SizedBox(
                  height: 20,
                ),

                //if (_fadResponse!="" && _fadResponse!='{"fadResultCode":"-3428","resultCode":"3","result":"null"}')
                _BotonEnviar(),
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
            /*print("***");
            print(_fadResponse );
            print("***");*/

            if (_fadResponse == "" ||
                _fadResponse ==
                    '{"fadResultCode":"-3428","resultCode":"3","result":"null"}') {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Por favor firma el contrato'),
                    );
                  });
            } else {
              PantallaRecibe = Pantalla.text;
              IDMedicoRecibe = IDMedico.text;
              IDInfoRecibe = IDInfo.text;
              Ingresar(PantallaRecibe, IDMedicoRecibe, IDInfoRecibe);
            }
          },
          child: const Text('Listo')),
    );
  }

  Widget _BotonSaltar() {
    return Container(
      width: double.infinity,
      //padding: EdgeInsets.all(10),
      child: ListTile(
        title: new Center(
            child: new Text(
          "---",
          style: new TextStyle(fontSize: 12.0),
        )),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PerfilMedVerificar()));
        },
      ),
    );
  }
}

/*MaterialColor customColor = const MaterialColor(
  0xFF540012,
  <int, Color>{
    50: Color(0xFFFCE4EC),
    100: Color(0xFFF8BBD0),
    200: Color(0xFFF48FB1),
    300: Color(0xFFF06292),
    400: Color(0xFFEC407A),
    500: Color(0xFFE91E63),
    600: Color(0xFFD81B60),
    700: Color(0xFFC2185B),
    800: Color(0xFFAD1457),
    900: Color(0xFF880E4F),
  },
);*/
