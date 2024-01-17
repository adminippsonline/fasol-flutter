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

import 'FinSolicitar18.dart';
//import 'Finclinicas14.dart';

import 'package:intl/intl.dart';

class FinSolicitar17_2 extends StatefulWidget {
  String idCredito = "";
  FinSolicitar17_2(this.idCredito);

  @override
  State<FinSolicitar17_2> createState() => _FinSolicitar17_2State();
}

class _FinSolicitar17_2State extends State<FinSolicitar17_2> {
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
    return MyCustomFormFinSolicitar17_2(widget.idCredito);
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar17_2 extends StatefulWidget {
  String idCredito = "";
  MyCustomFormFinSolicitar17_2(this.idCredito);

  @override
  MyCustomFormFinSolicitar17_2State createState() {
    return MyCustomFormFinSolicitar17_2State();
  }
}

//enum OpcionesFirmaElectronica { Si, No }
//enum OpcionesEsPropietario { Si, No }
//enum OpcionesEscribeEsConyugue { Si, No }

class MyCustomFormFinSolicitar17_2State
    extends State<MyCustomFormFinSolicitar17_2> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  String? _opcionesAutorizacionConsulta;
  bool _siAutorizacionConsulta = false;

  void SeleccionadoAutorizacionConsulta(value) {
    setState(() {
      _opcionesAutorizacionConsulta = value;
      _siAutorizacionConsulta = value == "Si autorizo";
    });
  }

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDSolicitud = TextEditingController();
  final IDInfo = TextEditingController();

  final AutorizacionConsulta = TextEditingController();
  final Uno = TextEditingController();
  final Dos = TextEditingController();
  final Tres = TextEditingController();
  final Cuatro = TextEditingController();

  String PantallaRecibe = "";
  String IDSolicitudRecibe = "";
  String IDInfoRecibe = "";

  String AutorizacionConsultaRecibe = "";
  String UnoRecibe = "";
  String DosRecibe = "";
  String TresRecibe = "";
  String CuatroRecibe = "";

  void Ingresar(Pantalla, IDSolicitud, IDInfo, AutorizacionConsulta, Uno, Dos,
      Tres, Cuatro) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');

      var bodyEnviar = {
        'Pantalla': Pantalla,
        'id_solicitud': IDSolicitud,
        'id_credito': IDInfo,
        'AutorizacionConsulta': AutorizacionConsulta,
        'Uno': Uno,
        'Dos': Dos,
        'Tres': Tres,
        'Cuatro': Cuatro
      };
      print(bodyEnviar);
      var response = await http
          .post(url, body: bodyEnviar)
          .timeout(const Duration(seconds: 90));
      print("llego aqui 111");
      print(response.body);

      if (response.body != "0" && response.body != "") {
        var Respuesta = jsonDecode(response.body);
        print(Respuesta);
        String status = Respuesta['status'];
        String msg = Respuesta['msg'];
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
              builder: (_) => FinSolicitar18(widget.idCredito)));
          FocusScope.of(context).unfocus();
        } else {
          //print('Error en el registro');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(msg),
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
      NombreCompletoSession = prefs.getString('NombreCompletoSession') ?? '';
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_credito = prefs.getInt('id_credito') ?? 0;
    });

    Pantalla.text = 'FinSolicitar17_2';
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
                SubitleCards("Autorización de consulta "),
                SizedBox(
                  height: 20,
                ),
                _Pantalla(),
                _IDSolicitud(),
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
                      "Autorizo expresamente a Fasol Soluciones S.A. de C.V., SOFOM E.N.R, para que lleve a cabo Investigaciones, sobre mi comportamiento Crediticio en SIC que estime conveniente.",
                      textAlign: TextAlign.justify,
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
                      "Conozco la naturaleza y alcance de la información que se solicitará, del uso que se le dará y que se podrá realizar consultas periódicas de mi historial crediticio, consiento que esta autorización tenga vigencia de 3 años contados a partir de hoy, y en su caso mientras mantengamos relación jurídica. ",
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
                          title: const Text('Si autorizo',
                              style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 126, 126, 126),
                              )),
                          value: "Si autorizo",
                          groupValue: _opcionesAutorizacionConsulta,
                          onChanged: SeleccionadoAutorizacionConsulta,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_siAutorizacionConsulta)
                  Container(
                      padding: EdgeInsets.only(left: 1.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          //border: Border.all(
                          //color: Colors.blueAccent
                          //)
                          ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
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
                                "Ingresa una vez más tu código para confirmar que aceptas",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                                textScaleFactor: 1,
                              )),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _Uno(),
                              ),
                              Expanded(
                                child: _Dos(),
                              ),
                              Expanded(
                                child: _Tres(),
                              ),
                              Expanded(
                                child: _Cuatro(),
                              ),
                            ],
                          ),
                        ],
                      )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                          child: RadioListTile(
                        title: const Text('No',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 126, 126, 126),
                            )),
                        value: "No",
                        groupValue: _opcionesAutorizacionConsulta,
                        onChanged: SeleccionadoAutorizacionConsulta,
                      )),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                _BotonEnviar(),
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

  Widget _Uno() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: Uno,
        maxLength: 1,
        decoration: InputDecoration(
            labelText: '',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: '',
            counterText: ''),
      ),
    );
  }

  Widget _Dos() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: Dos,
        maxLength: 1,
        decoration: InputDecoration(
            labelText: '',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: '',
            counterText: ''),
      ),
    );
  }

  Widget _Tres() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: Tres,
        maxLength: 1,
        decoration: InputDecoration(
            labelText: '',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: '',
            counterText: ''),
      ),
    );
  }

  Widget _Cuatro() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: Cuatro,
        maxLength: 1,
        decoration: InputDecoration(
            labelText: '',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: '',
            counterText: ''),
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
              IDSolicitudRecibe = IDSolicitud.text;
              IDInfoRecibe = IDInfo.text;

              String? AutorizacionConsultaRecibe =
                  _opcionesAutorizacionConsulta;
              if (AutorizacionConsultaRecibe == "" ||
                  AutorizacionConsultaRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La opción cargo político es obligatoria'),
                      );
                    });
              }

              UnoRecibe = Uno.text;
              DosRecibe = Dos.text;
              TresRecibe = Tres.text;
              CuatroRecibe = Cuatro.text;

              if (PantallaRecibe == "" ||
                  IDSolicitudRecibe == "" ||
                  IDInfoRecibe == "" ||
                  AutorizacionConsultaRecibe == "" ||
                  UnoRecibe == "" ||
                  DosRecibe == "" ||
                  TresRecibe == "" ||
                  CuatroRecibe == "") {
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
                    IDSolicitudRecibe,
                    IDInfoRecibe,
                    AutorizacionConsultaRecibe,
                    UnoRecibe,
                    DosRecibe,
                    TresRecibe,
                    CuatroRecibe);
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
