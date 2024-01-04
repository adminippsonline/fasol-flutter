import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../headers.dart';
import '../../menu_lateral.dart';
import '../../menu_footer.dart';
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

import 'FinRegMedico36_sui_imagen_no_irve.dart';

import 'package:intl/intl.dart';
import 'dart:io';

class FinRegMedico36 extends StatefulWidget {
  const FinRegMedico36({super.key});

  @override
  State<FinRegMedico36> createState() => _FinRegMedico36State();
}

class _FinRegMedico36State extends State<FinRegMedico36> {
  //se usa para mostrar los datos del estado
  int id_medico = 0;
  int id_info = 0;
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
      id_info = prefs.getInt('id_info') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido $id_medico $id_info  $NombreCompletoSession"),
      ),
      drawer: MenuLateralPage(),
      bottomNavigationBar: MenuFooterPage(),
      body: const MyCustomFormFinRegMedico36(),
    );
  }
}

// Create a Form widget.
class MyCustomFormFinRegMedico36 extends StatefulWidget {
  const MyCustomFormFinRegMedico36({super.key});

  @override
  MyCustomFormFinRegMedico36State createState() {
    return MyCustomFormFinRegMedico36State();
  }
}

class MyCustomFormFinRegMedico36State
    extends State<MyCustomFormFinRegMedico36> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDMedico = TextEditingController();
  final IDInfo = TextEditingController();

  String PantallaRecibe = "";
  String IDMedicoRecibe = "";
  String IDInfoRecibe = "";

  void Ingresar(Pantalla, IDMedico, IDInfo) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'ApiApp/Medico/Actualizar.php');
      var response = await http.post(url, body: {
        'Pantalla': Pantalla,
        'id_medico': IDMedico,
        'id_info': IDInfo
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
              MaterialPageRoute(builder: (_) => FinRegMedico36()));
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
  int id_medico = 0;
  int id_info = 0;
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
      id_info = prefs.getInt('id_info') ?? 0;
    });

    Pantalla.text = 'FinSolicitar36';
    IDMedico.text = "$id_medico";
    IDInfo.text = "$id_info";
  }

  dynamic file;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    headerTop(
                        "$id_medico $id_info", ' Aqu van los servicos de'),
                    _Pantalla(),
                    _IDMedico(),
                    _IDInfo(),

                    ElevatedButton(
                        onPressed: () {
                          imagePicker();
                        },
                        child: Text('Selecciona una imagen',
                            style: TextStyle(color: Colors.white))),
                    if (file != null)
                      Image.file(file,
                          width: double.infinity,
                          height: 400,
                          fit: BoxFit.cover),
                    SizedBox(
                      height: 20,
                    ),
                    //imagen == null
                    //imagen==null ? Center()
                    //imagen==null ? Center():Image.file(imagen),
                    /*ElevatedButton(
                        onPressed: () {
                          subir_imagen();
                        },
                        child: Text('Selecciona una imagen',
                            style: TextStyle(color: Colors.white)))*/
                    //_BotonEnviar(),
                  ]),
            )));
  }

  void imagePicker() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        file = File(image.path);
      });
    }
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
              IDMedicoRecibe = IDMedico.text;
              IDInfoRecibe = IDInfo.text;

              if (PantallaRecibe == "" ||
                  IDMedicoRecibe == "" ||
                  IDInfoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                Ingresar(PantallaRecibe, IDMedicoRecibe, IDInfoRecibe);
              }
            }
          },
          child: const Text('Siguiente')),
    );
  }
}
