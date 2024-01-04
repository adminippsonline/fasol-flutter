import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

import 'package:fad_bio/fad_bio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plugin/plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import '../includes/firebase_options.dart';

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

import 'FinSolicitar22.dart';

import 'package:intl/intl.dart';

import 'package:fad_bio/fad_bio.dart';
//import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plugin/plugin.dart';


class FinSolicitar21_Video extends StatefulWidget {
  const FinSolicitar21_Video({super.key});

  @override
  State<FinSolicitar21_Video> createState() => _FinSolicitar21_VideoState();
}

class _FinSolicitar21_VideoState extends State<FinSolicitar21_Video> {
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
    return const MyCustomFormFinSolicitar21_Video();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(NombreCompletoSession),
    //   ),
    //   drawer: MenuLateralPage(),
    //   bottomNavigationBar: MenuFooterPage(),
    //   body: const MyCustomFormFinSolicitar21(),
    // );
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar21_Video extends StatefulWidget {
  const MyCustomFormFinSolicitar21_Video({super.key});

  @override
  MyCustomFormFinSolicitar21_VideoState createState() {
    return MyCustomFormFinSolicitar21_VideoState();
  }
}

class MyCustomFormFinSolicitar21_VideoState
    extends State<MyCustomFormFinSolicitar21_Video> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  String _fadResponse = "";
  final _plugin = FadMultisignPlugin();
  final _fadBioPlugin = FadBio();

  Future<void> initVideoAgreement() async {
    String fadResponse;
    String config =
        '{ "module": "videoagreement",  "config": {"textToDisplay": "Texto enviado desde Dart", "idCapture": false, "maximumTimeForRecording": 30, "minimumTimeForRecording": 7, "msWordSpeech": 50, "forceIdCrop": false}}';

    try {
      fadResponse =
          await _fadBioPlugin.initFADBio(config) ?? 'Sin configuracion inicial';
    } on PlatformException {
      fadResponse = 'No se inicio FadBio';
    }

    if (!mounted) return;

    setState(() {
      _fadResponse = fadResponse;
    });
  }

  String getPublicKey() {
    return "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5PxZ3DLj+zP6T6HFgzzk\nM77LdzP3fojBoLasw7EfzvLMnJNUlyRb5m8e5QyyJxI+wRjsALHvFgLzGwxM8ehz\nDqqBZed+f4w33GgQXFZOS4AOvyPbALgCYoLehigLAbbCNTkeY5RDcmmSI/sbp+s6\nmAiAKKvCdIqe17bltZ/rfEoL3gPKEfLXeN549LTj3XBp0hvG4loQ6eC1E1tRzSkf\nGJD4GIVvR+j12gXAaftj3ahfYxioBH7F7HQxzmWkwDyn3bqU54eaiB7f0ftsPpWM\nceUaqkL2DZUvgN0efEJjnWy5y1/Gkq5GGWCROI9XG/SwXJ30BbVUehTbVcD70+ZF\n8QIDAQAB\n-----END PUBLIC KEY-----";
  }

  

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDLR = TextEditingController();
  final IDInfo = TextEditingController();

  String PantallaRecibe = "";
  String IDLRRecibe = "";
  String IDInfoRecibe = "";

  void Ingresar(Pantalla, IDLR, IDInfo, Uint8List videoBytes) async {
    try {
      final dio = Dio();
      var url = "https://fasoluciones.mx/api/Solicitud/Agregar";
      final formData = FormData.fromMap({
        'Pantalla': 'FinSolicitar21',
        'SubPantalla': 'FinSolicitar21_Video',
        'id_solicitud': IDLR,
        'id_credito': IDInfo,
        'video': MultipartFile.fromBytes(videoBytes,
            filename: 'video.mp4', contentType: MediaType('video', 'mp4')),
      });

      var response = await dio.post(url, data: formData);
      dev.log('Código de estado: ${response.statusCode}');
      dev.log('Cuerpo de la respuesta: ${response.data}');

      Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => FinSolicitar22()));
        FocusScope.of(context).unfocus();

      // var videoFile = http.MultipartFile.fromBytes('video', videoBytes,
      //     contentType: MediaType('video', 'mp4'));

      // request.files.add(videoFile);
      // // request.fields['Pantalla'] = 'FinSolicitar21_Video';
      // // request.fields['SubPantalla'] = 'FinSolicitar21_VideoInfo';
      // // request.fields['id_solicitud'] = IDLR;
      // // request.fields['id_credito'] = IDInfo;

      // dev.log("se envio");
      // final response = await request.send();
      // final responseStream = await response.stream.toBytes();
      // final responseString = utf8.decode(responseStream);
      // dev.log(responseString);

