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

import 'FinSolicitar16.dart';

import 'package:intl/intl.dart';

class FinSolicitar15_negativa extends StatefulWidget {
  const FinSolicitar15_negativa({super.key});

  @override
  State<FinSolicitar15_negativa> createState() => _FinSolicitar15_negativaState();
}

class _FinSolicitar15_negativaState extends State<FinSolicitar15_negativa> {
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
    return MyCustomFormFinSolicitar15_negativa();
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar15_negativa extends StatefulWidget {
  const MyCustomFormFinSolicitar15_negativa({super.key});

  @override
  MyCustomFormFinSolicitar15_negativaState createState() {
    return MyCustomFormFinSolicitar15_negativaState();
  }
}

class MyCustomFormFinSolicitar15_negativaState
    extends State<MyCustomFormFinSolicitar15_negativa> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();


  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDClinica = TextEditingController();
  final IDInfo = TextEditingController();

  String PantallaRecibe = "";
  String IDClinicaRecibe = "";
  String IDInfoRecibe = "";

  void Ingresar(
      Pantalla,
      IDClinica,
      IDInfo) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');
      var response = await http.post(url, body: {
        'Pantalla': Pantalla,
        'id_solicitud': IDClinica,
        'id_credito': IDInfo,
      }).timeout(const Duration(seconds: 90));
      //print("llego aqui 111");
      //print(response.body);

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
              MaterialPageRoute(builder: (_) => FinSolicitar16()));
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

    Pantalla.text = 'FinSolicitar15_negativa';
    IDClinica.text = "$id_solicitud";
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
                    SubitleCards("Estimado Cliente:"),
                    SizedBox(
                      height: 20,
                    ),
                    _Pantalla(),
                    _IDClinica(),
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
                          "Fasol Soluciones agradece tu preferencia y el intéres en nuestro producto Credi-Salud",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                            //color: Colors.blue
                          ),
                          textScaleFactor: 1,
                        )),


                    Container(
                        padding: EdgeInsets.only(left: 10.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            //border: Border.all(
                            //color: Colors.blueAccent
                            //)
                            ),
                        child: Text( 
                          "Sin embargo, por las variables presentadas durante tu proceso de solicitud no es posible otorgarte el financiamiento.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                            //color: Colors.blue
                          ),
                          textScaleFactor: 1,
                        )),



                    SizedBox(
                      height: 20,
                    ),
                    //_BotonEnviar(),
                    SizedBox(
                      height: 20,
                    ),
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
              IDClinicaRecibe = IDClinica.text;
              IDInfoRecibe = IDInfo.text;
              if (PantallaRecibe == "" ||
                  IDClinicaRecibe == "" ||
                  IDInfoRecibe == "" ) {
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
                    IDInfoRecibe);
              }
            }
          },
          child: const Text('Siguiente')),
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
