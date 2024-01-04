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

import 'FinSolicitar15.dart';
import 'FinSolicitar15_negativa.dart';
//import 'FinRegMedico32.dart';
//import 'FinRegMedico33.dart';

import 'package:intl/intl.dart';

class FinSolicitar14 extends StatefulWidget {
  const FinSolicitar14({super.key});

  @override
  State<FinSolicitar14> createState() => _FinSolicitar14State();
}

class _FinSolicitar14State extends State<FinSolicitar14> {
  //se usa para mostrar los datos del estado
  int id_solicitud = 0;
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
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_info = prefs.getInt('id_info') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomFormFinSolicitar14();
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar14 extends StatefulWidget {
  const MyCustomFormFinSolicitar14({super.key});

  @override
  MyCustomFormFinSolicitar14State createState() {
    return MyCustomFormFinSolicitar14State();
  }
}

//enum OpcionesFirmaElectronica { Si, No }
//enum OpcionesCargoPolitico { Si, No }
//enum OpcionesEsConyugue { Si, No }

class MyCustomFormFinSolicitar14State
    extends State<MyCustomFormFinSolicitar14> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  var MasccaraPeriodo = new MaskTextInputFormatter(
      mask: '0000-0000', filter: {"0": RegExp(r'[0-9]')});

  String? _opcionesCargoPolitico;
  bool _siCargoPolitico = false;

  void SeleccionadoCargoPolitico(value) {
    setState(() {
      _opcionesCargoPolitico = value;
      _siCargoPolitico = value == "Si";
    });
  }

  String? _opcionesEsConyugue;
  bool _siEsConyugue = false;

  void SeleccionadoEsConyugue(value) {
    setState(() {
      _opcionesEsConyugue = value;
      _siEsConyugue = value == "Si";
    });
  }

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDLR = TextEditingController();
  final IDInfo = TextEditingController();

  final CargoPolitico = TextEditingController();
  final Cargo = TextEditingController();
  final PeriodoDelCargo = TextEditingController();
  final EsConyugue = TextEditingController();
  final PrimerNombre = TextEditingController();
  final SegundoNombre = TextEditingController();
  final ApellidoPaterno = TextEditingController();
  final ApellidoMaterno = TextEditingController();

  String PantallaRecibe = "";
  String IDLRRecibe = "";
  String IDInfoRecibe = "";

  String CargoPoliticoRecibe = "";
  String CargoRecibe = "";
  String PeriodoDelCargoRecibe = "";
  String EsConyugueRecibe = "";
  String PrimerNombreRecibe = "";
  String SegundoNombreRecibe = "";
  String ApellidoPaternoRecibe = "";
  String ApellidoMaternoRecibe = "";

  void Ingresar(
      Pantalla,
      IDLR,
      IDInfo,
      CargoPolitico,
      Cargo,
      PeriodoDelCargo,
      EsConyugue,
      PrimerNombre,
      SegundoNombre,
      ApellidoPaterno,
      ApellidoMaterno) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');

