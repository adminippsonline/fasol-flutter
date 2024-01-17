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

import 'FinClinicas12.dart';
import 'FinClinicas14.dart';

import 'package:intl/intl.dart';

class FinClinicas10 extends StatefulWidget {
  const FinClinicas10({super.key});

  @override
  State<FinClinicas10> createState() => _FinClinicas10State();
}

class _FinClinicas10State extends State<FinClinicas10> {
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
    return MyCustomFormFinClinicas10();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(NombreCompletoSession),
    //   ),
    //   drawer: MenuLateralPage(""),
    //   bottomNavigationBar: MenuFooterPage(),
    // );
  }
}

// Create a Form widget.
class MyCustomFormFinClinicas10 extends StatefulWidget {
  const MyCustomFormFinClinicas10({super.key});

  @override
  MyCustomFormFinClinicas10State createState() {
    return MyCustomFormFinClinicas10State();
  }
}

//enum OpcionesFirmaElectronica { Si, No }
//enum OpcionesEsPropietario { Si, No }
//enum OpcionesEscribeEsConyugue { Si, No }

class MyCustomFormFinClinicas10State extends State<MyCustomFormFinClinicas10> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  var MasccaraPeriodo = new MaskTextInputFormatter(
      mask: '0000-0000', filter: {"0": RegExp(r'[0-9]')});

  String? _opcionesEsPropietario;
  bool _siEsPropietario = false;

  void SeleccionadoEsPropietario(value) {
    setState(() {
      _opcionesEsPropietario = value;
      _siEsPropietario = value == "Si";
    });
  }

  String? _opcionesEscribeEsConyugue;
  bool _siEscribeEsConyugue = false;

  void SeleccionadoEscribeEsConyugue(value) {
    setState(() {
      _opcionesEscribeEsConyugue = value;
      _siEscribeEsConyugue = value == "Si";
    });
  }

  String? _opcionesEsPropietario2;
  bool _siEsPropietario2 = false;

  void SeleccionadoEsPropietario2(value) {
    setState(() {
      _opcionesEsPropietario2 = value;
      _siEsPropietario2 = value == "Si";
    });
  }

  String? _opcionesEscribeEsConyugue2;
  bool _siEscribeEsConyugue2 = false;

  void SeleccionadoEscribeEsConyugue2(value) {
    setState(() {
      _opcionesEscribeEsConyugue2 = value;
      _siEscribeEsConyugue2 = value == "Si";
    });
  }

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDClinica = TextEditingController();

  final EsPropietario = TextEditingController();
  final Cargo = TextEditingController();
  final Periodo = TextEditingController();
  final EscribeEsConyugue = TextEditingController();
  final PrimerNombre = TextEditingController();
  final SegundoNombre = TextEditingController();
  final ApellidoPaterno = TextEditingController();
  final ApellidoMaterno = TextEditingController();

  final EsPropietario2 = TextEditingController();
  final Cargo2 = TextEditingController();
  final Periodo2 = TextEditingController();
  final EscribeEsConyugue2 = TextEditingController();
  final PrimerNombre2 = TextEditingController();
  final SegundoNombre2 = TextEditingController();
  final ApellidoPaterno2 = TextEditingController();
  final ApellidoMaterno2 = TextEditingController();

  String PantallaRecibe = "";
  String IDClinicaRecibe = "";

  String EsPropietarioRecibe = "";
  String CargoRecibe = "";
  String PeriodoRecibe = "";
  String EscribeEsConyugueRecibe = "";
  String PrimerNombreRecibe = "";
  String SegundoNombreRecibe = "";
  String ApellidoPaternoRecibe = "";
  String ApellidoMaternoRecibe = "";

  String EsPropietario2Recibe = "";
  String Cargo2Recibe = "";
  String Periodo2Recibe = "";
  String EscribeEsConyugue2Recibe = "";
  String PrimerNombre2Recibe = "";
  String SegundoNombre2Recibe = "";
  String ApellidoPaterno2Recibe = "";
  String ApellidoMaterno2Recibe = "";

  void Ingresar(
      Pantalla,
      IDClinica,
      EsPropietario,
      Cargo,
      Periodo,
      EscribeEsConyugue,
      PrimerNombre,
      SegundoNombre,
      ApellidoPaterno,
      ApellidoMaterno,
      EsPropietario2,
      Cargo2,
      Periodo2,
      EscribeEsConyugue2,
      PrimerNombre2,
      SegundoNombre2,
      ApellidoPaterno2,
      ApellidoMaterno2) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Clinica/Agregar');

      var bodyEnviar = {
        'Pantalla': Pantalla,
        'id_clinica': IDClinica,
        'CargoPolitico': EsPropietario,
        'CargoDesempeñado': Cargo,
        'PeriodoDesempeñado': Periodo,
        'EsConyuge': EscribeEsConyugue,
        'PrimerNombre': PrimerNombre,
        'SegundoNombre': SegundoNombre,
        'ApellidoPaterno': ApellidoPaterno,
        'ApellidoMaterno': ApellidoMaterno,
        'CargoPolitico2': EsPropietario2,
        'CargoDesempeñado2': Cargo2,
        'PeriodoDesempeñado2': Periodo2,
        'EsConyuge2': EscribeEsConyugue2,
        'PrimerNombre2': PrimerNombre2,
        'SegundoNombre2': SegundoNombre2,
        'ApellidoPaterno2': ApellidoPaterno2,
        'ApellidoMaterno2': ApellidoMaterno2
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
          if (EsPropietario == "Si" ||
              EscribeEsConyugue == "Si" ||
              EsPropietario2 == "Si" ||
              EscribeEsConyugue2 == "Si") {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => FinClinicas12()));
            FocusScope.of(context).unfocus();
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => FinClinicas14()));
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

    Pantalla.text = 'FinClinicas10';
    IDClinica.text = "$id_clinica";
  }

  @override
  Widget build(BuildContext context) {
    return BuildScreens('Clínica', '', '', 'Datos de la clínica',
        'Información adicional', _formulario());
  }

  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // headerTop("Clínica", 'Información adicional'),
                SubitleCards("Representante legal"),
                SizedBox(
                  height: 20,
                ),
                _Pantalla(),
                _IDClinica(),
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
                      "¿Usted desempeña o ha desempeñado en los últimos 12 meses un cargo público o político en territorio nacional o en un país extranjero?",
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
                          groupValue: _opcionesEsPropietario,
                          onChanged: SeleccionadoEsPropietario,
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
                        groupValue: _opcionesEsPropietario,
                        onChanged: SeleccionadoEsPropietario,
                      )),
                    ],
                  ),
                ),
                if (_siEsPropietario)
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
                                child: _Periodo(),
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
                      "¿Es Usted Cónyuge, Concubino (a), Hijo (a), Hermano (a), Abuelo, Padre, Primo (a) o Nieto (a) de alguna persona que desempeñe o han desempeñado cargo público o político?",
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
                          groupValue: _opcionesEscribeEsConyugue,
                          onChanged: SeleccionadoEscribeEsConyugue,
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
                        groupValue: _opcionesEscribeEsConyugue,
                        onChanged: SeleccionadoEscribeEsConyugue,
                      )),
                    ],
                  ),
                ),
                if (_siEscribeEsConyugue)
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
                Container(
                  padding: EdgeInsets.all(15),
                  child: const Text(
                    "Accionista ",
                    //textAlign:  TextAlign.center,
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 56, 56, 56)),
                  ),
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
                      "¿Usted desempeña o ha desempeñado en los últimos 12 meses un cargo público o político en territorio nacional o en un país extranjero?",
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
                          groupValue: _opcionesEsPropietario2,
                          onChanged: SeleccionadoEsPropietario2,
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
                        groupValue: _opcionesEsPropietario2,
                        onChanged: SeleccionadoEsPropietario2,
                      )),
                    ],
                  ),
                ),
                if (_siEsPropietario2)
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
                                child: _Cargo2(),
                              ),
                              Expanded(
                                child: _Periodo2(),
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
                      "¿Es Usted Cónyuge, Concubino (a), Hijo (a), Hermano (a), Abuelo, Padre, Primo (a) o Nieto (a) de alguna persona que desempeñe o han desempeñado cargo público o político?",
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
                          groupValue: _opcionesEscribeEsConyugue2,
                          onChanged: SeleccionadoEscribeEsConyugue2,
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
                        groupValue: _opcionesEscribeEsConyugue2,
                        onChanged: SeleccionadoEscribeEsConyugue2,
                      )),
                    ],
                  ),
                ),
                if (_siEscribeEsConyugue2)
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
                                child: _PrimerNombre2(),
                              ),
                              Expanded(
                                child: _SegundoNombre2(),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _ApellidoPaterno2(),
                              ),
                              Expanded(
                                child: _ApellidoMaterno2(),
                              ),
                            ],
                          ),
                        ],
                      )),
                Container(
                  padding: EdgeInsets.all(15),
                  child: const Text(
                    "PEP: Aquel individuo que desempeña o ha desempeñado funciones públicas destacadas en un país extranjero o en territorio nacional, considerando entre otros, a los jefes de estado o de gobierno, líderes políticos, funcionarios gubernamentales, judiciales o militares de alta jerarquía, altos ejecutivos de empresas estatales o funcionarios o miembros importantes de partidos políticos y organizaciones internacionales ",
                    //textAlign:  TextAlign.center,
                    style: TextStyle(
                        fontSize: 12, color: Color.fromARGB(255, 56, 56, 56)),
                  ),
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

  Widget _Periodo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        inputFormatters: [MasccaraPeriodo],
        validator: ObligatorioPeriodo,
        keyboardType: TextInputType.text,
        controller: Periodo,
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

  Widget _Cargo2() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Cargo2,
        decoration: InputDecoration(
            labelText: 'Cargo',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Periodo2() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        inputFormatters: [MasccaraPeriodo],
        validator: ObligatorioPeriodo,
        keyboardType: TextInputType.text,
        controller: Periodo2,
        decoration: InputDecoration(
            labelText: 'Periodo del cargo',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: '0000-0000'),
      ),
    );
  }

  Widget _PrimerNombre2() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: PrimerNombre2,
        decoration: InputDecoration(
            labelText: 'Primer nombre',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _SegundoNombre2() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: SoloTexto,
        keyboardType: TextInputType.text,
        controller: SegundoNombre2,
        decoration: InputDecoration(
            labelText: 'Segundo nombre',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _ApellidoPaterno2() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: ApellidoPaterno2,
        decoration: InputDecoration(
            labelText: 'Apellido paterno',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _ApellidoMaterno2() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: ApellidoMaterno2,
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
              IDClinicaRecibe = IDClinica.text;

              String? EsPropietarioRecibe = _opcionesEsPropietario;
              if (EsPropietarioRecibe == "" || EsPropietarioRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La opción cargo político es obligatoria'),
                      );
                    });
              }
              CargoRecibe = Cargo.text;
              PeriodoRecibe = Periodo.text;
              String? EscribeEsConyugueRecibe = _opcionesEscribeEsConyugue;
              if (EscribeEsConyugueRecibe == "" ||
                  EscribeEsConyugueRecibe == null) {
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

              String? EsPropietario2Recibe = _opcionesEsPropietario2;

              if (EsPropietario2Recibe == "" || EsPropietario2Recibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La opción cargo político es obligatoria'),
                      );
                    });
              }
              Cargo2Recibe = Cargo2.text;
              Periodo2Recibe = Periodo2.text;
              String? EscribeEsConyugue2Recibe = _opcionesEscribeEsConyugue2;

              if (EscribeEsConyugue2Recibe == "" ||
                  EscribeEsConyugue2Recibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                            'Definir si tu conyugue ha ejercido en política es obligatoria'),
                      );
                    });
              }
              PrimerNombre2Recibe = PrimerNombre2.text;
              SegundoNombre2Recibe = SegundoNombre2.text;
              ApellidoPaterno2Recibe = ApellidoPaterno2.text;
              ApellidoMaterno2Recibe = ApellidoMaterno2.text;
              print("**1");
              print(EsPropietarioRecibe);
              print("**2");
              print(EscribeEsConyugueRecibe);
              print("**3");
              print(EsPropietario2Recibe);
              print("**4");
              print(EscribeEsConyugue2Recibe);

              if (PantallaRecibe == "" ||
                  IDClinicaRecibe == "" ||
                  EsPropietarioRecibe == "" ||
                  EscribeEsConyugueRecibe == "" ||
                  EsPropietario2Recibe == "" ||
                  EscribeEsConyugue2Recibe == "") {
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
                    EsPropietarioRecibe,
                    CargoRecibe,
                    PeriodoRecibe,
                    EscribeEsConyugueRecibe,
                    PrimerNombreRecibe,
                    SegundoNombreRecibe,
                    ApellidoPaternoRecibe,
                    ApellidoMaternoRecibe,
                    EsPropietario2Recibe,
                    Cargo2Recibe,
                    Periodo2Recibe,
                    EscribeEsConyugue2Recibe,
                    PrimerNombre2Recibe,
                    SegundoNombre2Recibe,
                    ApellidoPaterno2Recibe,
                    ApellidoMaterno2Recibe);
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
              MaterialPageRoute(builder: (context) => FinClinicas12()));
        },
      ),
    );
  }
}
