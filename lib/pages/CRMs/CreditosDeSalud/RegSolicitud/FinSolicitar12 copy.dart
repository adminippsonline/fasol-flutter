import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as dev;
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

import 'FinSolicitar12.dart';
import 'FinSolicitar13.dart';
import 'FinSolicitar13_0.dart';

import 'package:intl/intl.dart';

class FinSolicitar12 extends StatefulWidget {
  const FinSolicitar12({super.key});

  @override
  State<FinSolicitar12> createState() => _FinSolicitar12State();
}

class _FinSolicitar12State extends State<FinSolicitar12> {
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
    return MyCustomFormFinSolicitar12();
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar12 extends StatefulWidget {
  const MyCustomFormFinSolicitar12({super.key});

  @override
  MyCustomFormFinSolicitar12State createState() {
    return MyCustomFormFinSolicitar12State();
  }
}

//enum OpcionesFirmaElectronica { Si, No }
//enum OpcionesCargoPolitico { Si, No }
//enum OpcionesEsConyugue { Si, No }

class MyCustomFormFinSolicitar12State
    extends State<MyCustomFormFinSolicitar12> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  var MasccaraPeriodo = new MaskTextInputFormatter(
      mask: '0000-0000', filter: {"0": RegExp(r'[0-9]')});

  String? _opcionesTipoDePersona;
  bool _opcionTipoAsalariado = false;
  bool _opcionTipoEmpresarialOIndependiente = false;

  void SeleccionadoOrigenDeLosRecursos(value) {
    setState(() {
      _opcionesTipoDePersona = value;
      if (_opcionesTipoDePersona == "Asalariado") {
        _opcionTipoAsalariado = true;
        _opcionTipoEmpresarialOIndependiente = false;
      } else if (_opcionesTipoDePersona == "Independiente") {
        _opcionTipoEmpresarialOIndependiente = true;
        _opcionTipoAsalariado = false;
      } else if (_opcionesTipoDePersona ==
          "Persona Física con actividad empresarial y profesional") {
        _opcionTipoEmpresarialOIndependiente = true;
        _opcionTipoAsalariado = false;
      }
    });
  }

  final List<String> ListaAntiguedadTiempo = ['Años', 'Meses'];
  String? SelectedListaAntiguedadTiempo;

  final List<String> ListaAntiguedadPFTiempo = ['Años', 'Meses'];
  String? SelectedListaAntiguedadPFTiempo;

  final List<String> ListaSector = ['Comercial', 'Servicio', 'Producción'];
  String? SelectedListaSector;

  String? _opcionesFirmaElectronica;
  bool _siFirmaElectronica = false;

  void SeleccionadoFirmaElectronica(value) {
    setState(() {
      //print(value);
      _opcionesFirmaElectronica = value;
      _siFirmaElectronica = value == "Si";
    });
  }

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

  final List<String> ListaTipoDePersona = [
    'Asalariado',
    'Persona Física con actividad empresarial y profesional',
    'Independiente',
  ];
  String? SelectedListaTipoDePersona;

  final List<String> ListaPais = ['México'];
  String? SelectedListaPais;

  final List<String> ListaEstado = [
    'Aguascalientes',
    'Baja California',
    'Baja California Sur',
    'Campeche',
    'Chiapas',
    'Chihuahua',
    'Ciudad de México',
    'Coahuila',
    'Colima',
    'Durango',
    'Estado de México',
    'Guanajuato',
    'Guerrero',
    'Hidalgo',
    'Jalisco',
    'Michoacán',
    'Morelos',
    'Nayarit',
    'Nuevo León',
    'Oaxaca',
    'Puebla',
    'Querétaro',
    'Quintana Roo',
    'San Luis Potosí',
    'Sinaloa',
    'Sonora',
    'Tabasco',
    'Tamaulipas',
    'Tlaxcala',
    'Veracruz',
    'Yucatán',
    'Zacatecas'
  ];
  String? SelectedListaEstado;

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDLR = TextEditingController();
  final IDInfo = TextEditingController();

  final TipoDePersona = TextEditingController();

  final NombreEmpresaLaboras = TextEditingController();
  final CargoLaboras = TextEditingController();
  final Antiguedad = TextEditingController();
  final AntiguedadTiempo = TextEditingController();

