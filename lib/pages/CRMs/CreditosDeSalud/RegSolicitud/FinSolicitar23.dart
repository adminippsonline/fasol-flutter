import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

import 'FinSolicitar23_0.dart';
//import 'FinRegMedico32.dart';
//import 'FinRegMedico33.dart';

import 'package:intl/intl.dart';

class FinSolicitar23 extends StatefulWidget {
  String idCredito = "";
  FinSolicitar23(this.idCredito);

  @override
  State<FinSolicitar23> createState() => _FinSolicitar23State();
}

class _FinSolicitar23State extends State<FinSolicitar23> {
  //se usa para mostrar los datos del Comprobante3
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
    return MyCustomFormFinSolicitar23(widget.idCredito);
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar23 extends StatefulWidget {
  String idCredito = "";
  MyCustomFormFinSolicitar23(this.idCredito);

  @override
  MyCustomFormFinSolicitar23State createState() {
    return MyCustomFormFinSolicitar23State();
  }
}

//enum OpcionesFirmaElectronica { Si, No }
//enum OpcionesTipoDeComprobante { Si, No }
//enum OpcionesEsConyugue { Si, No }

class MyCustomFormFinSolicitar23State
    extends State<MyCustomFormFinSolicitar23> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  String? _opcionesTipoDeComprobante;
  bool _siTipoDeComprobante = false;

  void SeleccionadoTipoDeComprobante(value) {
    setState(() {
      _opcionesTipoDeComprobante = value;
      _siTipoDeComprobante = value == "Si";
    });
  }

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDLR = TextEditingController();
  final IDInfo = TextEditingController();

  final TipoDeComprobante = TextEditingController();

  File? imagenComprobante1 = null;
  File? imagenComprobante2 = null;
  File? imagenComprobante3 = null;

  String PantallaRecibe = "";
  String IDLRRecibe = "";
  String IDInfoRecibe = "";

  String TipoDeComprobanteRecibe = "";

