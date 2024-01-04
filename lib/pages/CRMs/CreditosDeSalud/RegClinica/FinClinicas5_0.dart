import 'package:flutter/material.dart';

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

import 'FinClinicas5_1_INE.dart';

import 'package:intl/intl.dart';

class FinClinicas5_0 extends StatefulWidget {
  const FinClinicas5_0({super.key});

  @override
  State<FinClinicas5_0> createState() => _FinClinicas5_0State();
}

class _FinClinicas5_0State extends State<FinClinicas5_0> {
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
    return MyCustomFormFinClinicas5_0();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(NombreCompletoSession),
    //   ),
    //   drawer: MenuLateralPage(),
    //   bottomNavigationBar: MenuFooterPage(),
    //   body: const MyCustomFormFinClinicas5_0(),
    // );
  }
}

// Create a Form widget.
class MyCustomFormFinClinicas5_0 extends StatefulWidget {
  const MyCustomFormFinClinicas5_0({super.key});

  @override
  MyCustomFormFinClinicas5_0State createState() {
    return MyCustomFormFinClinicas5_0State();
  }
}

class MyCustomFormFinClinicas5_0State
    extends State<MyCustomFormFinClinicas5_0> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDClinica = TextEditingController();

  String PantallaRecibe = "";
  String IDClinicaRecibe = "";

  void Ingresar(Pantalla, IDClinica, ActuoEnNombreYcuentaPropia,
      AceptoGrabarVozEImagen) async {
    try {
      print("***");
      print(Pantalla);
      print("***");
      var url = Uri.https('fasoluciones.mx', 'api/Clinica/Agregar');
      var response = await http.post(url, body: {
        'Pantalla': Pantalla,
        'id_clinica': IDClinica,
        'actuo_en_nombre_propio': "1",
        'acepto_grabacion': "1"
      }).timeout(const Duration(seconds: 90));
      print("llego aqui 111");
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
              MaterialPageRoute(builder: (_) => FinClinicas5_1_INE()));
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

    Pantalla.text = 'FinClinicas5_0';
    IDClinica.text = "$id_clinica";
  }

  //final IDClinica = TextEditingController();

  //bool _checkbox = false;
  /*String? OpcionesActuoEnNombreYcuentaPropia;
  String? OpcionesAceptoGrabarVozEImagen;

  final ActuoEnNombreYcuentaPropia = TextEditingController();
  final AceptoGrabarVozEImagen = TextEditingController();

  String? StringActuoEnNombreYcuenta = "";
  String StringAceptoGrabarVozEImagen = "";

  String ActuoEnNombreYcuentaRecibe = "";
  String AceptoGrabarVozEImagenRecibe = "";

  String _actuoEnNombreYcuentaPropia = "1";
  String _aceptoGrabarVozEImagen = "1";*/

  bool ActuoEnNombreYcuentaPropia = false;
  bool AceptoGrabarVozEImagen = false;

  @override
  Widget build(BuildContext context) {
    return BuildScreens(
        'Clínica', '', '', 'Datos de la clínica', '', _formulario());
  }

  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, 
          children: <Widget>[
                // headerTop("¡¡¡Recuerda!!!!",
                //     'Para concluir tu registro como médico afiliado a la RED MÉDICA de Fasol Soluciones, necesitamos lo siguiente: '),

                SubitleCards("¡¡¡Recuerda!!!!"),
                SizedBox(
                  height: 20,
                ),
                SubitleCards(
                    'Para concluir tu registro como clínica afiliada a la RED MÉDICA de Fasol Soluciones, necesitamos lo siguiente: '),
                SizedBox(height: 20),
                _Pantalla(),
                _IDClinica(),
                SizedBox(
                  height: 0,
                ),
                Container(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child:
                              Text('* Identificación oficial vigente (INE)')),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '* Comprobante de domicilio particular no mayor a 03 meses contados a partir de su emisión')),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '* Último estado de cuenta bancario donde se depositarán tus honorarios')),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('* Toma de selfie y videograbación')),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '* Firma del convenio de afiliación y autorización de recibir transferencias.')),
                    ]),
                  ),
                ),

                /*Row(
                      children: [
                        Checkbox(
                          value: _checkbox,
                          onChanged: (value) {
                            setState(() {
                              _checkbox = !_checkbox;
                              print(_checkbox);
                            });
                          },
                        ),
                        Text('Actúo en nombre y cuenta propia '),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _checkbox,
                          onChanged: (value) {
                            setState(() {
                              _checkbox = !_checkbox;
                              print(_checkbox);
                            });
                          },
                        ),
                        Text('Acepto que mi imagen y mi voz sean grabadas para efectos de identificación'),
                      ],
                    ),*/
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('Actúo en nombre y cuenta propia'),
                  value: ActuoEnNombreYcuentaPropia,
                  onChanged: (value) {
                    //print(value);
                    setState(() {
                      ActuoEnNombreYcuentaPropia = !ActuoEnNombreYcuentaPropia;
                      //print(ActuoEnNombreYcuentaPropia);
                    });
                  },
                ),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                      'Acepto que mi imagen y mi voz sean grabadas.'),
                  value: AceptoGrabarVozEImagen,
                  onChanged: (value) {
                    setState(() {
                      AceptoGrabarVozEImagen = !AceptoGrabarVozEImagen;
                    });
                  },
                ),
                _Avanzar(),
                SizedBox(
                  height: 20,
                ),
                _BotonEnviar(),
                SizedBox(
                  height: 20,
                ),
                
              ]),
        ));
  }

  Widget _buildItem(String textTitle) {
    return new ListTile(
      title: new Text(textTitle),
      subtitle: new Text('Subtitulo ejemplo'),
      leading: new Icon(Icons.map),
      onTap: () {
        print(textTitle);
      },
    );
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

  

  Widget _BotonEnviar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              PantallaRecibe = Pantalla.text;
              IDClinicaRecibe = IDClinica.text;

              //print(ActuoEnNombreYcuentaPropia);
              //print(AceptoGrabarVozEImagen);

              if (PantallaRecibe == "" ||
                  IDClinicaRecibe == "" ||
                  ActuoEnNombreYcuentaPropia == false ||
                  AceptoGrabarVozEImagen == false) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                Ingresar(PantallaRecibe, IDClinicaRecibe,
                    ActuoEnNombreYcuentaPropia, AceptoGrabarVozEImagen);
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
              MaterialPageRoute(builder: (context) => FinClinicas5_1_INE()));
        },
      ),
    );
  }
}
