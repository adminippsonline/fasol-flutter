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

//import 'FinRegMedico33_1_sui_imagen_no_irve.dart';

import 'FinRegMedico34.dart';

import 'package:intl/intl.dart';
import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:dio/dio.dart';

class FinRegMedico33_1 extends StatefulWidget {
  const FinRegMedico33_1({super.key});

  @override
  State<FinRegMedico33_1> createState() => _FinRegMedico33_1State();
}

class _FinRegMedico33_1State extends State<FinRegMedico33_1> {
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
    return MyCustomFormFinRegMedico33_1();
  }
}

// Create a Form widget.
class MyCustomFormFinRegMedico33_1 extends StatefulWidget {
  const MyCustomFormFinRegMedico33_1({super.key});

  @override
  MyCustomFormFinRegMedico33_1State createState() {
    return MyCustomFormFinRegMedico33_1State();
  }
}

class MyCustomFormFinRegMedico33_1State
    extends State<MyCustomFormFinRegMedico33_1> {
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
        dev.log(Respuesta);
        String status = Respuesta['status'];
        if (status == "OK") {
          //print('si existe aqui -----');
          // showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return AlertDialog(
          //         title: Text('Registrado correctamente'),
          //       );
          //     });
          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (_) => FinRegMedico33_1()));
          // FocusScope.of(context).unfocus();
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

    Pantalla.text = 'FinSolicitar35';
    IDMedico.text = "$id_medico";
  }

  File? imagen = null;
  //ImagePicker picker = ImagePicker();
  final picker = ImagePicker();

  String _Base64 = "";
  String imagepath = "";

  String? imagePath;

  var globalimageUpdate = "";
  Future selImagen(op) async {
    //var ImagePiker;
    var pickedFile;

    if (op == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
      print(pickedFile);
    } else {
      // pickedFile = await picker.pickImage(source: ImageSource.gallery);
      final ImagePicker _picker = ImagePicker();
      XFile? _pickedFile = await _picker.pickImage(
          source: ImageSource.gallery, requestFullMetadata: false);
      imagePath = _pickedFile!.path;
      imagen = File(_pickedFile.path);
      _pickedFile.readAsBytes().then((value) {
        imagePath = _pickedFile.path;
      });
      setState(() {
        imagePath = _pickedFile.path;
        imagen = File(_pickedFile.path);
        final bytes = File(imagePath!).readAsBytesSync();
        dev.log(bytes.toString());
        globalimageUpdate = base64Encode(bytes);
      });
    }

    // setState(() {
    //   dev.log("***");

    //   dev.log("***");
    //   if (globalimageUpdate != null) {
    //     imagen = File(pickedFile.path);
    //     //cortar(File(pickedFile.path));
    //     print(imagen);

    //     /*try {
    //     var pickedFile = await picker.pickImage(source: ImageSource.camera);
    //     if (pickedFile != null) {
    //       print("OPcion 1");
    //       print(pickedFile);
    //       print("**");
    //       imagepath = pickedFile.path;
    //       File imagefile = File(imagepath); //convert Path to File
    //       Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
    //       String Archivo =
    //           base64.encode(imagebytes);
    //       _Base64 = Archivo;

    //       print(_Base64);

    //       Uint8List decodedbytes = base64.decode(Archivo);

    //       setState(() {});
    //     } else {
    //       print("No image is selected.");
    //     }
    //   } catch (e) {
    //     print("error while picking file.");
    //   } */
    //   } else {
    //     print("no selecionaste ninguna foto");
    //   }
    // });
    // //print("llego aqui 2222");
    Navigator.of(context).pop();
  }

  /*cortar (picked) async {
    File? cortado=await ImageCropper.cropImage(
      sourcePath: picked.path,
      aspectRatio: CropAspectRatio(
        ratioX: 1.0, 
        ratioY: 1.0
      )
    );
    if(cortado!=null){
      setState(() {
        imagen=cortado
      });
    }
  }*/

  Dio dio = new Dio();
  Future<void> subir_imagen() async {
    try {
      final req = {
        'Pantalla': 'FinSolicitar33_1',
        'id_medico': "$id_medico",
        //'file': globalimageUpdate
      };

      var url = Uri.https('fasoluciones.mx', 'api/Medico/Agregar');
      var request = await http.post(url,
          body: jsonEncode(<String, String>{
            'Pantalla': 'FinSolicitar33_1',
            'id_medico': id_medico.toString(),
          }));
      dev.log(request.body.toString());

      // var client = http.Client();
      // var request = http.MultipartRequest('POST', url);
      // request = jsonToFormData(request, req);

      // request.fields.addAll(req);

      // var file = await http.MultipartFile.fromString('file', globalimageUpdate);
      // request.files.add(file);

      // final response = await client.send(request);

      // if (response.statusCode == 302) {
      //   var redirectUrl = response.headers['location'];
      //   if (redirectUrl != null) {
      //     var redirectResponse = await http.post(url);
      //     final responseData = redirectResponse.body;
      //     dev.log(responseData.toString());
      //   }
      // }
      // request = jsonToFormData(request, req);
      // try {
      //   final respons = await client.send(request);
      //   dev.log(respons.statusCode.toString());

      //   if (response.statusCode == 302) {
      //     dev.log("e");
      //     // Manejar redirección obteniendo la nueva ubicación
      //     var redirectUrl = respons.headers['location'];
      //     if (redirectUrl != null) {
      //       var redirectUri = Uri.parse(redirectUrl);
      //       var redirectRequest = http.MultipartRequest('POST', redirectUri);
      //       redirectRequest = jsonToFormData(redirectRequest, req);
      //       final redirectResponse = await redirectRequest.send();
      //       dev.log(redirectResponse.statusCode.toString());
      //     } else {
      //       dev.log('Error: Redirección sin URL de ubicación');
      //     }
      //   } else {
      //     dev.log(response.statusCode.toString());
      //   }
      // } catch (error) {
      //   dev.log("error");
      // }

      // if (imagen == null) {
      //   showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           title: Text('Por favor selecciona una imagen'),
      //         );
      //       });
      // } else {
      //   Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(builder: (_) => FinRegMedico34()));
      // }
    } catch (e) {
      dev.log("as");
      dev.log(e.toString());
    }
  }

  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }

  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
                child: Column(
              children: [
                InkWell(
                  onTap: () {
                    selImagen(1);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey))),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Tomar una foto',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Icon(Icons.camera, color: Colors.blue)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    selImagen(2);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Seleccionar una foto',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Icon(Icons.image, color: Colors.blue)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.red),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Cancelar',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
          );
        });
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
                // headerTop("Médicos", 'Estado de cuenta'),
                SubitleCards('Estado de cuenta'),
                SizedBox(height: 20),

                Container(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(children: const <Widget>[
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                              'Selecciona la imagen de tus archivos o tomale foto')),
                      SizedBox(height: 10),
                      /*Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          '* Coloca la credencial sobre una superficie oscura para un mejor contraste')),
                  SizedBox(height: 10),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          '* Evita reflejos del sol y luces (lámparas o focos)')),
                          */
                    ]),
                  ),
                ),

                _Pantalla(),
                _IDMedico(),
                ElevatedButton(
                    onPressed: () {
                      opciones(context);
                    },
                    child: Text('Selecciona una imagen',
                        style: TextStyle(color: Colors.white))),

                SizedBox(
                  height: 20,
                ),
                //imagen == null
                //imagen==null ? Center()
                imagen == null ? Center() : Image.file(imagen!),
                ElevatedButton(
                    onPressed: () {
                      subir_imagen();
                    },
                    child: Text('Siguiente',
                        style: TextStyle(color: Colors.white))),
                //_BotonEnviar(),
                _Avanzar()
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

  Widget _BotonEnviar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              PantallaRecibe = Pantalla.text;
              IDMedicoRecibe = IDMedico.text;

              if (PantallaRecibe == "" || IDMedicoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                Ingresar(PantallaRecibe, IDMedicoRecibe);
              }
            }
          },
          child: const Text('Siguientes')),
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
              MaterialPageRoute(builder: (context) => FinRegMedico34()));
        },
      ),
    );
  }
}