      // final responseData = await response.stream.bytesToString();
      // var responseString = responseData;
      // final datos = json.decode(responseString);
      // var status = datos['status'].toString();
      // dev.log(status.toString());

      //request.fields.addAll(globalVideoUpdate);

      // request = jsonToFormData(request, req);
      // final response = await request.send();
      // final responseData = await response.stream.bytesToString();
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
      //   //     MaterialPageRoute(builder: (_) => FinSolicitar21INE()));
      // }

      // var response = await http.post(url, body: {
      //   'Pantalla': Pantalla,
      //   'id_solicitud': IDLR,
      //   'id_credito': IDInfo,
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
      //         MaterialPageRoute(builder: (_) => FinSolicitar22()));
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

  void Consultar(
    
      IDLR,
      IDInfo) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');
      var data ={
        'Pantalla': "FinSolicitar21",
        'SubPantalla': 'FinSolicitar21_VideoInfo',
        'id_solicitud': IDLR,
        'id_credito': IDInfo
      };
      print(data);
      var response = await http.post(url, body: data).timeout(const Duration(seconds: 90));
      print("llego aqui 111");
      print(response.body);

      if (response.body != "0" && response.body != "") {
        var Respuesta = jsonDecode(response.body);
        //print(Respuesta);
        String status = Respuesta['status'];
        if (status == "OK") {
          //print('si existe aqui -----');
          
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
  String TelefonoSession = "";

  @override
  void initState() {
    super.initState();
    mostrar_datos();
    consultar_Texto();
  }

  void consultar_Texto() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      NombreCompletoSession =
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_credito = prefs.getInt('id_credito') ?? 0;
    });

    Pantalla.text = 'FinSolicitar21_Video';
    IDLR.text = "$id_solicitud";
    IDInfo.text = "$id_credito";
    Consultar("$id_solicitud","$id_credito");
  }

  void mostrar_datos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      NombreCompletoSession =
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_credito = prefs.getInt('id_credito') ?? 0;
    });

    Pantalla.text = 'FinSolicitar21_Video';
    IDLR.text = "$id_solicitud";
    IDInfo.text = "$id_credito";
  }

  @override
  Widget build(BuildContext context) {
    return BuildScreens('${NombreCompletoSession}', '', '',
        'Información Personal', '', _formulario());
  }

 
 
  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }

  var idResponseController = TextEditingController();

  String? imagePath;
  Uint8List? globalVideoUpdate;
  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SubitleCards('Video Agreement'),
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
                              '* Muestra tu identificación y confirma tus datos por medio de una video grabación')),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '* Recuerda no hacer uso de lentes de sol gafas y otros elementos que dificulten la identificación de tu cuenta')),
                    ]),
                  ),
                ),
               
                _Pantalla(),
                _IDLR(),
                _IDInfo(),
                SizedBox(height: 30),
                if (_fadResponse=="") 
                ElevatedButton(
                  onPressed: () {
                    initVideoAgreement();
                  },
                  child: const Text('Iniciar Acuerdo Video'),
                ),
                if (_fadResponse!="") 
                ElevatedButton(
                  onPressed: () {
                    initVideoAgreement();
                  },
                  child: const Text('Actulizar Acuerdo video'),
                ),

                SizedBox(
                  height: 20,
                ),
                if (_fadResponse!="" && _fadResponse != "Cancelado por el usuario") 
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
                // Container(
                //   margin: EdgeInsets.all(16),
                //   child: SingleChildScrollView(
                //     physics: AlwaysScrollableScrollPhysics(),
                //     child: Expanded(
                //       child: Text(
                //         _fadResponse,
                //         style: TextStyle(fontSize: 12),
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_fadResponse == "") {
                        showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error: Graba tu video'),
                                );
                              }); 
                      }
                      else if (_fadResponse == "Cancelado por el usuario") {
                        showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error: Cancelado por el usuario'),
                                );
                              }); 
                      }
                      else{


                        dev.log(_fadResponse);
                        String ine = ""; 

                        var res = json.decode(_fadResponse);
                        // dev.log(res.toString());
                        // dev.log(res['videoAgreementResult'].toString());
                        // dev.log(res['videoAgreementResult']['file']
                        //         ['videoAgreement.mp4']
                        //     .toString());
                        final bytes = File(res['videoAgreementResult']['file']
                                ['videoAgreement.mp4'])
                            .readAsBytesSync();

                            
                        // dev.log(bytes.toString());

                        setState(() {
                          globalVideoUpdate = bytes;
                           //print(globalimageUpdate);
                          PantallaRecibe = Pantalla.text;
                          IDLRRecibe = IDLR.text;
                          IDInfoRecibe = IDInfo.text;  
                          Ingresar(PantallaRecibe, IDLRRecibe, IDInfoRecibe, bytes);
                        });

                        // final bytes = await blobToBytes(
                        //     res['videoAgreementResult']['file']
                        //         ['videoAgreement.mp4']);
                        // final directory =
                        //     await getApplicationDocumentsDirectory();
                        // final filePath = '${directory.path}/video.mp4';

                        // final bytes = File(res['videoAgreementResult']['file']
                        //     ['videoAgreement.mp4']);

                        // dev.log(bytes.toString());

                        // final blob = new Blob(await bytes.readAsBytes());

                        // for (var j in res['videoAgreementResult']) {
                        //   dev.log(j.toString());
                        //   // dev.log(j['videoAgreement.mp4']);
                        // }
                        //dev.log(res['faceB64'].toString());
                        // var respuesta = res['faceB64'].toString();
                        // String imagen = respuesta;
                        // globalVideoUpdate = imagen;
                        // dev.log("imag");
                        // dev.log(globalVideoUpdate);

                        // setState(() {
                        //   String imagen = respuesta;
                        //   globalVideoUpdate = imagen;
                        // });

                        // for (var j in res['documents']) {
                        //   dev.log(j['captures']['ineAnverso.png'].toString());
                        //   //  ine = j['data'].toString();
                        //   //bytes = base64Encode(j['captures']);
                        //   // setState(() {
                        //   //   ine = j['data'].toString();
                        //   // });

                        //   var bytes =
                        //       File(j['captures']['ineAnverso.png']).readAsBytes();
                        //   dev.log(bytes.toString());

                        //   // base64Encode(j['captures']['ineAnverso.png']);
                        //   // enviarINE(bytes, id_solicitud, id_credito);

                        //   //ESTE ES EL BUENO
                        //   //enviarINE(j['data'].toString(), id_solicitud, id_credito);
                        // }

                        // var resp = _fadResponse.toString();
                        // var respuesta = json.encode(_fadResponse);
                        // dev.log("obtebiendo");
                        // dev.log(respuesta);
                      }
                    },
                    child: Text("Siguiente")),
                ),   
                SizedBox(
                  height: 20,
                ),
                //if (_fadResponse != null) _BotonEnviar(),
                SizedBox(
                  height: 20,
                ),
                _BotonSaltar(),
                //_Avanzar
              ]),
        ));
  }

  // Future<void> saveBlobAsVideo(Flow blob) async {
  //   final cacheManager = DefaultCacheManager();
  //   final fileExtension = '.mp4'; // Extensión del archivo de video

  //   final bytes = await blobToBytes(blob);
  //   final file = await cacheManager.putFile(
  //     cacheManager.getCacheKey(blob.toString()),
  //     bytes,
  //     fileExtension: fileExtension,
  //   );

  //   print('Video guardado exitosamente en: ${file.path}');
  // }

