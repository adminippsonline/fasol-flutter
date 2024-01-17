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

import 'FinSolicitar23_4.dart';
import 'FinSolicitar23_1.dart';
//import 'FinRegMedico32.dart';
//import 'FinRegMedico33.dart';

import 'package:intl/intl.dart';

class FinSolicitar23_0 extends StatefulWidget {
  String idCredito = "";
  FinSolicitar23_0(this.idCredito);

  @override
  State<FinSolicitar23_0> createState() => _FinSolicitar23_0State();
}

class _FinSolicitar23_0State extends State<FinSolicitar23_0> {
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
    return MyCustomFormFinSolicitar23_0(widget.idCredito);
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar23_0 extends StatefulWidget {
  String idCredito = "";
  MyCustomFormFinSolicitar23_0(this.idCredito);

  @override
  MyCustomFormFinSolicitar23_0State createState() {
    return MyCustomFormFinSolicitar23_0State();
  }
}

//enum OpcionesFirmaElectronica { Si, No }
//enum OpcionesConCotizacion { Si, No }
//enum OpcionesEsConyugue { Si, No }

class MyCustomFormFinSolicitar23_0State
    extends State<MyCustomFormFinSolicitar23_0> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  String? _opcionesConCotizacion;
  bool _siConCotizacion = false;

  void SeleccionadoConCotizacion(value) {
    setState(() {
      _opcionesConCotizacion = value;
      _siConCotizacion = value == "1";
    });
  }

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDLR = TextEditingController();
  final IDInfo = TextEditingController();

  final ConCotizacion = TextEditingController();
  final MontoDeCotizacion = TextEditingController();

  File? imagenComprobante1 = null;

  String PantallaRecibe = "";
  String IDLRRecibe = "";
  String IDInfoRecibe = "";

  String ConCotizacionRecibe = "";
  String MontoDeCotizacionRecibe = "";

  void Ingresar(Pantalla, IDLR, IDInfo, ConCotizacion, MontoDeCotizacion,
      globalimageUpdateComprobante1) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');

      if (ConCotizacion == "0") {
        dev.log("cero");
        var bodyEnviar = {
          'Pantalla': Pantalla,
          'id_solicitud': IDLR,
          'id_credito': widget.idCredito,
          'SinCotizacion': ConCotizacion,
          // 'MontoDeCotizacion': MontoDeCotizacion,
          // 'Archivo': globalimageUpdateComprobante1
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
            if (ConCotizacion == "1") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar23_1(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar23_4(widget.idCredito)));
              FocusScope.of(context).unfocus();
            }
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
      } else if (ConCotizacion == "1") {
        var bodyEnviar = {
          'Pantalla': Pantalla,
          'id_solicitud': IDLR,
          'id_credito': widget.idCredito,
          'ConCotizacion': ConCotizacion,
          'MontoCotizacion': MontoDeCotizacion,
          'Archivo': globalimageUpdateComprobante1
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
            if (ConCotizacion == "1") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar23_1(widget.idCredito)));
              FocusScope.of(context).unfocus();
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => FinSolicitar23_4(widget.idCredito)));
              FocusScope.of(context).unfocus();
            }
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
      }

      // print(bodyEnviar);

      // print("llego aqui 111");
      // dev.log(response.body);

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
      //     if (ConCotizacion == "Si") {
      //       Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (_) => FinSolicitar23_1()));
      //       FocusScope.of(context).unfocus();
      //     } else {
      //       Navigator.of(context).pushReplacement(MaterialPageRoute(
      //           builder: (_) => FinSolicitar23_4(widget.idCredito)));
      //       FocusScope.of(context).unfocus();
      //     }
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

    Pantalla.text = 'FinSolicitar23_0';
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

  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SubitleCards("Cotización médica"),
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
                      "Para determinar el monto total del crédito, es importante que nos compartas tu cotización médica ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 17,
                        //color: Colors.blue
                      ),
                      textScaleFactor: 1,
                    )),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: const Text('Con cotización',
                              style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 126, 126, 126),
                              )),
                          value: "1",
                          groupValue: _opcionesConCotizacion,
                          onChanged: SeleccionadoConCotizacion,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: RadioListTile(
                        title: const Text('Sin cotización',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 126, 126, 126),
                            )),
                        value: "0",
                        groupValue: _opcionesConCotizacion,
                        onChanged: SeleccionadoConCotizacion,
                      )),
                    ],
                  ),
                ),
                if (_siConCotizacion)
                  Container(
                      padding: EdgeInsets.only(left: 1.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          //border: Border.all(
                          //color: Colors.blueAccent
                          //)
                          ),
                      child: Column(
                        children: [
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
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: _MontoDeCotizacion(),
                              ),
                              ElevatedButton(
                                  child: Text("Busca archivo"),
                                  onPressed: () async {
                                    dev.log("Comprobante1");
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
                        ],
                      )),
                SizedBox(
                  height: 20,
                ),
                _BotonEnviar(),
                SizedBox(
                  height: 20,
                ),
                _Avanzar()
              ]),
        ));
  }

  Widget _MontoDeCotizacion() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: MontoDeCotizacion,
        decoration: InputDecoration(
            labelText: 'Monto de la cotización',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
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
                        dev.log(bytes.toString());
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
              MontoDeCotizacionRecibe = MontoDeCotizacion.text;

              String? ConCotizacionRecibe = _opcionesConCotizacion;
              if (ConCotizacionRecibe == "" || ConCotizacionRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La opción Cotizacion  es obligatoria'),
                      );
                    });
              }

              if (PantallaRecibe == "" ||
                  IDLRRecibe == "" ||
                  IDInfoRecibe == "" ||
                  ConCotizacionRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                dev.log(ConCotizacionRecibe.toString());

                Ingresar(
                    PantallaRecibe,
                    IDLRRecibe,
                    IDInfoRecibe,
                    ConCotizacionRecibe,
                    MontoDeCotizacionRecibe,
                    globalimageUpdateComprobante1!);
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
                  builder: (context) => FinSolicitar23_1(widget.idCredito)));
        },
      ),
    );
  }
}