      var bodyEnviar = {
        'Pantalla': Pantalla,
        'id_solicitud': IDLR,
        'id_info': IDInfo,
        'CargoPolitico': CargoPolitico,
        'Cargo': Cargo,
        'PeriodoDelCargo': PeriodoDelCargo,
        'EsConyugue': EsConyugue,
        'PrimerNombre': PrimerNombre,
        'SegundoNombre': SegundoNombre,
        'ApellidoPaterno': ApellidoPaterno,
        'ApellidoMaterno': ApellidoMaterno
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
        if (status == "OK") {
          //print('si existe aqui -----');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Registrado correctamente'),
                );
              });
          if (CargoPolitico == "Si" || EsConyugue == "Si") {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => FinSolicitar15_negativa()));
            FocusScope.of(context).unfocus();
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => FinSolicitar15()));
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
          prefs.getString('NombreCompletoSession') ?? '';
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_info = prefs.getInt('id_info') ?? 0;
    });

    Pantalla.text = 'FinSolicitar14';
    IDLR.text = "$id_solicitud";
    IDInfo.text = "$id_info";
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
                    SubitleCards("Información del proveedor de recursos "),
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
                          "¿La persona que aportará recursos desempeña o ha desempeñado en los últimos 12 meses un cargo público o político en territorio nacional o en un país extranjero? ",
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
                              groupValue: _opcionesCargoPolitico,
                              onChanged: SeleccionadoCargoPolitico,
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
                            groupValue: _opcionesCargoPolitico,
                            onChanged: SeleccionadoCargoPolitico,
                          )),
                        ],
                      ),
                    ),
                    if (_siCargoPolitico)
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
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: _Cargo(),
                                  ),
                                  Expanded(
                                    child: _PeriodoDelCargo(),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            //border: Border.all(
                            //color: Colors.blueAccent
                            //)
                            ),
                        child: Text(
                          "¿La persona que aportará recursos es Cónyuge, Concubino (a), Hijo (a), Hermano (a), Abuelo, Padre, Primo (a) o Nieto (a) de alguna persona que desempeñe o han desempeñado cargo público o político? ",
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
                              groupValue: _opcionesEsConyugue,
                              onChanged: SeleccionadoEsConyugue,
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
                            groupValue: _opcionesEsConyugue,
                            onChanged: SeleccionadoEsConyugue,
                          )),
                        ],
                      ),
                    ),
                    if (_siEsConyugue)
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
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: _PrimerNombre(),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: _SegundoNombre(),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: _ApellidoPaterno(),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: _ApellidoMaterno(),
                                  ),
                                ],
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
                    _Avanzar(),
                    _AvanzarNegativa()
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

  Widget _Cargo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Cargo,
        decoration: InputDecoration(
            labelText: 'Cargo',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _PeriodoDelCargo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        inputFormatters: [MasccaraPeriodo],
        validator: ObligatorioPeriodo,
        keyboardType: TextInputType.text,
        controller: PeriodoDelCargo,
        decoration: InputDecoration(
            labelText: 'Periodo del cargo',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: '0000-0000'),
      ),
    );
  }

  Widget _PrimerNombre() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: PrimerNombre,
        decoration: InputDecoration(
            labelText: 'Primer nombre',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _SegundoNombre() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: SoloTexto,
        keyboardType: TextInputType.text,
        controller: SegundoNombre,
        decoration: InputDecoration(
            labelText: 'Segundo nombre',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _ApellidoPaterno() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: ApellidoPaterno,
        decoration: InputDecoration(
            labelText: 'Apellido paterno',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _ApellidoMaterno() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: ApellidoMaterno,
        decoration: InputDecoration(
            labelText: 'Apellido materno',
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

              String? CargoPoliticoRecibe = _opcionesCargoPolitico;
              if (CargoPoliticoRecibe == "" || CargoPoliticoRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La opción cargo político es obligatoria'),
                      );
                    });
              }
              CargoRecibe = Cargo.text;
              PeriodoDelCargoRecibe = PeriodoDelCargo.text;
              String? EsConyugueRecibe = _opcionesEsConyugue;
              if (EsConyugueRecibe == "" || EsConyugueRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                            'Definir si tu conyugue ha ejercido en política es obligatoria'),
                      );
                    });
              }
              PrimerNombreRecibe = PrimerNombre.text;
              SegundoNombreRecibe = SegundoNombre.text;
              ApellidoPaternoRecibe = ApellidoPaterno.text;
              ApellidoMaternoRecibe = ApellidoMaterno.text;

              if (PantallaRecibe == "" ||
                  IDLRRecibe == "" ||
                  IDInfoRecibe == "" ||
                  CargoPoliticoRecibe == "" ||
                  EsConyugueRecibe == "") {
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
                    CargoPoliticoRecibe,
                    CargoRecibe,
                    PeriodoDelCargoRecibe,
                    EsConyugueRecibe,
                    PrimerNombreRecibe,
                    SegundoNombreRecibe,
                    ApellidoPaternoRecibe,
                    ApellidoMaternoRecibe);
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
              MaterialPageRoute(builder: (context) => FinSolicitar15()));
        },
      ),
    );
  }
  Widget _AvanzarNegativa() {
    return Container(
      width: double.infinity,
      //padding: EdgeInsets.all(10),
      child: ListTile(
        title: new Center(
            child: new Text(
          "Avanzar negativa",
          style: new TextStyle(fontSize: 12.0),
        )),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FinSolicitar15_negativa()));
        },
      ),
    );
  }
}