//   Future<Uint8List> blobToBytes(Blob blob) async {
//   final completer = Completer<Uint8List>();

//   final reader = FileReader();
//   reader.readAsArrayBuffer(blob);

//   reader.onLoadEnd.listen((_) {
//     final result = reader.result as Uint8List;
//     completer.complete(result);
//   });

//   reader.onError.listen((dynamic error) {
//     completer.completeError(error);
//   });

//   return completer.future;
// }

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

//   Future<Blob> fileToBlob(File file) async {
//   final tempFile = await createTempFile();
//   await file.copy(tempFile.path);

//   final blob = new  Blob([tempFile.openRead()]);
//   return blob;
// }

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
            var res = json.decode(_fadResponse);
            //dev.log(res['faceB64'].toString());

            // dev.log(res.toString());
            // dev.log(res['videoAgreementResult'].toString());
            // dev.log(res['videoAgreementResult']['file']
            //         ['videoAgreement.mp4']
            //     .toString());
            final videoBytes =
                File(res['videoAgreementResult']['file']['videoAgreement.mp4'])
                    .readAsBytesSync();

            if (_formKey.currentState!.validate()) {
              PantallaRecibe = Pantalla.text;
              IDLRRecibe = IDLR.text;
              IDInfoRecibe = IDInfo.text;

              if (PantallaRecibe == "" ||
                  IDLRRecibe == "" ||
                  IDInfoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                // dev.log(videoBytes.toString());
                // dev.log("aquis arribas hay bytes");
                Ingresar(
                    PantallaRecibe, IDLRRecibe, IDInfoRecibe, videoBytes);
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
          "---",
          style: new TextStyle(fontSize: 12.0),
        )),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FinSolicitar22()));
        },
      ),
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
