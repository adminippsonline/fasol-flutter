import 'dart:async';

import 'package:fad_bio/fad_bio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plugin/plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/CRMs/CreditosDeSalud/Includes/firebase_options.dart';


import 'dart:developer' as dev;
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

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customColor,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String ticket="";

  void consultar_Texto() async {
    Consultar("1","1");
  }
   @override
  void initState() {
    super.initState();
    consultar_Texto();
    initMultiSign();

  }

  

  void Consultar(
    
      IDMedico,
      IDInfo) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'ApiApp/Medico/FirmarFAD.php');
      var data ={
        'Pantalla': "FinSolicitar35",
        'SubPantalla': 'FinSolicitar35_VideoInfo',
        'id_medico': IDMedico,
        'id_info': IDInfo
      };
      //print("manda esto");
      //print(data);
      var response = await http.post(url, body: data).timeout(const Duration(seconds: 90));
      //print("llego aqui 111");
      //print(response.body);

      if (response.body != "0" && response.body != "") {
        var Respuesta = jsonDecode(response.body);
        //print(Respuesta);
        String status = Respuesta['status'];
        ticket = Respuesta['ticket'];
        if (status == "OK") {
          print('Si recibo el ticket');
          print(ticket);
          
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

  

  String _fadResponse = "No iniciado";
  final _plugin = FadMultisignPlugin();
  final _fadBioPlugin = FadBio();

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
    });
  }

  String getPublicKey() {
    return "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5PxZ3DLj+zP6T6HFgzzk\nM77LdzP3fojBoLasw7EfzvLMnJNUlyRb5m8e5QyyJxI+wRjsALHvFgLzGwxM8ehz\nDqqBZed+f4w33GgQXFZOS4AOvyPbALgCYoLehigLAbbCNTkeY5RDcmmSI/sbp+s6\nmAiAKKvCdIqe17bltZ/rfEoL3gPKEfLXeN549LTj3XBp0hvG4loQ6eC1E1tRzSkf\nGJD4GIVvR+j12gXAaftj3ahfYxioBH7F7HQxzmWkwDyn3bqU54eaiB7f0ftsPpWM\nceUaqkL2DZUvgN0efEJjnWy5y1/Gkq5GGWCROI9XG/SwXJ30BbVUehTbVcD70+ZF\n8QIDAQAB\n-----END PUBLIC KEY-----";
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                initMultiSign();
              },
              child: const Text('Iniciar Muiltifirma'),
            ),
            const Text(
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
            ),
            _BotonEnviar()
          ],
        ),
      ),
    );
  }
  Widget _BotonEnviar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {


                Consultar(
                    "1",
                    "1");
              
          },
          child: const Text('Siguiente')),
    );
  }
}

MaterialColor customColor = const MaterialColor(
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
);