  final GiroDelNegocio = TextEditingController();
  final NombreEmpresa = TextEditingController();
  final AntiguedadPF = TextEditingController();
  final AntiguedadPFTiempo = TextEditingController();
  final Sector = TextEditingController();
  final Calle = TextEditingController();
  final NumExt = TextEditingController();
  final NumInt = TextEditingController();
  final CP = TextEditingController();
  final Estado = TextEditingController();
  final EntCall = TextEditingController();
  final MunDel = TextEditingController();
  final Ciudad = TextEditingController();
  final Colonia = TextEditingController();
  final Pais = TextEditingController();

  final Profesion = TextEditingController();
  final Ocupacion = TextEditingController();
  final ActividadEconomica = TextEditingController();

  final Ingresos = TextEditingController();
  final GastosMensuales = TextEditingController();

  final FirmaElectronica = TextEditingController();
  final NumeroFirmaElectronica = TextEditingController();

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

  String TipoDePersonaRecibe = "";

  String NombreEmpresaLaborasRecibe = "";
  String CargoLaborasRecibe = "";
  String AntiguedadRecibe = "";
  String AntiguedadTiempoRecibe = "";

  String GiroDelNegocioRecibe = "";
  String NombreEmpresaRecibe = "";
  String AntiguedadPFRecibe = "";
  String AntiguedadPFTiempoRecibe = "";
  String SectorRecibe = "";
  String CalleRecibe = "";
  String NumExtRecibe = "";
  String NumIntRecibe = "";
  String CPRecibe = "";
  String EstadoRecibe = "";
  String EntCallRecibe = "";
  String MunDelRecibe = "";
  String CiudadRecibe = "";
  String ColoniaRecibe = "";
  String PaisRecibe = "";

  String ProfesionRecibe = "";
  String OcupacionRecibe = "";
  String ActividadEconomicaRecibe = "";

  String IngresosRecibe = "";
  String GastosMensualesRecibe = "";

  String FirmaElectronicaRecibe = "";
  String NumeroFirmaElectronicaRecibe = "";

  String CargoPoliticoRecibe = "";
  String CargoRecibe = "";
  String PeriodoDelCargoRecibe = "";
  String EsConyugueRecibe = "";
  String PrimerNombreRecibe = "";
  String SegundoNombreRecibe = "";
  String ApellidoPaternoRecibe = "";
  String ApellidoMaternoRecibe = "";

  int GastosMensualesEntero = 0;

  void Ingresar(
      Pantalla,
      IDLR,
      IDInfo,
      TipoDePersona,
      Profesion,
      Ocupacion,
      ActividadEconomica,
      Ingresos,
      GastosMensualesEntero,
      FirmaElectronica,
      NumeroFirmaElectronica,
      CargoPolitico,
      Cargo,
      PeriodoDelCargo,
      EsConyugue,
      PrimerNombre,
      SegundoNombre,
      ApellidoPaterno,
      ApellidoMaterno) async {
    try {
      print("xxxxxxxx");
      /*var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');
//print("*****");
print("****");
print(GastosMensuales);
print("****");
      var data = {
        'Pantalla': Pantalla,
        'id_solicitud': IDLR,
        'id_credito': IDInfo,
        'TipoDePersona': TipoDePersona,
        'Profesion': Profesion,
        'Ocupacion': Ocupacion,
        'ActividadEconomica': ActividadEconomica,
        'Ingresos': Ingresos,
        'GastosMensuales': '$GastosMensualesEntero', 
        //'FirmaElectronica': FirmaElectronica,
        //'NumeroFirmaElectronica': NumeroFirmaElectronica,
        'CargoPolitico': CargoPolitico,
        'Cargo': Cargo,
        'PeriodoDelCargo': PeriodoDelCargo,
        'EsConyugue': EsConyugue,
        'PrimerNombre': PrimerNombre,
        'SegundoNombre': SegundoNombre,
        'ApellidoPaterno': ApellidoPaterno,
        'ApellidoMaterno': ApellidoMaterno
      };*/
      /*print(data);
      var response = await http.post(url, body: data).timeout(const Duration(seconds: 90));
      print("llego aqui 111");
      print(response.body);
      */
      /*if (response.body != "0" && response.body != "") {
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
                MaterialPageRoute(builder: (_) => FinSolicitar13()));
            FocusScope.of(context).unfocus();
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => FinSolicitar13_0()));
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
      }*/
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

  //variable que mostrara las profesiones
  List _opcionesProfesiones = [];
  List _opcionesOcupaciones = [];
  List _opcionesActividadesEconomicas = [];

  @override
  void initState() {
    super.initState();
    mostrar_datos();
    obtenerOpciones();
    obtenerOcupacion();
    obtenerActividadesEconomicas();
  }

  void mostrar_datos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      NombreCompletoSession = prefs.getString('NombreCompletoSession') ?? '';
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_credito = prefs.getInt('id_credito') ?? 0;
    });

