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

import 'FinClinicas10.dart';

import 'package:intl/intl.dart';

class FinClinicas9 extends StatefulWidget {
  const FinClinicas9({super.key});

  @override
  State<FinClinicas9> createState() => _FinClinicas9State();
}

class _FinClinicas9State extends State<FinClinicas9> {
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
    return MyCustomFormFinClinicas9();
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
class MyCustomFormFinClinicas9 extends StatefulWidget {
  const MyCustomFormFinClinicas9({super.key});

  @override
  MyCustomFormFinClinicas9State createState() {
    return MyCustomFormFinClinicas9State();
  }
}

class MyCustomFormFinClinicas9State extends State<MyCustomFormFinClinicas9> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  ////////////////
  String? _opcionesCompleto;
  bool _noCompleto = false;

  void SeleccionadoCompleto(value) {
    setState(() {
      print(value);
      _opcionesCompleto = value;
      _noCompleto = value == "No";
    });
  }

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

  void Ingresar(Pantalla, IDClinica, Completo, CunatosFaltan) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Clinica/Agregar');
      var data={
        'Pantalla': Pantalla,
        'id_clinica': IDClinica,
        'Completo': Completo,
        'Cuantos': CunatosFaltan
      };
      print(data);
      var response = await http.post(url, body: data).timeout(const Duration(seconds: 90));
      //print("llego aqui 111");
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
              MaterialPageRoute(builder: (_) => FinClinicas10()));
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

    Pantalla.text = 'FinClinicas9';
    IDClinica.text = "$id_clinica";
  }

  @override
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
                // headerTop("Clínica",
                SubitleCards(
                    'Datos del órgano de administración '),
                SubitleCards(
                    'de la sociedad'),
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
                      "¿El órgano de administración de la sociedad se encuentra completo?",
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
                          title: const Text('Si',
                              style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 126, 126, 126),
                              )),
                          value: "Si",
                          groupValue: _opcionesCompleto,
                          onChanged: SeleccionadoCompleto,
                        ),
                      ),
                      Expanded(
                          child: RadioListTile(
                        title: const Text('No',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 126, 126, 126),
                            )),
                        value: "No",
                        groupValue: _opcionesCompleto,
                        onChanged: SeleccionadoCompleto,
                      )),
                    ],
                  ),
                ),
                if (_noCompleto)
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(left: 0, bottom: 0),
                    child: _CuantosFaltan(),
                  ),
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

              String? CompletoRecibe = _opcionesCompleto;
              print(CompletoRecibe);
              if (CompletoRecibe == "" || CompletoRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Selecciona una opción'),
                      );
                    });
              }
              CuantosFaltanRecibe = CuantosFaltan.text;
              print("***");
                print(PantallaRecibe);
                print(IDClinicaRecibe);
                print(CompletoRecibe);
              print("***");  
              if (PantallaRecibe == "" ||
                  IDClinicaRecibe == "" ||
                  CompletoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                Ingresar(PantallaRecibe, IDClinicaRecibe,
                    CompletoRecibe, CuantosFaltanRecibe);
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
              MaterialPageRoute(builder: (context) => FinClinicas10()));
        },
      ),
    );
  }
}
