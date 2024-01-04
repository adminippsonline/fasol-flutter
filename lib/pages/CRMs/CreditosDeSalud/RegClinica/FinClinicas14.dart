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

import 'FinClinicas14_1.dart';

import 'package:intl/intl.dart';

class FinClinicas14 extends StatefulWidget {
  const FinClinicas14({super.key});

  @override
  State<FinClinicas14> createState() => _FinClinicas14State();
}

class _FinClinicas14State extends State<FinClinicas14> {
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
    return MyCustomFormFinClinicas14();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(NombreCompletoSession),
    //   ),
    //   drawer: MenuLateralPage(),
    //   bottomNavigationBar: MenuFooterPage(),
    // );
  }
}

// Create a Form widget.
class MyCustomFormFinClinicas14 extends StatefulWidget {
  const MyCustomFormFinClinicas14({super.key});

  @override
  MyCustomFormFinClinicas14State createState() {
    return MyCustomFormFinClinicas14State();
  }
}

class MyCustomFormFinClinicas14State extends State<MyCustomFormFinClinicas14> {
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

  File? imagenActa = null;
  File? imagenUltima = null;
  File? imagenEstado = null;

  void Ingresar(Pantalla, IDClinica, globalimageUpdateActa, globalimageUpdateUltima, globalimageUpdateEstado) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Clinica/Agregar');
      var data={
        'Pantalla': Pantalla,
        'id_clinica': IDClinica,
        'ActaConstitutiva':globalimageUpdateActa,
        'UltimaActa': globalimageUpdateUltima,
        'EstadoDeCuentaBancario': globalimageUpdateEstado
      };
      //print(data);
      var response = await http.post(url, body: data).timeout(const Duration(seconds: 90));
      //print("llego aqui 111");
      //print(response.body);

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
              MaterialPageRoute(builder: (_) => FinClinicas14_1()));
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

    Pantalla.text = 'FinClinicas14'; 
    IDClinica.text = "$id_clinica";
  }

  @override
  Widget build(BuildContext context) {
    return BuildScreens(
        'Clínica', '', '', 'Datos de la clínica', '', _formulario());
  } 

  String? imagePath;
  var globalimageUpdateActa = "";
  var globalimageUpdateUltima = "";
  var globalimageUpdateEstado = "";
  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // headerTop("Clínica",
                SubitleCards(
                    'Carga de documentos de la empresa '),
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
                      "Acta constitutiva",
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
                          dev.log("acta");
                          setState(() {
                            dialogActa(context);
                          });
                        }),
                  ],
                ),
                imagenActa == null
                    ? Center()
                    : Text(
                        "${imagenActa!.path.toString()}",
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
                      "Última acta constitutiva donde se aprecie el capital social vigente",
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
                          dev.log("acta");
                          setState(() {
                            dialogUltima(context);
                          });
                        }),
                  ],
                ),
                imagenUltima == null
                    ? Center()
                    : Text(
                        "${imagenUltima!.path.toString()}",
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
                      "Estado de cuenta bancario ",
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
                            dialogEstado(context);
                          });
                        }),
                  ],
                ),
                imagenEstado == null
                    ? Center()
                    : Text(
                        "${imagenEstado!.path.toString()}",
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

  Future<void> dialogActa(BuildContext context) {
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
                      imagenActa = File(_pickedFile.path);
                      _pickedFile.readAsBytes().then((value) {
                        imagePath = _pickedFile.path;
                      });
                      setState(() {
                        imagePath = _pickedFile.path;
                        imagenActa = File(_pickedFile.name);
                        final bytes = File(imagePath!).readAsBytesSync();
                        dev.log(bytes.toString());
                        globalimageUpdateActa = base64Encode(bytes);
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

  Future<void> dialogUltima(BuildContext context) {
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
                      imagenUltima = File(_pickedFile.path);
                      _pickedFile.readAsBytes().then((value) {
                        imagePath = _pickedFile.path;
                      });
                      setState(() {
                        imagePath = _pickedFile.path;
                        imagenUltima = File(_pickedFile.name);
                        final bytes = File(imagePath!).readAsBytesSync();
                        dev.log(bytes.toString());
                        globalimageUpdateUltima = base64Encode(bytes);
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


  Future<void> dialogEstado(BuildContext context) {
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
                      imagenEstado = File(_pickedFile.path);
                      _pickedFile.readAsBytes().then((value) {
                        imagePath = _pickedFile.path;
                      });
                      setState(() {
                        imagePath = _pickedFile.path;
                        imagenEstado = File(_pickedFile.name);
                        final bytes = File(imagePath!).readAsBytesSync();
                        dev.log(bytes.toString());
                        globalimageUpdateEstado = base64Encode(bytes);
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
              print(globalimageUpdateActa);
              print("--");
              print(globalimageUpdateUltima);
              print("++");
              print(globalimageUpdateEstado);
              print("hola");*/

              if (PantallaRecibe == "" ||
                  IDClinicaRecibe == "" ||
                  globalimageUpdateActa == ""  ||
                  globalimageUpdateUltima == ""  ||
                  globalimageUpdateEstado == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                Ingresar(PantallaRecibe, IDClinicaRecibe,
                    globalimageUpdateActa!, globalimageUpdateUltima!, globalimageUpdateEstado!);
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
              MaterialPageRoute(builder: (context) => FinClinicas14_1()));
        },
      ),
    );
  }
}