    Pantalla.text = 'FinSolicitar12';
    IDLR.text = "$id_solicitud";
    IDInfo.text = "$id_credito";
  }

  //funcion para obtener profesiones
  Future obtenerOpciones() async {
    final response = await http.get(Uri.parse(
        'https://fasoluciones.mx/api/Solicitud/Catalogos/Profesiones'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      //dev.log(jsonData.toString());
      setState(() {
        _opcionesProfesiones = jsonData;
      });
    } else {
      throw Exception('Error al obtener las opciones');
    }
  }

  //funcion para obtener ocupaciones
  Future obtenerOcupacion() async {
    final response = await http.get(Uri.parse(
        'https://fasoluciones.mx/api/Solicitud/Catalogos/Ocupaciones'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      //dev.log(jsonData.toString());
      setState(() {
        _opcionesOcupaciones = jsonData;
      });
    } else {
      throw Exception('Error al obtener las opciones');
    }
  }

  Future obtenerActividadesEconomicas() async {
    final response = await http.get(Uri.parse(
        'https://fasoluciones.mx/api/Solicitud/Catalogos/ActividadesEconomicas'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      //dev.log(jsonData.toString());
      setState(() {
        _opcionesActividadesEconomicas = jsonData;
      });
    } else {
      throw Exception('Error al obtener las opciones');
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
                SubitleCards("A cerca de ti "),
                SizedBox(
                  height: 20,
                ),
                _Pantalla(),
                _IDLR(),
                _IDInfo(),
                _TipoDePersona(),
                _Ocupacion(),
                _Profesion(),
                _ActividadEconomica(),
                if (_opcionTipoAsalariado)
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
                                child: _NombreEmpresaLaboras(),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _CargoLaboras(),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _Antiguedad(),
                              ),
                              Expanded(
                                child: _AntiguedadTiempo(),
                              ),
                            ],
                          ),
                        ],
                      )),
                if (_opcionTipoEmpresarialOIndependiente)
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
                                child: _GiroDelNegocio(),
                              ),
                              Expanded(
                                child: _NombreEmpresa(),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _AntiguedadPF(),
                              ),
                              Expanded(
                                child: _AntiguedadPFTiempo(),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _Sector(),
                              ),
                            ],
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
                                "Domicilio del negocio",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 17,
                                  //color: Colors.blue
                                ),
                                textScaleFactor: 1,
                              )),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _CP(),
                              ),
                              Expanded(
                                child: _Pais(),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _Calle(),
                              ),
                              Expanded(
                                child: _NumExt(),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _NumInt(),
                              ),
                              Expanded(
                                child: _EntCall(),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _Estado(),
                              ),
                              Expanded(
                                child: _MunDel(),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _Ciudad(),
                              ),
                              Expanded(
                                child: _Colonia(),
                              ),
                            ],
                          ),
                        ],
                      )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _Ingresos(),
                    ),
                    Expanded(
                      child: _GastosMensuales(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
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
                      "¿Cuentas con firma electrónica?",
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
                          groupValue: _opcionesFirmaElectronica,
                          onChanged: SeleccionadoFirmaElectronica,
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
                        groupValue: _opcionesFirmaElectronica,
                        onChanged: SeleccionadoFirmaElectronica,
                      )),
                    ],
                  ),
                ),
                if (_siFirmaElectronica)
                  Container(
                      padding: EdgeInsets.only(left: 1.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          //border: Border.all(
                          //color: Colors.blueAccent
                          //)
                          ),
                      child: _NumeroFirmaElectronica()),
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
                _BotonEnviar(),
                SizedBox(
                  height: 20,
                ),
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
        //visible: false,
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
        //visible: false,
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

  Widget _TipoDePersona() {
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
              'Tipo de persona',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaTipoDePersona.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )).toList(),
            validator: ObligatorioSelect,
            onChanged: (value) {
              SelectedListaTipoDePersona = value;
              SeleccionadoOrigenDeLosRecursos(value);
              //print(SelectedListaTipoDePersona);
            },
            onSaved: (value) {
              //print("bbb");
              SelectedListaTipoDePersona = value.toString();
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

  Widget _NombreEmpresaLaboras() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: NombreEmpresaLaboras,
        decoration: InputDecoration(
            labelText: 'Nombre de la empresa en donde laboras',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _CargoLaboras() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: CargoLaboras,
        decoration: InputDecoration(
            labelText: 'Cargo',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Antiguedad() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: Antiguedad,
        decoration: InputDecoration(
            labelText: 'Antigüedad',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _AntiguedadTiempo() {
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
              'Tiempo',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaAntiguedadTiempo.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )).toList(),
            validator: ObligatorioSelect,
            onChanged: (value) {
              SelectedListaAntiguedadTiempo = value;
            },
            onSaved: (value) {
              SelectedListaAntiguedadTiempo = value.toString();
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

  /////////////////
  ///
  Widget _GiroDelNegocio() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: GiroDelNegocio,
        decoration: InputDecoration(
            labelText: 'Giro del negocio',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _NombreEmpresa() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: NombreEmpresa,
        decoration: InputDecoration(
            labelText: 'Nombre de la empresa o comercio',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _AntiguedadPF() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: AntiguedadPF,
        decoration: InputDecoration(
            labelText: 'Antiguedad',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _AntiguedadPFTiempo() {
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
              'Tiempo',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaAntiguedadTiempo.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )).toList(),
            validator: ObligatorioSelect,
            onChanged: (value) {
              SelectedListaAntiguedadPFTiempo = value;
            },
            onSaved: (value) {
              SelectedListaAntiguedadPFTiempo = value.toString();
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

  Widget _Sector() {
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
              'Sector',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaSector.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )).toList(),
            validator: ObligatorioSelect,
            onChanged: (value) {
              SelectedListaSector = value;
            },
            onSaved: (value) {
              SelectedListaSector = value.toString();
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

  List<dynamic> _colonyList = [];
  Future obtenerCP(var codigo) async {
    //dev.log("t");
    final req = {"CP": codigo};
    var url =
        Uri.parse('https://fasoluciones.mx/api/Solicitud/Catalogos/CP/$codigo');

    var request = await http.MultipartRequest('POST', url);
    request = jsonToFormData(request, req);

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData =
          await response.stream.bytesToString(); //response.stream.toBytes();
      //dev.log(responseData.toString());

      var responseString = responseData;
      final dat = json.decode(responseString);
      //dev.log("adata");
      //dev.log(dat.toString());
      var data = json.decode(responseString)['data'][0];
      setState(() {
        // Colonia.text = data['Estado'].toString();
        MunDel.text = data['MunDel'].toString();
        Estado.text = data['Estado'].toString();
        // EstadoRecibe = data['Estado'].toString();
        Ciudad.text = data['Ciudad'].toString();

        _colonyList =
            List<String>.from(dat['data'].map((address) => address['Colonia']));
      });
      setState(() {});
    } else {
      throw Exception('Error al obtener las opciones');
    }
  }

  Widget _CP() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioCP,
        onChanged: (value) {
          if (value.length == 5) {
            //dev.log("algo");
            obtenerCP(value);
          } else if (value.length < 4) {
            _selectedColony = null;
          }
        },
        keyboardType: TextInputType.number,
        controller: CP,
        maxLength: 5,
        decoration: InputDecoration(
            labelText: 'CP',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: '',
            counterText: ''),
      ),
    );
  }

  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }

  Widget _Pais() {
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
              'País',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaPais.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )).toList(),
            validator: ObligatorioSelect,
            onChanged: (value) {
              SelectedListaPais = value;
            },
            onSaved: (value) {
              SelectedListaPais = value.toString();
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

  Widget _Ciudad() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        //validator: ObligatorioSoloTexto,
        //validator: validarCampo,
        keyboardType: TextInputType.text,
        controller: Ciudad,
        decoration: InputDecoration(
            labelText: 'Ciudad o población',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Calle() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioInput,
        keyboardType: TextInputType.text,
        controller: Calle,
        decoration: InputDecoration(
            labelText: 'Calle',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _NumExt() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioInput,
        keyboardType: TextInputType.text,
        controller: NumExt,
        decoration: InputDecoration(
            labelText: '#Num Ext',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _NumInt() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        //validator: ObligatorioInput,
        keyboardType: TextInputType.text,
        controller: NumInt,
        decoration: InputDecoration(
            labelText: '#Num Int',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _EntCall() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioInput,
        keyboardType: TextInputType.text,
        controller: EntCall,
        decoration: InputDecoration(
            labelText: 'Entre calles',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Estado() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: validarCampo,
        keyboardType: TextInputType.text,
        controller: Estado,
        decoration: InputDecoration(
            labelText: 'Estado',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  // Widget _Estado() {
  //   return Container(
  //     padding: EdgeInsets.all(10),
  //     width: double.infinity,
  //     child: DecoratedBox(
  //         decoration: BoxDecoration(),
  //         child: DropdownButtonFormField2(
  //           decoration: InputDecoration(
  //             isDense: true,
  //             contentPadding: EdgeInsets.zero,
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(5),
  //             ),
  //           ),
  //           isExpanded: true,
  //           hint: const Text(
  //             'Estado',
  //             style: TextStyle(fontSize: 14),
  //           ),
  //           items: ListaEstado.map((item) => DropdownMenuItem<String>(
  //                 value: item,
  //                 child: Text(
  //                   item,
  //                   style: const TextStyle(
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //               )).toList(),
  //           validator: ObligatorioSelect,
  //           onChanged: (value) {
  //             SelectedListaEstado = value;
  //           },
  //           onSaved: (value) {
  //             SelectedListaEstado = value.toString();
  //           },
  //           buttonStyleData: const ButtonStyleData(
  //             height: 55,
  //             padding: EdgeInsets.only(left: 0, right: 10),
  //           ),
  //           iconStyleData: const IconStyleData(
  //             icon: Icon(
  //               Icons.arrow_drop_down,
  //               color: Colors.black45,
  //             ),
  //             iconSize: 30,
  //           ),
  //           dropdownStyleData: DropdownStyleData(
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(1),
  //             ),
  //           ),
  //         )),
  //   );
  // }

  Widget _MunDel() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        //validator: ObligatorioSoloTexto,
        validator: validarCampo,
        keyboardType: TextInputType.text,
        controller: MunDel,
        decoration: InputDecoration(
            labelText: 'Municipio o alcaldía',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  String? _selectedColony;
  Widget _Colonia() {
    return Container(
        padding: EdgeInsets.all(10),
        child: DropdownButtonFormField2<String>(
          value: _selectedColony,
          onChanged: (newValue) {
            setState(() {
              newValue = newValue;
              _selectedColony = newValue;
            });
          },
          validator: ObligatorioSelect,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          isExpanded: true,
          hint: Text(
            'Colonia',
            style: TextStyle(fontSize: 12),
          ),
          items: _colonyList.map((value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          buttonStyleData: const ButtonStyleData(
            height: 50,
            padding: EdgeInsets.only(left: 0, right: 9),
          ),
        ));
  }

  String? _opcionSeleccionada;
  var dropdownvalue;
  Widget _Profesion() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: DecoratedBox(
        decoration: BoxDecoration(),
        child: DropdownButtonFormField2<String>(
          validator: ObligatorioSelect,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          isExpanded: true,
          hint: Text(
            'Profesiones',
            style: TextStyle(fontSize: 12),
          ),
          items: _opcionesProfesiones.map((item) {
            return DropdownMenuItem(
              value: item['nombreprofesion'].toString(), //id_profesion
              child: Text(item['nombreprofesion'].toString()),
            );
          }).toList(),
          buttonStyleData: const ButtonStyleData(
            height: 50,
            padding: EdgeInsets.only(left: 0, right: 9),
          ),
          onChanged: (newVal) {
            setState(() {
              dropdownvalue = newVal;
            });
          },
          value: dropdownvalue,
        ),
      ),
    );
  }

  /*Widget _Ocupacion() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Ocupacion,
        decoration: InputDecoration(
            labelText: 'Ocupación',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }*/

  String? _ocupacionSeleccionada;
  var dropdownvalueOcupacion;
  Widget _Ocupacion() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: DecoratedBox(
        decoration: BoxDecoration(),
        child: DropdownButtonFormField2<String>(
          validator: ObligatorioSelect,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          isExpanded: true,
          hint: Text(
            'Ocupación',
            style: TextStyle(fontSize: 12),
          ),
          items: _opcionesOcupaciones.map((item) {
            return DropdownMenuItem(
              value: item['nombreocupacion'].toString(),
              child: Text(item['nombreocupacion'].toString()),
            );
          }).toList(),
          buttonStyleData: const ButtonStyleData(
            height: 50,
            padding: EdgeInsets.only(left: 0, right: 9),
          ),
          onChanged: (newVal) {
            setState(() {
              dropdownvalueOcupacion = newVal;
            });
          },
          value: dropdownvalueOcupacion,
        ),
      ),
    );
  }

  // Widget _Ocupacion() {
  //   return Container(
  //     padding: EdgeInsets.all(10),
  //     width: double.infinity,
  //     child: DecoratedBox(
  //         decoration: BoxDecoration(),
  //         child: DropdownButtonFormField2(
  //           decoration: InputDecoration(
  //             isDense: true,
  //             contentPadding: EdgeInsets.zero,
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(5),
  //             ),
  //           ),
  //           isExpanded: true,
  //           hint: const Text(
  //             'Ocupación',
  //             style: TextStyle(fontSize: 14),
  //           ),
  //           items: ListaOcupacion.map((item) => DropdownMenuItem<String>(
  //                 value: item,
  //                 child: Text(
  //                   item,
  //                   style: const TextStyle(
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //               )).toList(),
  //           validator: ObligatorioSelect,
  //           onChanged: (value) {
  //             SelectedListaOcupacion = value;
  //           },
  //           onSaved: (value) {
  //             SelectedListaOcupacion = value.toString();
  //           },
  //           buttonStyleData: const ButtonStyleData(
  //             height: 55,
  //             padding: EdgeInsets.only(left: 0, right: 10),
  //           ),
  //           iconStyleData: const IconStyleData(
  //             icon: Icon(
  //               Icons.arrow_drop_down,
  //               color: Colors.black45,
  //             ),
  //             iconSize: 30,
  //           ),
  //           dropdownStyleData: DropdownStyleData(
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(1),
  //             ),
  //           ),
  //         )),
  //   );
  // }

  /*Widget _ActividadEconomica() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: ActividadEconomica,
        decoration: InputDecoration(
            labelText: 'Actividad económica',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }*/

  String? _opcionSeleccionadaActividadEconomica;
  var dropdownvalueActividadEconomica;
  Widget _ActividadEconomica() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: DecoratedBox(
        decoration: BoxDecoration(),
        child: DropdownButtonFormField2<String>(
          validator: ObligatorioSelect,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          isExpanded: true,
          hint: Text(
            'Actividad Económica',
            style: TextStyle(fontSize: 12),
          ),
          items: _opcionesActividadesEconomicas.map((item) {
            return DropdownMenuItem(
              value: item['nombreactividadeconomica'].toString(),
              child: Text(item['nombreactividadeconomica'].toString()),
            );
          }).toList(),
          buttonStyleData: const ButtonStyleData(
            height: 50,
            padding: EdgeInsets.only(left: 0, right: 9),
          ),
          onChanged: (newVal) {
            setState(() {
              dropdownvalueActividadEconomica = newVal;
            });
          },
          value: dropdownvalueActividadEconomica,
        ),
      ),
    );
  }

  Widget _Ingresos() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: Ingresos,
        decoration: InputDecoration(
            labelText: 'Ingresos',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _GastosMensuales() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: GastosMensuales,
        decoration: InputDecoration(
            labelText: 'Gastos mensuales',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _NumeroFirmaElectronica() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: NumeroFirmaElectronica,
        decoration: InputDecoration(
            labelText: 'No. de firma electrónica ',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
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
              print("***");
              print(PantallaRecibe);
              IDLRRecibe = IDLR.text;
              IDInfoRecibe = IDInfo.text;

              String? TipoDePersonaRecibe = SelectedListaTipoDePersona;
              //print(TipoDePersonaRecibe);
              if (TipoDePersonaRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El tipo de persona es obligatorio'),
                      );
                    });
              }

              String? AntiguedadTiempoRecibe = SelectedListaAntiguedadTiempo;
              //print(AntiguedadTiempoRecibe);
              if (AntiguedadTiempoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El tiempo en la empresa es obligatorio'),
                      );
                    });
              }

              String? AntiguedadPFTiempoRecibe =
                  SelectedListaAntiguedadPFTiempo;
              //print(AntiguedadPFTiempoRecibe);
              if (AntiguedadPFTiempoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El tiempo en la empresa es obligatorio'),
                      );
                    });
              }

              String? SectorRecibe = SelectedListaSector;
              //print(SectorRecibe);
              if (SectorRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El sector es obligatorio'),
                      );
                    });
              }

              String? ProfesionRecibe =
                  dropdownvalue.toString(); // SelectedListaProfesion;
              if (ProfesionRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La profesión es obligatoria'),
                      );
                    });
              }
              //dev.log(ProfesionRecibe);
              String? OcupacionRecibe =
                  dropdownvalueOcupacion.toString(); // SelectedListaOcupacion;
              if (OcupacionRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La ocupación es obligatoria'),
                      );
                    });
              }
              //print(OcupacionRecibe);
              String? ActividadEconomicaRecibe = dropdownvalueActividadEconomica
                  .toString(); //SelectedListaActividadEconomica;
              if (ActividadEconomicaRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La actividad económica es obligatoria'),
                      );
                    });
              }
              //print(ActividadEconomicaRecibe);

              IngresosRecibe = Ingresos.text;
              GastosMensualesRecibe = GastosMensuales.text;

              String? FirmaElectronicaRecibe = _opcionesFirmaElectronica;
              if (FirmaElectronicaRecibe == "" ||
                  FirmaElectronicaRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title:
                            Text('La opción firma electrónica es obligatoria'),
                      );
                    });
              }

              NumeroFirmaElectronicaRecibe = NumeroFirmaElectronica.text;

              String? CargoPoliticoRecibe = _opcionesCargoPolitico;
              if (CargoPoliticoRecibe == "" || CargoPoliticoRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Definir el cargo político es obligatoria'),
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

/*print(PantallaRecibe);
print(IDLRRecibe);
print(IDInfoRecibe);
print(TipoDePersonaRecibe);
print(ProfesionRecibe);
print(OcupacionRecibe);
print(ActividadEconomicaRecibe);
print(IngresosRecibe);*/
//print(GastosMensualesRecibe);
/*print(FirmaElectronicaRecibe);
print(CargoPoliticoRecibe);
print(EsConyugueRecibe);*/

              if (PantallaRecibe == "" ||
                  IDLRRecibe == "" ||
                  IDInfoRecibe == "" ||
                  TipoDePersonaRecibe == "" ||
                  ProfesionRecibe == "" ||
                  OcupacionRecibe == "" ||
                  ActividadEconomicaRecibe == "" ||
                  IngresosRecibe == "" ||
                  GastosMensualesRecibe == "" ||
                  FirmaElectronicaRecibe == "" ||
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
                /*Ingresar(
                    PantallaRecibe,
                    IDLRRecibe,
                    IDInfoRecibe,
                    TipoDePersonaRecibe,
                    ProfesionRecibe,
                    OcupacionRecibe,
                    ActividadEconomicaRecibe,
                    IngresosRecibe,
                    GastosMensuales,
                    FirmaElectronica,
                    NumeroFirmaElectronica,
                    CargoPoliticoRecibe,
                    CargoRecibe,
                    PeriodoDelCargoRecibe,
                    EsConyugueRecibe,
                    PrimerNombreRecibe,
                    SegundoNombreRecibe,
                    ApellidoPaternoRecibe,
                    ApellidoMaternoRecibe
                    );*/
              }
            }
          },
          child: const Text('Siguiente_')),
    );
  }
}
