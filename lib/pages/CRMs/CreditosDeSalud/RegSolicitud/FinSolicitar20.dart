import 'package:flutter/material.dart';
import 'dart:developer' as dev;
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

//import 'FinRegMedico35.dart';
import 'FinSolicitar21_INE.dart';

import 'package:intl/intl.dart';

class FinSolicitar20 extends StatefulWidget {
  String idCredito = "";
  FinSolicitar20(this.idCredito);

  @override
  State<FinSolicitar20> createState() => _FinSolicitar20State();
}

class _FinSolicitar20State extends State<FinSolicitar20> {
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
    return MyCustomFormFinSolicitar20(widget.idCredito);
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(NombreCompletoSession),
    //   ),
    //   drawer: MenuLateralPage(""),
    //   bottomNavigationBar: MenuFooterPage(),
    //   body: const MyCustomFormFinSolicitar20(),
    // );
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar20 extends StatefulWidget {
  String idCredito = "";
  MyCustomFormFinSolicitar20(this.idCredito);

  @override
  MyCustomFormFinSolicitar20State createState() {
    return MyCustomFormFinSolicitar20State();
  }
}

class MyCustomFormFinSolicitar20State
    extends State<MyCustomFormFinSolicitar20> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDLR = TextEditingController();
  final IDInfo = TextEditingController();

  String PantallaRecibe = "";
  String IDLRRecibe = "";
  String IDInfoRecibe = "";

  void Ingresar(Pantalla, IDLR, IDInfo, ActuoEnNombreYcuentaPropia,
      AceptoGrabarVozEImagen) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');
      var response = await http.post(url, body: {
        'Pantalla': Pantalla,
        'id_solicitud': IDLR,
        'id_credito': widget.idCredito,
        'actuo_en_nombre_propio': "1",
        'acepto_grabacion': "1"
      }).timeout(const Duration(seconds: 90));

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
              builder: (_) => FinSolicitar21_INE(widget.idCredito)));
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
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_credito = prefs.getInt('id_credito') ?? 0;
    });

    Pantalla.text = 'FinSolicitar20';
    IDLR.text = "$id_solicitud";
    IDInfo.text = "$id_credito";
  }

  //final IDLR = TextEditingController();
  //final IDInfo = TextEditingController();

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
    return BuildScreens('${NombreCompletoSession}', '', '',
        'Información Personal', '', _formulario());
  }

  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // headerTop("¡¡¡Recuerda!!!!",
                //     'Para concluir tu registro como médico afiliado a la RED MÉDICA de Fasol Soluciones, necesitamos lo siguiente: '),

                SubitleCards("¡¡¡Recuerda!!!!"),
                SizedBox(height: 20),

                SubitleCards(
                    "Necesitarás para concluir tu crédito lo siguiente: "),
                SizedBox(height: 20),
                _Pantalla(),
                _IDLR(),
                _IDInfo(),
                SizedBox(
                  height: 0,
                ),
                Container(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(children: const <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child:
                              Text('* Identificación oficial vigente (INE)')),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '* Comprobante de domicilio particular no mayor a 03 meses contados a partir de su emisión')),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '* Último estado de cuenta bancario donde se depositarán tus honorarios')),
                      SizedBox(height: 10),
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
                  title: Text('Acepto que mi imagen y mi voz sean grabadas'),
                  value: AceptoGrabarVozEImagen,
                  onChanged: (value) {
                    setState(() {
                      AceptoGrabarVozEImagen = !AceptoGrabarVozEImagen;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                _Avanzar(),
                _BotonEnviar(),
                SizedBox(
                  height: 80,
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

              //print(ActuoEnNombreYcuentaPropia);
              //print(AceptoGrabarVozEImagen);

              if (PantallaRecibe == "" ||
                  IDLRRecibe == "" ||
                  IDInfoRecibe == "" ||
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
                Ingresar(PantallaRecibe, IDLRRecibe, IDInfoRecibe,
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FinSolicitar21_INE(widget.idCredito)));
        },
      ),
    );
  }
}
