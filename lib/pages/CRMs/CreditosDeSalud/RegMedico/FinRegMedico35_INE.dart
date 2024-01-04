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

import 'FinRegMedico36.dart';

import 'package:intl/intl.dart';

import 'dart:async';

import 'package:fad_bio/fad_bio.dart';
//import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plugin/plugin.dart';

import 'FinRegMedico35_Video.dart';
import 'FinRegMedico35_Biom.dart';

class FinRegMedico35_INE extends StatefulWidget {
  const FinRegMedico35_INE({super.key});

  @override
  State<FinRegMedico35_INE> createState() => _FinRegMedico35_INEState();
}

class _FinRegMedico35_INEState extends State<FinRegMedico35_INE> {
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
    return MyCustomFormFinRegMedico35_INE();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(NombreCompletoSession),
    //   ),
    //   drawer: MenuLateralPage(),
    //   bottomNavigationBar: MenuFooterPage(),
    //   body: const MyCustomFormFinRegMedico35(),
    // );
  }
}

// Create a Form widget.
class MyCustomFormFinRegMedico35_INE extends StatefulWidget {
  const MyCustomFormFinRegMedico35_INE({super.key});

  @override
  MyCustomFormFinRegMedico35_INEState createState() {
    return MyCustomFormFinRegMedico35_INEState();
  }
}