  void Ingresar(
      Pantalla,
      IDLR,
      IDInfo,
      TipoDeComprobante,
      globalimageUpdateComprobante1,
      globalimageUpdateComprobante2,
      globalimageUpdateComprobante3) async {
    try {
      dev.log("message");
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');

      var bodyEnviar = {
        'Pantalla': Pantalla,
        'id_solicitud': IDLR,
        'id_credito': widget.idCredito,
        'TipoDeComprobante': TipoDeComprobante,
        'ComDeNom1': globalimageUpdateComprobante1,
        'ComDeNom2': globalimageUpdateComprobante2,
        'ComDeNom3': globalimageUpdateComprobante3
      };

      var response = await http
          .post(url, body: bodyEnviar)
          .timeout(const Duration(seconds: 90));

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
              builder: (_) => FinSolicitar23_0(widget.idCredito)));
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
  //se usa para mostrar los datos del Comprobante3
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
      NombreCompletoSession = prefs.getString('NombreCompletoSession') ?? '';
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_credito = prefs.getInt('id_credito') ?? 0;
    });

    Pantalla.text = 'FinSolicitar23';
    IDLR.text = "$id_solicitud";
    IDInfo.text = "$id_credito";
  }

  @override
  Widget build(BuildContext context) {
    return BuildScreens(
        'Solicitud', '', '', 'Datos de la solicitud', '', _formulario());
  }

  String? imagePath;
  var globalimageUpdateComprobante1 = "";
  var globalimageUpdateComprobante2 = "";
  var globalimageUpdateComprobante3 = "";

  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SubitleCards("Carga de comprobación de ingresos  "),
                SizedBox(
                  height: 20,
                ),
                _Pantalla(),
                _IDLR(),
                _IDInfo(),
                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        //border: Border.all(
                        //color: Colors.blueAccent
                        //)
                        ),
                    child: Text(
                      "Por favor, adjunta tus 03 últimos comprobantes de ingresos ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 17,
                        //color: Colors.blue
                      ),
                      textScaleFactor: 1,
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: const Text('Comprobantes de nómina',
                              style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 126, 126, 126),
                              )),
                          value: "Comprobantes de nómina",
                          groupValue: _opcionesTipoDeComprobante,
                          onChanged: SeleccionadoTipoDeComprobante,
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                          child: RadioListTile(
                        title: const Text('Estados bancarios',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 126, 126, 126),
                            )),
                        value: "Estados bancarios",
                        groupValue: _opcionesTipoDeComprobante,
                        onChanged: SeleccionadoTipoDeComprobante,
                      )),
                    ],
                  ),
                ),

                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        //border: Border.all(
                        //color: Colors.blueAccent
                        //)
                        ),
                    child: Text(
                      "Comprobante 1",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        //color: Colors.blue
                      ),
                      textScaleFactor: 1,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: Text("Busca archivo"),
                        onPressed: () async {
                          setState(() {
                            dialogComprobante1(context);
                          });
                        }),
                  ],
                ),
                imagenComprobante1 == null
                    ? Center()
                    : Text(
                        "${imagenComprobante1!.path.toString()}",
                        style: TextStyle(color: Colors.black),
                      ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        //border: Border.all(
                        //color: Colors.blueAccent
                        //)
                        ),
                    child: Text(
                      "Comprobante 2",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        //color: Colors.blue
                      ),
                      textScaleFactor: 1,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: Text("Busca archivo"),
                        onPressed: () async {
                          setState(() {
                            dialogComprobante2(context);
                          });
                        }),
                  ],
                ),
                imagenComprobante2 == null
                    ? Center()
                    : Text(
                        "${imagenComprobante2!.path.toString()}",
                        style: TextStyle(color: Colors.black),
                      ),

                /////////////////
                ///
                ///
                SizedBox(height: 30),
                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        //border: Border.all(
                        //color: Colors.blueAccent
                        //)
                        ),
                    child: Text(
                      "Comprobante3 ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        //color: Colors.blue
                      ),
                      textScaleFactor: 1,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: Text("Busca archivo"),
                        onPressed: () async {
                          setState(() {
                            dialogComprobante3(context);
                          });
                        }),
                  ],
                ),
                imagenComprobante3 == null
                    ? Center()
                    : Text(
                        "${imagenComprobante3!.path.toString()}",
                        style: TextStyle(color: Colors.black),
                      ),

                SizedBox(
                  height: 20,
                ),
                _Avanzar(),

                _BotonEnviar(),
                SizedBox(
                  height: 20,
                ),
              ]),
        ));
  }

  Future<void> dialogComprobante1(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Obtener Imagen"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Galería"),
                    onTap: () async {
                      final ImagePicker _picker = ImagePicker();
                      XFile? _pickedFile = await _picker.pickImage(
                          source: ImageSource.gallery,
                          requestFullMetadata: false);
                      imagePath = _pickedFile!.path;
                      imagenComprobante1 = File(_pickedFile.path);
                      _pickedFile.readAsBytes().then((value) {
                        imagePath = _pickedFile.path;
                      });
                      setState(() {
                        imagePath = _pickedFile.path;
                        imagenComprobante1 = File(_pickedFile.name);
                        final bytes = File(imagePath!).readAsBytesSync();

                        globalimageUpdateComprobante1 = base64Encode(bytes);
                      });
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(child: Text("Tomar foto"), onTap: () {})
                ],
              ),
            ),
          );
        });
  }

  Future<void> dialogComprobante2(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Obtener Imagen"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Galería"),
                    onTap: () async {
                      final ImagePicker _picker = ImagePicker();
                      XFile? _pickedFile = await _picker.pickImage(
                          source: ImageSource.gallery,
                          requestFullMetadata: false);
                      imagePath = _pickedFile!.path;
                      imagenComprobante2 = File(_pickedFile.path);
                      _pickedFile.readAsBytes().then((value) {
                        imagePath = _pickedFile.path;
                      });
                      setState(() {
                        imagePath = _pickedFile.path;
                        imagenComprobante2 = File(_pickedFile.name);
                        final bytes = File(imagePath!).readAsBytesSync();

                        globalimageUpdateComprobante2 = base64Encode(bytes);
                      });
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(child: Text("Tomar foto"), onTap: () {})
                ],
              ),
            ),
          );
        });
  }

  Future<void> dialogComprobante3(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Obtener Imagen"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Galería"),
                    onTap: () async {
                      final ImagePicker _picker = ImagePicker();
                      XFile? _pickedFile = await _picker.pickImage(
                          source: ImageSource.gallery,
                          requestFullMetadata: false);
                      imagePath = _pickedFile!.path;
                      imagenComprobante3 = File(_pickedFile.path);
                      _pickedFile.readAsBytes().then((value) {
                        imagePath = _pickedFile.path;
                      });
                      setState(() {
                        imagePath = _pickedFile.path;
                        imagenComprobante3 = File(_pickedFile.name);
                        final bytes = File(imagePath!).readAsBytesSync();

                        globalimageUpdateComprobante3 = base64Encode(bytes);
                      });
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(child: Text("Tomar foto"), onTap: () {})
                ],
              ),
            ),
          );
        });
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

              String? TipoDeComprobanteRecibe = _opcionesTipoDeComprobante;
              if (TipoDeComprobanteRecibe == "" ||
                  TipoDeComprobanteRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La opción cargo político es obligatoria'),
                      );
                    });
              }

              if (PantallaRecibe == "" ||
                  IDLRRecibe == "" ||
                  IDInfoRecibe == "" ||
                  TipoDeComprobanteRecibe == "" ||
                  globalimageUpdateComprobante1 == "" ||
                  globalimageUpdateComprobante2 == "" ||
                  globalimageUpdateComprobante3 == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                Ingresar(
                    PantallaRecibe,
                    IDLRRecibe,
                    IDInfoRecibe,
                    TipoDeComprobanteRecibe,
                    globalimageUpdateComprobante1!,
                    globalimageUpdateComprobante2!,
                    globalimageUpdateComprobante3!);
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
                  builder: (context) => FinSolicitar23_0(widget.idCredito)));
        },
      ),
    );
  }
}
