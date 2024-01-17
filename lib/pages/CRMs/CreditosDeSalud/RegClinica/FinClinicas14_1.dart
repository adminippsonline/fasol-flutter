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

import 'FinClinicas15.dart';

import 'package:intl/intl.dart';

class FinClinicas14_1 extends StatefulWidget {
  const FinClinicas14_1({super.key});

  @override
  State<FinClinicas14_1> createState() => _FinClinicas14_1State();
}

class _FinClinicas14_1State extends State<FinClinicas14_1> {
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
    return MyCustomFormFinClinicas14_1();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(NombreCompletoSession),
    //   ),
    //   drawer: MenuLateralPage(""),
    //   bottomNavigationBar: MenuFooterPage(),
    // );
  }
}

// Create a Form widget.
class MyCustomFormFinClinicas14_1 extends StatefulWidget {
  const MyCustomFormFinClinicas14_1({super.key});

  @override
  MyCustomFormFinClinicas14_1State createState() {
    return MyCustomFormFinClinicas14_1State();
  }
}

class MyCustomFormFinClinicas14_1State
    extends State<MyCustomFormFinClinicas14_1> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  ////////////////////////////

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDClinica = TextEditingController();

  final Completo = TextEditingController();
  final CuantosFaltan = TextEditingController();

  String PantallaRecibe = "";
  String IDClinicaRecibe = "";

  String CompletoRecibe = "";
  String CuantosFaltanRecibe = "";

  File? imagenComprobante = null;
  File? imagenConstanciaSituacion = null;
  File? imagenConstanciaFirma = null;
  File? imagenOrganizacion = null;

  void Ingresar(
      Pantalla,
      IDClinica,
      globalimageUpdateComprobante,
      globalimageUpdateConstanciaSituacion,
      globalimageUpdateConstanciaFirma,
      globalimageUpdateOrganizacion) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Clinica/Agregar');
      var data = {
        'Pantalla': Pantalla,
        'id_clinica': IDClinica,
        'ComprobantteDeDomicilio': globalimageUpdateComprobante,
        'ConstanciaSituacionFiscal': globalimageUpdateConstanciaSituacion,
        'ConstanciaFirmaElectronica': globalimageUpdateConstanciaFirma,
        'OrganizacionDeLaEmpresa': globalimageUpdateOrganizacion
      };
      print(data);
      var response =
          await http.post(url, body: data).timeout(const Duration(seconds: 90));
      //print("llego aqui 111");
      print(response.body);

      if (response.body != "0" && response.body != "") {
        var Respuesta = jsonDecode(response.body);
        print(Respuesta);
        String status = Respuesta['status'];
        if (status == "OK") {
          //print('si existe aqui -----');
          /*showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Registrado correctamente'),
                );
              });*/
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => FinClinicas15()));
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

    Pantalla.text = 'FinClinicas14_1';
    IDClinica.text = "$id_clinica";
  }

  @override
  Widget build(BuildContext context) {
    return BuildScreens(
        'Clínica', '', '', 'Datos de la clínica', '', _formulario());
  }

  String? imagePath;
  var globalimageUpdateComprobante = "";
  var globalimageUpdateConstanciaSituacion = "";
  var globalimageUpdateConstanciaFirma = "";
  var globalimageUpdateOrganizacion = "";
  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // headerTop("Clínica",
                SubitleCards('Carga de documentos de la empresa '),
                SizedBox(
                  height: 20,
                ),

                _Pantalla(),
                _IDClinica(),

                SizedBox(height: 10),
                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        //border: Border.all(
                        //color: Colors.blueAccent
                        //)
                        ),
                    child: Text(
                      "Comprobante de domicilio",
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
                          dev.log("Comprobante");
                          setState(() {
                            dialogComprobante(context);
                          });
                        }),
                  ],
                ),
                imagenComprobante == null
                    ? Center()
                    : Text(
                        "${imagenComprobante!.path.toString()}",
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
                      "Constancia de Situación Fiscal",
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
                          dev.log("ConstanciaSituacion");
                          setState(() {
                            dialogConstanciaSituacion(context);
                          });
                        }),
                  ],
                ),
                imagenConstanciaSituacion == null
                    ? Center()
                    : Text(
                        "${imagenConstanciaSituacion!.path.toString()}",
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
                      "Constancia de firma electrónica ",
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
                          dev.log("Etado");
                          setState(() {
                            dialogConstanciaFirma(context);
                          });
                        }),
                  ],
                ),
                imagenConstanciaFirma == null
                    ? Center()
                    : Text(
                        "${imagenConstanciaFirma!.path.toString()}",
                        style: TextStyle(color: Colors.black),
                      ),

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
                      "Organigrama de la Empresa  ",
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
                          dev.log("Etado");
                          setState(() {
                            dialogOrganizacion(context);
                          });
                        }),
                  ],
                ),
                imagenOrganizacion == null
                    ? Center()
                    : Text(
                        "${imagenOrganizacion!.path.toString()}",
                        style: TextStyle(color: Colors.black),
                      ),

                SizedBox(
                  height: 30,
                ),
                _BotonEnviar(),
                SizedBox(
                  height: 20,
                ),
                _Avanzar()
              ]),
        ));
  }

  Future<void> dialogComprobante(BuildContext context) {
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
                      imagenComprobante = File(_pickedFile.path);
                      _pickedFile.readAsBytes().then((value) {
                        imagePath = _pickedFile.path;
                      });
                      setState(() {
                        imagePath = _pickedFile.path;
                        imagenComprobante = File(_pickedFile.name);
                        final bytes = File(imagePath!).readAsBytesSync();
                        dev.log(bytes.toString());
                        globalimageUpdateComprobante = base64Encode(bytes);
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

  Future<void> dialogConstanciaSituacion(BuildContext context) {
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
                      imagenConstanciaSituacion = File(_pickedFile.path);
                      _pickedFile.readAsBytes().then((value) {
                        imagePath = _pickedFile.path;
                      });
                      setState(() {
                        imagePath = _pickedFile.path;
                        imagenConstanciaSituacion = File(_pickedFile.name);
                        final bytes = File(imagePath!).readAsBytesSync();
                        dev.log(bytes.toString());
                        globalimageUpdateConstanciaSituacion =
                            base64Encode(bytes);
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

  Future<void> dialogConstanciaFirma(BuildContext context) {
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
                      imagenConstanciaFirma = File(_pickedFile.path);
                      _pickedFile.readAsBytes().then((value) {
                        imagePath = _pickedFile.path;
                      });
                      setState(() {
                        imagePath = _pickedFile.path;
                        imagenConstanciaFirma = File(_pickedFile.name);
                        final bytes = File(imagePath!).readAsBytesSync();
                        dev.log(bytes.toString());
                        globalimageUpdateConstanciaFirma = base64Encode(bytes);
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

  Future<void> dialogOrganizacion(BuildContext context) {
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
                      imagenOrganizacion = File(_pickedFile.path);
                      _pickedFile.readAsBytes().then((value) {
                        imagePath = _pickedFile.path;
                      });
                      setState(() {
                        imagePath = _pickedFile.path;
                        imagenOrganizacion = File(_pickedFile.name);
                        final bytes = File(imagePath!).readAsBytesSync();
                        dev.log(bytes.toString());
                        globalimageUpdateOrganizacion = base64Encode(bytes);
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

  Widget _CuantosFaltan() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: CuantosFaltan,
        decoration: InputDecoration(
            labelText: 'Agregar miembros ¿Cuántos ?',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _BotonEnviar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              PantallaRecibe = Pantalla.text;
              IDClinicaRecibe = IDClinica.text;

              /*print("hola");
              print(PantallaRecibe);
              print(IDClinicaRecibe);
              print("**");
              print("**");
              print(globalimageUpdateComprobante);
              print("--");
              print(globalimageUpdateUltima);
              print("++");
              print(globalimageUpdateEstado);
              print("hola");*/

              if (PantallaRecibe == "" ||
                  IDClinicaRecibe == "" ||
                  globalimageUpdateComprobante == "" ||
                  globalimageUpdateConstanciaSituacion == "" ||
                  globalimageUpdateConstanciaFirma == "" ||
                  globalimageUpdateOrganizacion == "") {
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
                    IDClinicaRecibe,
                    globalimageUpdateComprobante!,
                    globalimageUpdateConstanciaSituacion!,
                    globalimageUpdateConstanciaFirma!,
                    globalimageUpdateOrganizacion!);
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FinClinicas15()));
        },
      ),
    );
  }
}