class MyCustomFormFinRegMedico35_INEState
    extends State<MyCustomFormFinRegMedico35_INE> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  String _fadResponse = "";
  final _plugin = FadMultisignPlugin();
  final _fadBioPlugin = FadBio();

  
  Future<void> initId() async {
    String fadResponse;
    const config =
        '{ "module": "id", "config": { "isAcuantFlowEnabled": true, "acUserName": "acuantEUUser@naat.com", "acPassword": "Q^59zWJzZ^jZrw^q", "acSubscription": "c681321c-2728-4e8a-a3df-a85ba8a11748", "acFrmEndpoint": "https://eu.frm.acuant.net", "acPassiveLivenessEndpoint": "https://eu.passlive.acuant.net", "acHealthInsuranceEndpoint": "https://medicscan.acuant.net", "acIdEndpoint": "https://eu.assureid.acuant.net", "acAcasEndpoint": "https://eu.acas.acuant.net", "acOzoneEndpoint": "https://eu.ozone.acuant.net" } }';

    try {
      fadResponse =
          await _fadBioPlugin.initFADBio(config) ?? 'Sin configuracion inicial';
      print(fadResponse);
    } on PlatformException {
      fadResponse = 'No se inicio FAD';
    }

    if (!mounted) return;

    setState(() {
      _fadResponse = fadResponse;
    });
  }

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDMedico = TextEditingController();

  String PantallaRecibe = "";
  String IDMedicoRecibe = "";

  void Ingresar(Pantalla, IDMedico, Uint8List imageBytes) async {
    try {
      String filename = globalineAnverso;
      if (filename != "") {
        final decodeBytes =
            base64.decode(globalineAnverso.replaceAll(RegExp(r'\s+'), ''));
        // dev.log(decodeBytes.toString());
        final dio = Dio();
        var url = "https://fasoluciones.mx/api/Medico/Agregar";

        final formData = FormData.fromMap({
          'Pantalla': 'FinSolicitar35',
          'SubPantalla': 'FinSolicitar35_INE',
          'id_medico': IDMedico,
          'info': globalinfoine,
          'ine_atras': MultipartFile.fromBytes(decodeBytes,
              filename: "ineanverso.png",
              contentType: MediaType('image', 'png')),
          'ine_frente': MultipartFile.fromBytes(imageBytes,
              filename: 'image.png', contentType: MediaType('image', 'png')),
        });

        var response = await dio.post(url, data: formData);
        //dev.log('Código de estado: ${response.statusCode}');
        //dev.log('Cuerpo de la respuesta: ${response.data}');

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => FinRegMedico35_Biom()));
        FocusScope.of(context).unfocus();

        // request.fields['Pantalla'] = 'FinSolicitar35_INE';
        // request.fields['SubPantalla'] = 'FinSolicitar35_INEAtras';
        // request.fields['id_medico'] = IDMedico;
        // //request.fields['ine_frente'] = globalimageUpdate;
        // List<int> imageBytes =  base64.decode(globalimageUpdate.replaceAll(RegExp(r'\s+'), ''));

        // http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
        //     'ine_frente', imageBytes,
        //     filename: 'image.jpg');

        // request.fields.addAll(multipartFile as Map<String, String>);

        // request.send().then((response) {
        //   if (response.statusCode == 200) {
        //     print('Imagen enviada con éxito');
        //   } else {
        //     print(
        //         'Error al enviar la imagen. Código de estado: ${response.statusCode}');
        //   }
        // }).catchError((error) {
        //   print('Error al enviar la imagen: $error');
        // });

        // request = jsonToFormData(request, req);
        // final response = await request.send();
        // final responseData = await response.stream.bytesToString();
        // dev.log(responseData.toString());
        // var responseString = responseData;
        // final datos = json.decode(responseString);
        // var status = datos['status'].toString();
        // dev.log("datosss");
        // dev.log(status.toString());

        // if (status == "OK") {
        //   showDialog(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return AlertDialog(
        //           title: Text('Biometrico facial guardado  correctamente'),
        //         );
        //       });

        //   // Navigator.of(context).pushReplacement(
        //   //     MaterialPageRoute(builder: (_) => FinRegMedico32()));
        // }

        // var response = await http.post(url, body: {
        //   'Pantalla': Pantalla,
        //   'id_medico': IDMedico,
        // }).timeout(const Duration(seconds: 90));
        // //print("llego aqui 111");
        // //print(response.body);

        // if (response.body != "0" && response.body != "") {
        //   var Respuesta = jsonDecode(response.body);
        //   print(Respuesta);
        //   String status = Respuesta['status'];
        //   if (status == "OK") {
        //     //print('si existe aqui -----');
        //     showDialog(
        //         context: context,
        //         builder: (BuildContext context) {
        //           return AlertDialog(
        //             title: Text('Registrado correctamente'),
        //           );
        //         });
        //     Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(builder: (_) => FinRegMedico36()));
        //     FocusScope.of(context).unfocus();
        //   } else {
        //     //print('Error en el registro');
        //     showDialog(
        //         context: context,
        //         builder: (BuildContext context) {
        //           return AlertDialog(
        //             title: Text('Error en el registro'),
        //           );
        //         });
        //   }
        // } else {
        //   //print('Error en el registro');
        //   showDialog(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return AlertDialog(
        //           title: Text("Error en el registro"),
        //         );
        //       });
        // }
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error: Carga tu identificación"),
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

    Pantalla.text = 'FinSolicitar35_BiomUno';
    IDMedico.text = "$id_medico";
  }

  @override
  Widget build(BuildContext context) {
    return BuildScreens('${NombreCompletoSession}', '', '',
        'Información Personal', '', _formulario());
  }

  Future<void> enviarINE(var ine, IDMedico) async {
    dev.log("enviando--...");
    dev.log(IDMedico.toString());
    // dev.log(ine);

    var url = Uri.https('fasoluciones.mx', 'api/Medico/Agregar');
    var request = await http.MultipartRequest('POST', url);
    final req = {
      'Pantalla': Pantalla,
      'id_medico': "$IDMedico",
      'ine': ine,
      'Biometricos': 1
    };

    request = jsonToFormData(request, req);
    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    dev.log("daaaaaaaaaaa");
    dev.log(responseData);
    var responseString = responseData;
    // final datos = json.decode(responseString);
  }

  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }

  var idResponseController = TextEditingController();

  String? imagePath;
  Uint8List? globalimageUpdate;

  File? imagen = null;
  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SubitleCards('INE/IFE'),
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
                              '* Al ser detectado la credencial se tomará en automático la fotografía')),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '* Coloca la credencial sobre una superficie oscura para un mejor contraste')),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '* Evita reflejos del sol y luces (lámparas o focos)')),
                    ]),
                  ),
                ),

                _Pantalla(),
                _IDMedico(),
                SizedBox(height: 30),
                
                if (_fadResponse=="") 
                ElevatedButton(
                  onPressed: () {
                    initId();
                  },
                  child: const Text('Cargar mi identificación'),
                ),

                if (_fadResponse!="") 
                ElevatedButton(
                  onPressed: () {
                    initId();
                  },
                  child: const Text('Actulizar mi identificación'),
                ),
                if (_fadResponse!="") 
                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        //border: Border.all(
                        //color: Colors.blueAccent
                        //)
                        ),
                    child: Text(
                      "Listo, puedes avanzar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        //color: Colors.blue
                      ),
                      textScaleFactor: 1,
                    )),

                // const Text(
                //   'Resultado',
                // ),
                // ElevatedButton(
                //     onPressed: () {
                //       Navigator.of(context).pushReplacement(MaterialPageRoute(
                //           builder: (_) => FinRegMedico35Video()));
                //       // dev.log(_fadResponse);
                //       // String ine = "";
                //       // var bytes;
                //       // var res = json.decode(_fadResponse);
                //       // //dev.log(res.toString());
                //       // for (var j in res['documents']) {
                //       //   dev.log(j['data']['foto.png'].toString());
                //       //   var bytes =
                //       //       File(j['data']['foto.png']).readAsBytesSync();
                //       //   dev.log(bytes.toString());

                //       //   globalimageUpdate = base64Encode(bytes);

                //       //   setState(() {
                //       //     var bytes =
                //       //         File(j['data']['foto.png']).readAsBytesSync();
                //       //     dev.log(bytes.toString());

                //       //     globalimageUpdate = base64Encode(bytes);
                //       //   });
                //       // }
                //     },
                //     child: Text("Resultado")),
                SizedBox(
                  height: 20,
                ),
                _BotonEnviar(),
                SizedBox(
                  height: 20,
                ),                
                _BotonSaltar(),
                _Avanzar(),
                SizedBox(
                  height: 20,
                ),
                
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

  
  var globalinfoine = "";
  var globalineAnverso = "";
  Widget _BotonEnviar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {
            //print("***");
            //print(_fadResponse );
            //print("***");

            if (_fadResponse == "") {
              showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Carga tu identificación'),
                      );
                    });
            }
            else{
              var res = json.decode(_fadResponse);
              for (var j in res['documents']) {
                  // dev.log(j['data'].toString());

                  var info = j['data'].toString();
                  var bytes = File(j['data']['foto.png']).readAsBytesSync();
                  var ineAnversoBytes = j['captures']['ineAnverso.png'];
                  // var bas = base64Encode(ineAnversoBytes);
                  // dev.log(bytes.toString());

                  globalimageUpdate = bytes;
                  globalinfoine = info;
                  globalineAnverso = ineAnversoBytes;
                  // dev.log(ineAnversoBytes);
                  // dev.log("byts");

                  setState(() {
                    globalinfoine = info;
                    globalineAnverso = ineAnversoBytes;
                  });

                  // setState(() {
                  //   var bytes = File(j['data']['foto.png']).readAsBytesSync();
                  //   // dev.log(bytes.toString());

                  //   globalimageUpdate = base64Encode(bytes);
                  // });
                }
                setState(() {
                  globalimageUpdate = globalimageUpdate;
                  globalinfoine = globalinfoine;
                  globalineAnverso = globalineAnverso;
                  // dev.log("anv");
                  // dev.log(globalineAnverso);

                  // dev.log(globalimageUpdate);
                  // dev.log("aqui hay byts");
                  // dev.log("imageee");
                  // dev.log(globalimageUpdate);
                });

                // for (var j in res['documents']) {
                //   dev.log(j['data']['foto.png'].toString());
                //   String image = j['data'].toString();
                //   globalimageUpdate = image;
                //   dev.log("envian");
                //   dev.log(globalimageUpdate);
                //   // dev.log("imagens");
                //   // dev.log(globalimageUpdate);
                //   setState(() {
                //     globalimageUpdate = image;
                //   });
                // }
                // setState(() {
                //   // dev.log("imagenes obten");
                //   // dev.log(globalimageUpdate);
                //   globalimageUpdate = globalimageUpdate;
                // });

                if (_formKey.currentState!.validate()) {
                  PantallaRecibe = Pantalla.text;
                  IDMedicoRecibe = IDMedico.text;

                  if (PantallaRecibe == "" ||
                      IDMedicoRecibe == "" ||
                      res == "") {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error: Carga tu identificación'),
                          );
                        });
                  } else {
                    Ingresar(PantallaRecibe, IDMedicoRecibe,
                        globalimageUpdate!);
                  }
                }

            }  
            
          },
          child: const Text('Siguiente')),
    );
  }

  Widget _BotonSaltar() {
    return Container(
      width: double.infinity,
      //padding: EdgeInsets.all(10),
      child: ListTile(
        title: new Center(
            child: new Text(
          "-***--",
          style: new TextStyle(fontSize: 12.0),
        )),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FinRegMedico35_Biom()));
        },
      ),
    );
  }
  Widget _Avanzar() {
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
              MaterialPageRoute(builder: (context) => FinRegMedico35_Biom()));
        },
      ),
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
