import 'package:flutter/material.dart';

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

import 'FinClinicas19.dart';

import 'package:intl/intl.dart';

class FinClinicas17_1 extends StatefulWidget {
  const FinClinicas17_1({super.key});

  @override
  State<FinClinicas17_1> createState() => _FinClinicas17_1State();
}

class _FinClinicas17_1State extends State<FinClinicas17_1> {
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
    return const MyCustomFormFinClinicas17_1();
  }
}

// Create a Form widget.
class MyCustomFormFinClinicas17_1 extends StatefulWidget {
  const MyCustomFormFinClinicas17_1({super.key});

  @override
  MyCustomFormFinClinicas17_1State createState() {
    return MyCustomFormFinClinicas17_1State();
  }
}

class MyCustomFormFinClinicas17_1State
    extends State<MyCustomFormFinClinicas17_1> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  ////////////////////////////

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDClinica = TextEditingController();

  final Acepto = TextEditingController();

  String PantallaRecibe = "";
  String IDClinicaRecibe = "";

  String AceptoRecibe = "";

  void Ingresar(
    Pantalla,
    IDClinica,
    Acepto,
  ) async {
    print("ok");
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Clinica/Agregar');
      var data={
        'Pantalla': Pantalla,
        'id_clinica': IDClinica,
        'RepresentacionLegal': "1", 
      };
      print(data);
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
              MaterialPageRoute(builder: (_) => FinClinicas19()));
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

    Pantalla.text = 'FinClinicas17_1';
    IDClinica.text = "$id_clinica";
  }

  Widget build(BuildContext context) {
    return BuildScreens(
        'Clínica', '', '', 'Datos de la clínica', '', _formulario());
  }

  Widget _formulario() {
    return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SubitleCards(
                        'Manifestación de representación legal'),
                    SizedBox(
                      height: 20,
                    ),      
                    _Pantalla(),
                    _IDClinica(),
                    
                    Container(
                        padding: EdgeInsets.only(left: 10.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            //border: Border.all(
                            //color: Colors.blueAccent
                            //)
                            ),
                        child: Text(
                          "En mi carácter de representante legal de la persona moral, declaro bajo protesta de decir verdad que, toda la información y datos indicados en esta declaración y sus anexos son verídicos, completos y vigentes a la fecha de firma de la presente. Adicionalmente declaro que cuento con las facultades suficientes y necesarias para acudir en nombre y representación de mi representada a realizar la presente declaración, y que a la firma del presente escrito no han sido modificadas ni revocadas. Asimismo en este acto declaro que cuento con la autorización por parte del (los) propietario(s) reale(s) para proporcionar sus datos personales necesarios para llevar a cabo la presente declaración. Finalmente, me comprometo a informar de manera inmediata a Fasol Soluciones S.A. de C.V., SOFOM E.N.R si se presenta un cambio en las circunstancias de la información contenida en este formulario.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 17,
                            //color: Colors.blue
                          ),
                          textScaleFactor: 1,
                        )),
                    _Acepto(),    
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

  
  
   bool ManifestacionOK = false;
  Widget _Acepto() {
    return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('Aceptar',
                      style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 87, 89, 92))),
                  value: ManifestacionOK,
                  onChanged: (value) {
                    setState(() {
                      ManifestacionOK = !ManifestacionOK;
                    });
                  },
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

              AceptoRecibe = Acepto.text;

              if (PantallaRecibe == "" ||
                  IDClinicaRecibe == "" ||
                  ManifestacionOK!=true
                  ) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                Ingresar(PantallaRecibe, IDClinicaRecibe,
                    ManifestacionOK);
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
              MaterialPageRoute(builder: (context) => FinClinicas19()));
        },
      ),
    );
  }
}
