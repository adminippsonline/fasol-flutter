import '../../../../../Elementos/validaciones_formularios.dart';
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

import 'FinSolicitar13_1.dart';

import 'package:intl/intl.dart';

class FinSolicitar13_0 extends StatefulWidget {
  const FinSolicitar13_0({super.key});

  @override
  State<FinSolicitar13_0> createState() => _FinSolicitar13_0State();
}

class _FinSolicitar13_0State extends State<FinSolicitar13_0> {
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
    return MyCustomFormFinSolicitar13_0();
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar13_0 extends StatefulWidget {
  const MyCustomFormFinSolicitar13_0({super.key});

  @override
  MyCustomFormFinSolicitar13_0State createState() {
    return MyCustomFormFinSolicitar13_0State();
  }
}

class MyCustomFormFinSolicitar13_0State
    extends State<MyCustomFormFinSolicitar13_0> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  final List<String> ListaInstitucionBancaria = [
    'Banco 1',
    'Banco 2',
    'Banco 3'
  ];
  String? SelectedListaInstitucionBancaria;

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDLR = TextEditingController();
  final IDInfo = TextEditingController();

  final InstitucionBancaria = TextEditingController();
  final NumeroDeCuenta = TextEditingController();
  final ClaveInterbancaria = TextEditingController();

  String PantallaRecibe = "";
  String IDLRRecibe = "";
  String IDInfoRecibe = "";

  String InstitucionBancariaRecibe = "";
  String NumeroDeCuentaRecibe = "";
  String ClaveInterbancariaRecibe = "";

  void Ingresar(Pantalla, IDLR, IDInfo, InstitucionBancaria, NumeroDeCuenta,
      ClaveInterbancaria) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');
      var response = await http.post(url, body: {
        'Pantalla': Pantalla,
        'id_solicitud': IDLR,
        'id_credito': IDInfo,
        'InstitucionBancaria': InstitucionBancaria,
        'NumeroDeCuenta': NumeroDeCuenta,
        'ClaveInterbancaria': ClaveInterbancaria
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
              MaterialPageRoute(builder: (_) => FinSolicitar13_1()));
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
  List _opcionesBancarios = [];

  @override
  void initState() {
    super.initState();
    mostrar_datos();
    obtenerInstitucionesBancarios();
  }

  void mostrar_datos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      NombreCompletoSession =
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_credito = prefs.getInt('id_credito') ?? 0;
    });

    Pantalla.text = 'FinSolicitar13_0';
    IDLR.text = "$id_solicitud";
    IDInfo.text = "$id_credito";
  }

  Future obtenerInstitucionesBancarios() async {
    final response = await http
        .get(Uri.parse('https://fasoluciones.mx/api/Solicitud/Catalogos/Bancos'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      dev.log(jsonData.toString());
      setState(() {
        _opcionesBancarios = jsonData;
      });
    } else {
      throw Exception('Error al obtener las instituciones bancarias');
    }
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
                //headerTop("Médicos", 'Datos bancarios'),
                SubitleCards("Datos bancarios"),
                // _Pantalla(),
                const SizedBox(
                  height: 20,
                ),
                _IDLR(),
                _IDInfo(),
                /*Container(
                        padding: EdgeInsets.only(left: 10.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            //border: Border.all(
                            //color: Colors.blueAccent
                            //)
                            ),
                        child: Text(
                          "Por favor proporciona los datos bancarios de alguna cuenta en donde tú seas el titular",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 126, 126, 126),
                          ),
                          textScaleFactor: 1,
                        )),*/
                Container(
                  padding: EdgeInsets.all(15),
                  child: const Text(
                    "Proporciona los datos bancarios en donde quieres que depositemos los recursos con los cuales se cubrirán los horarios y gastos médicos. Es importante que la cuenta bancaria se encuentre a tu nombre",
                    //textAlign:  TextAlign.center,
                    style: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 56, 56, 56)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _InstitucionBancaria(),
                _NumeroDeCuenta(),
                _ClaveInterbancaria(),
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

  /*Widget _InstitucionBancaria() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioInput,
        keyboardType: TextInputType.text,
        controller: InstitucionBancaria,
        decoration: InputDecoration(
            labelText: 'Institución bancaria',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }*/

  Widget _InstitucionBancaria() {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: DecoratedBox(
          decoration: BoxDecoration(),
          child: DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            isExpanded: true,
            hint: const Text(
              'Institución bancaria',
              style: TextStyle(fontSize: 14),
            ),
            items: _opcionesBancarios.map((item) {
              return DropdownMenuItem(
                  value: item['NombreBanco'].toString(),
                  child: Text(item['NombreBanco'].toString()));
            }).toList(),
            validator: ObligatorioSelect,
            onChanged: (value) {
              //Do something when changing the item if you want.
              SelectedListaInstitucionBancaria = value;
            },
            onSaved: (value) {
              SelectedListaInstitucionBancaria = value.toString();
            },
            buttonStyleData: const ButtonStyleData(
              height: 55,
              padding: EdgeInsets.only(left: 0, right: 10),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          )),
    );
  }

  Widget _NumeroDeCuenta() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: NumeroDeCuenta,
        maxLength: 20,
        decoration: InputDecoration(
            labelText: 'Número de cuenta',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: '',
            counterText: ''),
      ),
    );
  }

  Widget _ClaveInterbancaria() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioClaveInterbancaria,
        keyboardType: TextInputType.number,
        controller: ClaveInterbancaria,
        maxLength: 18,
        decoration: InputDecoration(
            labelText: 'Clabe interbancaria',
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
              IDLRRecibe = IDLR.text;
              IDInfoRecibe = IDInfo.text;

              //InstitucionBancariaRecibe = InstitucionBancaria.text;
              String? InstitucionBancariaRecibe =
                  SelectedListaInstitucionBancaria;
              if (InstitucionBancariaRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La Institución bancaria es obligatoria'),
                      );
                    });
              }

              NumeroDeCuentaRecibe = NumeroDeCuenta.text;
              ClaveInterbancariaRecibe = ClaveInterbancaria.text;

              if (PantallaRecibe == "" ||
                  IDLRRecibe == "" ||
                  IDInfoRecibe == "" ||
                  InstitucionBancariaRecibe == "" ||
                  NumeroDeCuentaRecibe == "" ||
                  ClaveInterbancariaRecibe == "") {
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
                  IDLRRecibe,
                  IDInfoRecibe,
                  InstitucionBancariaRecibe,
                  NumeroDeCuentaRecibe,
                  ClaveInterbancariaRecibe,
                );
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
              MaterialPageRoute(builder: (context) => FinSolicitar13_1()));
        },
      ),
    );
  }
}
