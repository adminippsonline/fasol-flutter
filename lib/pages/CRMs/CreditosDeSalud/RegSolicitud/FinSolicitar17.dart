import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/CRMs/CreditosDeSalud/Includes/widgets/build_screen.dart';
import 'dart:developer' as dev;

import '../Includes/widgets/text.dart';
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

import 'FinSolicitar17_1.dart';
import 'FinSolicitar19.dart';

import 'package:intl/intl.dart';

class FinSolicitar17 extends StatefulWidget {
  const FinSolicitar17({super.key});

  @override
  State<FinSolicitar17> createState() => _FinSolicitar17State();
}

class _FinSolicitar17State extends State<FinSolicitar17> {
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
    return MyCustomFormFinSolicitar17();
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar17 extends StatefulWidget {
  const MyCustomFormFinSolicitar17({super.key});

  @override
  MyCustomFormFinSolicitar17State createState() {
    return MyCustomFormFinSolicitar17State();
  }
}

//enum OpcionesFirmaElectronica { Si, No }
//enum OpcionesEsPropietario { Si, No }
//enum OpcionesEscribeEsConyugue { Si, No }

class MyCustomFormFinSolicitar17State
    extends State<MyCustomFormFinSolicitar17> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  var MasccaraPeriodo = new MaskTextInputFormatter(
      mask: '0000-0000', filter: {"0": RegExp(r'[0-9]')});

  String? _opcionesEsPropietario;
  bool _siEsPropietario = false;

  void SeleccionadoEsPropietario(value) {
    setState(() {
      _opcionesEsPropietario = value;
      _siEsPropietario = value == "Si";
    });
  }

  String? _opcionesEscribeEsConyugue;
  bool _siEscribeEsConyugue = false;

  void SeleccionadoEscribeEsConyugue(value) {
    setState(() {
      _opcionesEscribeEsConyugue = value;
      _siEscribeEsConyugue = value == "Si";
    });
  }

  String? _opcionesEsPropietario2;
  bool _siEsPropietario2 = false;

  void SeleccionadoEsPropietario2(value) {
    setState(() {
      _opcionesEsPropietario2 = value;
      _siEsPropietario2 = value == "Si";
    });
  }

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDSolicitud = TextEditingController();
  final IDInfo = TextEditingController();

  String PantallaRecibe = "";
  String IDSolicitudRecibe = "";
  String IDInfoRecibe = "";

  void Ingresar(Pantalla, IDSolicitud, IDInfo) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');

      var bodyEnviar = {
        'Pantalla': Pantalla,
        'id_solicitud': IDSolicitud,
        'id_credito': IDInfo
      };
      print(bodyEnviar);
      var response = await http
          .post(url, body: bodyEnviar)
          .timeout(const Duration(seconds: 90));
      print("llego aqui 111***********");
      print(response.body);

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
          Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => FinSolicitar17_1()));
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
          prefs.getString('NombreCompletoSession') ?? '';
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_credito = prefs.getInt('id_credito') ?? 0;
    });

    Pantalla.text = 'FinSolicitar17';
    IDSolicitud.text = "$id_solicitud";
    IDInfo.text = "$id_credito";
  }



  @override 
  Widget build(BuildContext context) {
    return BuildScreens(
        'Solicitud', '', '', 'Datos de la solicitud', '', _formulario());
  } 


  Widget _formulario() {
    return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                   SubitleCards("Verificación de identidad "),
                    SizedBox(
                      height: 20,
                    ),
                    _Pantalla(),
                    _IDSolicitud(),
                    _IDInfo(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            //border: Border.all(

                            //)
                            ),
                        child: Text(
                          "Es importante verificar tu identidad, recibirás un código de autorización que será enviado a tu correo.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                          textScaleFactor: 1,
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

  Widget _IDSolicitud() {
    return Visibility(
        visible: false,
        child: Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: IDSolicitud,
            decoration: InputDecoration(
                labelText: 'IDSolicitud',
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
              IDSolicitudRecibe = IDSolicitud.text;
              IDInfoRecibe = IDInfo.text;

              if (PantallaRecibe == "" ||
                  IDSolicitudRecibe == "" ||
                  IDInfoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                Ingresar(PantallaRecibe, IDSolicitudRecibe, IDInfoRecibe);
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
          "Avanzartemporal",
          style: new TextStyle(fontSize: 12.0),
        )),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FinSolicitar19()));
        },
      ),
    );
  }
}
