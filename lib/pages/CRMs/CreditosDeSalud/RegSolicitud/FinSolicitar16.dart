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

import 'FinSolicitar17.dart';
//import 'Finclinicas14.dart';

import 'package:intl/intl.dart';

class FinSolicitar16 extends StatefulWidget {
  String idCredito = "";
  FinSolicitar16(this.idCredito);

  @override
  State<FinSolicitar16> createState() => _FinSolicitar16State();
}

class _FinSolicitar16State extends State<FinSolicitar16> {
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
    return MyCustomFormFinSolicitar16(widget.idCredito);
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar16 extends StatefulWidget {
  String idCredito = "";
  MyCustomFormFinSolicitar16(this.idCredito);

  @override
  MyCustomFormFinSolicitar16State createState() {
    return MyCustomFormFinSolicitar16State();
  }
}

//enum OpcionesFirmaElectronica { Si, No }
//enum OpcionesCunetasConTarjeta { Si, No }
//enum OpcionesEsConCredito { Si, No }

class MyCustomFormFinSolicitar16State
    extends State<MyCustomFormFinSolicitar16> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  var MasccaraPeriodo = new MaskTextInputFormatter(
      mask: '0000-0000', filter: {"0": RegExp(r'[0-9]')});

  String? _opcionesCunetasConTarjeta;
  bool _siCunetasConTarjeta = false;

  void SeleccionadoCunetasConTarjeta(value) {
    setState(() {
      _opcionesCunetasConTarjeta = value;
      _siCunetasConTarjeta = value == "Si";
    });
  }

  String? _opcionesEsConCredito;
  bool _siEsConCredito = false;

  void SeleccionadoEsConCredito(value) {
    setState(() {
      _opcionesEsConCredito = value;
      _siEsConCredito = value == "Si";
    });
  }

  String? _opcionesHasEjercido;
  bool _siHasEjercido = false;

  void SeleccionadoHasEjercido(value) {
    setState(() {
      _opcionesHasEjercido = value;
      _siHasEjercido = value == "Si";
    });
  }

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDLR = TextEditingController();
  final IDInfo = TextEditingController();

  final CunetasConTarjeta = TextEditingController();
  final Ultimos4Digitos = TextEditingController();

  final EsConCredito = TextEditingController();
  final InstitucionOtorgante = TextEditingController();
  final NumCredito = TextEditingController();

  final HasEjercido = TextEditingController();
  final InstitucionOtorgante2 = TextEditingController();
  final NumCredito2 = TextEditingController();

  String PantallaRecibe = "";
  String IDLRRecibe = "";
  String IDInfoRecibe = "";

  String CunetasConTarjetaRecibe = "";
  String Ultimos4DigitosRecibe = "";
  String EsConCreditoRecibe = "";
  String InstitucionOtorganteRecibe = "";
  String NumCreditoRecibe = "";

  String HasEjercidoRecibe = "";
  String InstitucionOtorgante2Recibe = "";
  String NumCredito2Recibe = "";

  void Ingresar(
      Pantalla,
      IDLR,
      IDInfo,
      CunetasConTarjeta,
      Ultimos4Digitos,
      EsConCredito,
      InstitucionOtorgante,
      NumCredito,
      HasEjercido,
      InstitucionOtorgante2,
      NumCredito2) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');

      var bodyEnviar = {
        'Pantalla': Pantalla,
        'id_solicitud': IDLR,
        'id_credito': widget.idCredito,
        'CunetasConTarjeta': CunetasConTarjeta,
        'Ultimos4Digitos': Ultimos4Digitos,
        'EsConCredito': EsConCredito,
        'NombreConTarjeta': InstitucionOtorgante,
        'NumeroDeCredito': NumCredito,
        'HasEjercido': HasEjercido,
        'CredAutoNombreConTarjeta': InstitucionOtorgante2,
        'CredAutoNumCred': NumCredito2
      };

