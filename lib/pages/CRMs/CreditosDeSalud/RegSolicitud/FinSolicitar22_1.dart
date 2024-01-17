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

//import 'FinSolicitar22_1_sui_imagen_no_irve.dart';

import 'FinSolicitar23.dart';

import 'package:intl/intl.dart';
import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:dio/dio.dart';

class FinSolicitar22_1 extends StatefulWidget {
  String idCredito = "";
  FinSolicitar22_1(this.idCredito);

  @override
  State<FinSolicitar22_1> createState() => _FinSolicitar22_1State();
}

class _FinSolicitar22_1State extends State<FinSolicitar22_1> {
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
    return MyCustomFormFinSolicitar22_1(widget.idCredito);
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar22_1 extends StatefulWidget {
  String idCredito = "";
  MyCustomFormFinSolicitar22_1(this.idCredito);

  @override
  MyCustomFormFinSolicitar22_1State createState() {
    return MyCustomFormFinSolicitar22_1State();
  }
}

class MyCustomFormFinSolicitar22_1State
    extends State<MyCustomFormFinSolicitar22_1> {
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
        dev.log(Respuesta);
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
              builder: (_) => FinSolicitar22_1(widget.idCredito)));
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

    Pantalla.text = 'FinSolicitar35';
    IDLR.text = "$id_solicitud";
    IDInfo.text = "$id_credito";
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
    //   dev.log(globalimageUpdate);
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
        'Pantalla': "FinSolicitar22_1",
        'id_solicitud': "$id_solicitud",
        'id_credito': widget.idCredito,
        'Selfie': globalimageUpdate
      };
      dev.log(id_solicitud.toString());

      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');
      var request = await http.MultipartRequest('POST', url);
      request = jsonToFormData(request, req);
      final response = await request.send();
      dev.log(response.statusCode.toString());

      final responseData = await response.stream.bytesToString();
      var responseString = responseData;
      final datos = json.decode(responseString);
      dev.log("datosasasas");
      dev.log(datos.toString());

      if (imagen == null) {
        dev.log("esta vacio");
        dev.log(globalimageUpdate.toString());
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Por favor selecciona una imagen'),
              );
            });
      } else {
        dev.log("tiene imagen");
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => FinSolicitar23(widget.idCredito)));
      }
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
                SubitleCards('Selfie'),
                SizedBox(height: 20),

                Container(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(children: const <Widget>[
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                              'Tómate una selfie con tu INE a la altura de la barbilla, cuida que se vea visible. ')),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child:
                              Text('Tu foto debe ser una muy buena calidad ')),
                      SizedBox(height: 10),
                      /*Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          '* Evita reflejos del sol y luces (lámparas o focos)')),
                          */
                    ]),
                  ),
                ),

                _Pantalla(),
                _IDLR(),
                _IDInfo(),
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
                      dev.log("entrando");
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
                Ingresar(PantallaRecibe, IDLRRecibe, IDInfoRecibe);
              }
            }
          },
          child: const Text('Siguiente')),
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FinSolicitar23(widget.idCredito)));
        },
      ),
    );
  }
}
