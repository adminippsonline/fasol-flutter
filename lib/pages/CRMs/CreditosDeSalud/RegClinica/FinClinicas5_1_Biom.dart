import 'dart:io';

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

//import 'FinRegMedico36.dart';

import 'package:intl/intl.dart';

import 'dart:async';

import 'package:fad_bio/fad_bio.dart';
//import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plugin/plugin.dart';

import 'FinClinicas5_1_Video.dart';

class FinClinicas5_1_Biom extends StatefulWidget {
  const FinClinicas5_1_Biom({super.key});

  @override
  State<FinClinicas5_1_Biom> createState() => _FinClinicas5_1_BiomState();
}

class _FinClinicas5_1_BiomState extends State<FinClinicas5_1_Biom> {
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
    return MyCustomFormFinClinicas5_1_Biom();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(NombreCompletoSession),
    //   ),
    //   drawer: MenuLateralPage(""),
    //   bottomNavigationBar: MenuFooterPage(),
    //   body: const MyCustomFormFinClinicas5_1(),
    // );
  }
}

// Create a Form widget.
class MyCustomFormFinClinicas5_1_Biom extends StatefulWidget {
  const MyCustomFormFinClinicas5_1_Biom({super.key});

  @override
  MyCustomFormFinClinicas5_1_BiomState createState() {
    return MyCustomFormFinClinicas5_1_BiomState();
  }
}

class MyCustomFormFinClinicas5_1_BiomState
    extends State<MyCustomFormFinClinicas5_1_Biom> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  String _fadResponse = "";
  final _plugin = FadMultisignPlugin();
  final _fadBioPlugin = FadBio();

  String getPublicKey() {
    return "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5PxZ3DLj+zP6T6HFgzzk\nM77LdzP3fojBoLasw7EfzvLMnJNUlyRb5m8e5QyyJxI+wRjsALHvFgLzGwxM8ehz\nDqqBZed+f4w33GgQXFZOS4AOvyPbALgCYoLehigLAbbCNTkeY5RDcmmSI/sbp+s6\nmAiAKKvCdIqe17bltZ/rfEoL3gPKEfLXeN549LTj3XBp0hvG4loQ6eC1E1tRzSkf\nGJD4GIVvR+j12gXAaftj3ahfYxioBH7F7HQxzmWkwDyn3bqU54eaiB7f0ftsPpWM\nceUaqkL2DZUvgN0efEJjnWy5y1/Gkq5GGWCROI9XG/SwXJ30BbVUehTbVcD70+ZF\n8QIDAQAB\n-----END PUBLIC KEY-----";
  }

  Future<void> initFace() async {
    String fadResponse;
    String config =
        '{ "module": "face", "config": { "appId": "*", "appVersion": "", "facetecMiddleware": "", "isShowPreview": true, "url": "", "token": "", "zoomPublicKey": "dAaa7DjCJH7f4zuLwJFFlSjgAXL6k8q2", "zoomLicenceKey": "003045022100db65874f1740325f95204c14ab545218f213570f753dbf87743fa15ed9fb0b0a0220220f9e64246a788d73150c4c7fc27f1cceab7b5eb084e01b665d837a0ebec96d", "zoomServerBaseURL": "https://facetec-preprod.firmaautografa.com", "zoomProductionKeyText": "${getPublicKey()}", "zoomExpirationDate": "2023-09-10"} }';
    try {
      fadResponse =
          await _fadBioPlugin.initFADBio(config) ?? 'Sin configuracion inicial';
      dev.log(fadResponse.toString());
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
  final IDClinica = TextEditingController();

  String PantallaRecibe = "";
  String IDClinicaRecibe = "";

  void Ingresar(Pantalla, IDClinica) async {
    try {
      final req = {
        'Pantalla': 'FinClinicas5_1',
        'SubPantalla': 'FinClinicas5_1_BiomUno',
        'id_clinica': IDClinica,
        'biometrico': globalimageUpdate
      };
      print("***");
      print(req);
      print("***");
      var url = Uri.https('fasoluciones.mx', 'api/Clinica/Agregar');
      var request = await http.MultipartRequest('POST', url);
      request = jsonToFormData(request, req);
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      var responseString = responseData;
      final datos = json.decode(responseString);
      var status = datos['status'].toString();
      dev.log("datosss");
      dev.log(status.toString());

      if (status == "OK") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Biometrico facial guardado  correctamente'),
              );
            });

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => FinClinicas5_1_Video()));
      }

      // var response = await http.post(url, body: {
      //   'Pantalla': Pantalla,
      //   'id_clinica': IDClinica,
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

    Pantalla.text = 'FinClinicas5_1_BiomUno';
    IDClinica.text = "$id_clinica";
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
  var globalimageUpdate = "";
  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SubitleCards('Biométricos'),
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
                              '* Evita contraluces, lugares oscuros y asegúrate de enfocar el rostro correctamente')),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '* Toma la fotografía con rostro descubierto sin gorras ni lentes de sol')),
                    ]),
                  ),
                ),
                _Pantalla(),
                _IDClinica(),
                SizedBox(height: 30),
                if (_fadResponse == "")
                  ElevatedButton(
                    onPressed: () {
                      initFace();
                    },
                    child: const Text('Tomar mi selfie'),
                  ),

                if (_fadResponse != "")
                  ElevatedButton(
                    onPressed: () {
                      initFace();
                    },
                    child: const Text('Actulizar mi selfie'),
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_fadResponse != "")
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
                //const Text(
                //'Resultado',
                //),
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
                      onPressed: () {
                        if (_fadResponse == "") {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error: Toma tu selfie'),
                                );
                              });
                        } else {
                          String ine = "";
                          var bytes;
                          var res = json.decode(_fadResponse);
                          //dev.log(res['faceB64'].toString());
                          var respuesta = res['faceB64'].toString();
                          String imagen = respuesta;
                          globalimageUpdate = imagen;
                          dev.log("imag");
                          dev.log(globalimageUpdate);

                          setState(() {
                            String imagen = respuesta;
                            globalimageUpdate = imagen;
                            //print(globalimageUpdate);
                            PantallaRecibe = Pantalla.text;
                            IDClinicaRecibe = IDClinica.text;
                            Ingresar(PantallaRecibe, IDClinicaRecibe);
                          });

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
                          //   // enviarINE(bytes, id_clinica, id_info);

                          //   //ESTE ES EL BUENO
                          //   //enviarINE(j['data'].toString(), id_clinica, id_info);
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
            var res = json.decode(_fadResponse);
            //dev.log(res['faceB64'].toString());
            var respuesta = res['faceB64'].toString();
            String imagen = respuesta;
            globalimageUpdate = imagen;
            dev.log("imag");
            dev.log(globalimageUpdate);

            setState(() {
              String imagen = respuesta;
              globalimageUpdate = imagen;
            });
            if (_formKey.currentState!.validate()) {
              PantallaRecibe = Pantalla.text;
              IDClinicaRecibe = IDClinica.text;

              if (PantallaRecibe == "" || IDClinicaRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                Ingresar(PantallaRecibe, IDClinicaRecibe);
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
              MaterialPageRoute(builder: (context) => FinClinicas5_1_Video()));
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