      var response = await http
          .post(url, body: bodyEnviar)
          .timeout(const Duration(seconds: 90));
      dev.log(response.body);

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
              builder: (_) => FinSolicitar17(widget.idCredito)));
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
      NombreCompletoSession = prefs.getString('NombreCompletoSession') ?? '';
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_credito = prefs.getInt('id_credito') ?? 0;
    });

    Pantalla.text = 'FinSolicitar16';
    IDLR.text = "$id_solicitud";
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
                SubitleCards("Vamos a revisar tu información crediticia "),
                SizedBox(
                  height: 20,
                ),
                _Pantalla(),
                _IDLR(),
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
                      "¿Cuentas con una o varias tarjetas de crédito? ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 17,
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
                              )),
                          value: "Si",
                          groupValue: _opcionesCunetasConTarjeta,
                          onChanged: SeleccionadoCunetasConTarjeta,
                        ),
                      ),
                      Expanded(
                          child: RadioListTile(
                        title: const Text('No',
                            style: TextStyle(
                              fontSize: 17,
                            )),
                        value: "No",
                        groupValue: _opcionesCunetasConTarjeta,
                        onChanged: SeleccionadoCunetasConTarjeta,
                      )),
                    ],
                  ),
                ),
                if (_siCunetasConTarjeta)
                  Container(
                      padding: EdgeInsets.only(left: 1.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          //border: Border.all(

                          //)
                          ),
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _Ultimos4Digitos(),
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

                        //)
                        ),
                    child: Text(
                      "¿Cuentas con crédito hipotecario? ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 17,
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
                              )),
                          value: "Si",
                          groupValue: _opcionesEsConCredito,
                          onChanged: SeleccionadoEsConCredito,
                        ),
                      ),
                      Expanded(
                          child: RadioListTile(
                        title: const Text('No',
                            style: TextStyle(
                              fontSize: 17,
                            )),
                        value: "No",
                        groupValue: _opcionesEsConCredito,
                        onChanged: SeleccionadoEsConCredito,
                      )),
                    ],
                  ),
                ),
                if (_siEsConCredito)
                  Container(
                      padding: EdgeInsets.only(left: 1.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          //border: Border.all(

                          //)
                          ),
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _InstitucionOtorgante(),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _NumCredito(),
                              ),
                            ],
                          )
                        ],
                      )),
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
                      "¿Has ejercido en los últimos dos años un crédito automotriz?.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 17,
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
                              )),
                          value: "Si",
                          groupValue: _opcionesHasEjercido,
                          onChanged: SeleccionadoHasEjercido,
                        ),
                      ),
                      Expanded(
                          child: RadioListTile(
                        title: const Text('No',
                            style: TextStyle(
                              fontSize: 17,
                            )),
                        value: "No",
                        groupValue: _opcionesHasEjercido,
                        onChanged: SeleccionadoHasEjercido,
                      )),
                    ],
                  ),
                ),
                if (_siHasEjercido)
                  Container(
                      padding: EdgeInsets.only(left: 1.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          //border: Border.all(

                          //)
                          ),
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _InstitucionOtorgante2(),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _NumCredito2(),
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

  Widget _Ultimos4Digitos() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: Ultimos4Digitos,
        maxLength: 4,
        decoration: InputDecoration(
            labelText: 'Últimos 4 dígitos del no. de tu tarjeta ',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _InstitucionOtorgante() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTextoYNumeros,
        keyboardType: TextInputType.text,
        controller: InstitucionOtorgante,
        decoration: InputDecoration(
            labelText: 'Institución otorgante',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _NumCredito() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: NumCredito,
        decoration: InputDecoration(
            labelText: 'No. de crédito ',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _InstitucionOtorgante2() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTextoYNumeros,
        keyboardType: TextInputType.text,
        controller: InstitucionOtorgante2,
        decoration: InputDecoration(
            labelText: 'Institución otorgante ',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _NumCredito2() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: NumCredito2,
        decoration: InputDecoration(
            labelText: 'No. de crédito ',
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

              String? CunetasConTarjetaRecibe = _opcionesCunetasConTarjeta;
              if (CunetasConTarjetaRecibe == "" ||
                  CunetasConTarjetaRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                            'La opción Ultimos4Digitos político es obligatoria'),
                      );
                    });
              }
              Ultimos4DigitosRecibe = Ultimos4Digitos.text;
              String? EsConCreditoRecibe = _opcionesEsConCredito;
              if (EsConCreditoRecibe == "" || EsConCreditoRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                            'Definir si tu conyugue ha ejercido en política es obligatoria'),
                      );
                    });
              }
              InstitucionOtorganteRecibe = InstitucionOtorgante.text;
              NumCreditoRecibe = NumCredito.text;
              String? HasEjercidoRecibe = _opcionesHasEjercido;

              if (HasEjercidoRecibe == "" || HasEjercidoRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                            'La opción Ultimos4Digitos político es obligatoria'),
                      );
                    });
              }
              InstitucionOtorgante2Recibe = InstitucionOtorgante2.text;
              NumCredito2Recibe = NumCredito2.text;

              print(PantallaRecibe);
              print(IDLRRecibe);
              print(IDInfoRecibe);
              print(CunetasConTarjetaRecibe);
              print(EsConCreditoRecibe);
              print(HasEjercidoRecibe);

              if (PantallaRecibe == "" ||
                  IDLRRecibe == "" ||
                  IDInfoRecibe == "" ||
                  CunetasConTarjetaRecibe == "" ||
                  EsConCreditoRecibe == "" ||
                  HasEjercidoRecibe == "") {
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
                    CunetasConTarjetaRecibe,
                    Ultimos4DigitosRecibe,
                    EsConCreditoRecibe,
                    InstitucionOtorganteRecibe,
                    NumCreditoRecibe,
                    HasEjercidoRecibe,
                    InstitucionOtorgante2Recibe,
                    NumCredito2Recibe);
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
                  builder: (context) => FinSolicitar17(widget.idCredito)));
        },
      ),
    );
  }
}
