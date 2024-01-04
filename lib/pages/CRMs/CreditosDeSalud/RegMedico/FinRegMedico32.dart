import 'package:flutter/material.dart';
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

import 'FinRegMedico33.dart';

import 'package:intl/intl.dart';

import '../modelos/model_hijos.dart';
import '../modelos/model_socios.dart';

class FinRegMedico32 extends StatefulWidget {
  const FinRegMedico32({super.key});

  @override
  State<FinRegMedico32> createState() => _FinRegMedico32State();
}

class _FinRegMedico32State extends State<FinRegMedico32> {
  //se usa para mostrar los datos del estado
  int id_medico = 0;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomFormFinRegMedico32();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(NombreCompletoSession),
    //   ),
    //   drawer: MenuLateralPage(),
    //   bottomNavigationBar: MenuFooterPage(),
    //   body: const MyCustomFormFinRegMedico32(),
    // );
  }
}

// Create a Form widget.
class MyCustomFormFinRegMedico32 extends StatefulWidget {
  const MyCustomFormFinRegMedico32({super.key});

  @override
  MyCustomFormFinRegMedico32State createState() {
    return MyCustomFormFinRegMedico32State();
  }
}

class MyCustomFormFinRegMedico32State
    extends State<MyCustomFormFinRegMedico32> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  final List<String> ListaTipoFondo = [
    'Salario',
    'Rentas',
    'Ingresos por Negocio Propio',
    'Comisiones'
  ];
  String? SelectedListaTipoFondo;

  ////////////////
  String? _opcionesConHijos;
  bool _siConHijos = false;

  void SeleccionadoConHijos(value) {
    setState(() {
      //print(value);
      _opcionesConHijos = value;
      // _siConHijos = value == "Si";
      if (_siConHijos = value == "Si") {
        buttonHijos();
        //_mostrarModalForm(context);
      }
    });
  }

  Widget buttonHijos() {
    return ElevatedButton(
      onPressed: () {},
      child: Text("generar formulario Hijos"),
    );
  }


  String? _opcionesEsSocioAccionista;
  bool _siEsSocioAccionista = false;

  void SeleccionadoEsSocioAccionista(value) {
    setState(() {
      //print(value);
      _opcionesEsSocioAccionista = value;
      _siEsSocioAccionista = value == "Si";
      if (_siEsSocioAccionista = value == "Si") {
        buttonSocios();
        //_mostrarModalForm(context);
      }
    });
  }

  Widget buttonSocios() {
    return ElevatedButton(
      onPressed: () {},
      child: Text("generar formulario Socios"),
    );
  }
  /////////////
  String? _opcionesEstadoCivil;
  bool _casadoEstadoCivil = false;

  void SeleccionadoEstadoCivil(value) {
    setState(() {
      //print(value);
      _opcionesEstadoCivil = value;
      _casadoEstadoCivil = value == "Casado";
    });
  }

  String? _opcionesLaMadreVive;
  bool _siLaMadreVive = false;

  void SeleccionadoLaMadreVive(value) {
    setState(() {
      //print(value);
      _opcionesLaMadreVive = value;
      _siLaMadreVive = value == "Si";
    });
  }

  String? _opcionesElPadreVive;
  bool _siElPadreVive = false;

  void SeleccionadoElPadreVive(value) {
    setState(() {
      //print(value);
      _opcionesElPadreVive = value;
      _siElPadreVive = value == "Si";
    });
  }

  

  ////////////////////////////

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDMedico = TextEditingController();

  final NombreEmpresa = TextEditingController();
  final TipoFondo = TextEditingController();
  final IngresoMensual = TextEditingController();
  final ConHijos = TextEditingController();
  final CuantosHijos = TextEditingController();
  final EstadoCivil = TextEditingController();
  final Conyuge_PrimerNombre = TextEditingController();
  final Conyuge_SegundoNombre = TextEditingController();
  final Conyuge_ApellidoPaterno = TextEditingController();
  final Conyuge_ApellidoMaterno = TextEditingController();
  final Conyuge_Direccion = TextEditingController();
  final LaMadreVive = TextEditingController();
  final Madre_PrimerNombre = TextEditingController();
  final Madre_SegundoNombre = TextEditingController();
  final Madre_ApellidoPaterno = TextEditingController();
  final Madre_ApellidoMaterno = TextEditingController();
  final Madre_Direccion = TextEditingController();
  final ElPadreVive = TextEditingController();
  final Padre_PrimerNombre = TextEditingController();
  final Padre_SegundoNombre = TextEditingController();
  final Padre_ApellidoPaterno = TextEditingController();
  final Padre_ApellidoMaterno = TextEditingController();
  final Padre_Direccion = TextEditingController();
  final EsSocioAccionista = TextEditingController();
  final CuantasEmpresas = TextEditingController();

  final _HPrimerNombre = TextEditingController();
  final _HSegundoNombre = TextEditingController();
  final _HApellidoPaterno = TextEditingController();
  final _HApellidoMaterno = TextEditingController();
  final _HEdad = TextEditingController();
  final _HGenero = TextEditingController();
  final _HDireccion = TextEditingController();

  final _HNombreEsSocioAccionista = TextEditingController();
  final _HParticipacionEsSocioAccionista = TextEditingController();
  final _HTelefonoEsSocioAccionista = TextEditingController();
  final _HADireccionEsSocioAccionista = TextEditingController();

  String PantallaRecibe = "";
  String IDMedicoRecibe = "";

  String NombreEmpresaRecibe = "";
  String TipoFondoRecibe = "";
  String IngresoMensualRecibe = "";
  String ConHijosRecibe = "";
  String CuantosHijosRecibe = "";
  String HijosRecibe = "";
  String EstadoCivilRecibe = "";
  String Conyuge_PrimerNombreRecibe = "";
  String Conyuge_SegundoNombreRecibe = "";
  String Conyuge_ApellidoPaternoRecibe = "";
  String Conyuge_ApellidoMaternoRecibe = "";
  String Conyuge_DireccionRecibe = "";
  String LaMadreViveRecibe = "";
  String Madre_PrimerNombreRecibe = "";
  String Madre_SegundoNombreRecibe = "";
  String Madre_ApellidoPaternoRecibe = "";
  String Madre_ApellidoMaternoRecibe = "";
  String Madre_DireccionRecibe = "";
  String ElPadreViveRecibe = "";
  String Padre_PrimerNombreRecibe = "";
  String Padre_SegundoNombreRecibe = "";
  String Padre_ApellidoPaternoRecibe = "";
  String Padre_ApellidoMaternoRecibe = "";
  String Padre_DireccionRecibe = "";
  String EsSocioAccionistaRecibe = "";
  String CuantasEmpresasRecibe = "";

  String jsonStringHihos="";
  String jsonStringSocios="";
  void Ingresar(
    Pantalla,
    IDMedico,
    NombreEmpresa,
    TipoFondo,
    IngresoMensual,
    ConHijos,
    CuantosHijos,
    Hijos,
    EstadoCivil,
    Conyuge_PrimerNombre,
    Conyuge_SegundoNombre,
    Conyuge_ApellidoPaterno,
    Conyuge_ApellidoMaterno,
    Conyuge_Direccion,
    LaMadreVive,
    Madre_PrimerNombre,
    Madre_SegundoNombre,
    Madre_ApellidoPaterno,
    Madre_ApellidoMaterno,
    Madre_Direccion,
    ElPadreVive,
    Padre_PrimerNombre,
    Padre_SegundoNombre,
    Padre_ApellidoPaterno,
    Padre_ApellidoMaterno,
    Padre_Direccion,
    EsSocioAccionista,
    CuantasEmpresas,
    Socios
  ) async {
    //print("xxxxx");
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Medico/Agregar');
      //print(Hijos);
       
      //final MandarHijos = json.decode(Hijos);
      final MandarHijos = "";
      //final MandarSocios = json.decode(Socios);
      final MandarSocios = "";
      /*print("**++**");
      print(Hijos);
      print("**++**");*/
      var Mandar = {
        'Pantalla': Pantalla,
        'id_medico': IDMedico,
        'NombreEmpresa': NombreEmpresa,
        'TipoFondo': TipoFondo,
        'IngresoMensual': IngresoMensual,
        'ConHijos': ConHijos,
        'CuantosHijos': CuantosHijos,
        'Hijos':MandarHijos, 
        'EstadoCivil': EstadoCivil,
        'Conyuge_PrimerNombre': Conyuge_PrimerNombre,
        'Conyuge_SegundoNombre': Conyuge_SegundoNombre,
        'Conyuge_ApellidoPaterno': Conyuge_ApellidoPaterno,
        'Conyuge_ApellidoMaterno': Conyuge_ApellidoMaterno,
        'Conyuge_Direccion': Conyuge_Direccion,
        'LaMadreVive': LaMadreVive,
        'Madre_PrimerNombre': Madre_PrimerNombre,
        'Madre_SegundoNombre': Madre_SegundoNombre,
        'Madre_ApellidoPaterno': Madre_ApellidoPaterno,
        'Madre_ApellidoMaterno': Madre_ApellidoMaterno,
        'Madre_Direccion': Madre_Direccion,
        'ElPadreVive': ElPadreVive,
        'Padre_PrimerNombre': Padre_PrimerNombre,
        'Padre_SegundoNombre': Padre_SegundoNombre,
        'Padre_ApellidoPaterno': Padre_ApellidoPaterno,
        'Padre_ApellidoMaterno': Padre_ApellidoMaterno,
        'Padre_Direccion': Padre_Direccion,
        'EsSocioAccionista': EsSocioAccionista,
        'CuantasEmpresas': CuantasEmpresas,
        'Socios': MandarSocios,
      };
      /*print("**");
      print(Mandar);
      print("**");*/

      var response = await http
          .post(url, body: Mandar)
          .timeout(const Duration(seconds: 90));
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
              MaterialPageRoute(builder: (_) => FinRegMedico33()));
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
    guardarDatos();
    guardarDatosSocios();
    setState(() {
      NombreCompletoSession =
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      id_medico = prefs.getInt('id_medico') ?? 0;
    });

    Pantalla.text = 'FinSolicitar32';
    IDMedico.text = "$id_medico";
  }

  @override
  Widget build(BuildContext context) {
    return BuildScreens('${NombreCompletoSession}', '', '',
        'Información Personal', '', _formulario());
  }

  final TextEditingController _controller = TextEditingController();
  int n = 0; // Cantidad de campos a generar
  List<HijosModel> camposData = [];
  List<Widget> campos = [];
  int selectedOption = 0; // Opción seleccionada del radio button

  final TextEditingController _controllerSocios = TextEditingController();
  List<SociosModel> camposDataSocios = [];
  List<Widget> camposSocios = [];
  int selectedOptionSocios = 0; // Opción seleccionada del radio button


  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SubitleCards('Acerca de ti'),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: const Text(
                    "Sabemos que ocupas o has ocupado un cargo público, por lo anterior, por disposición de la Ley en materia de PLD/FT que rige a las entidades del sector financiero debemos recabar mayor información sobre ti. No te preocupes, tenemos la obligación de guardar absoluta confidencialidad de tus datos e información proporcionada, por protección al secreto financiero. ",
                    //textAlign:  TextAlign.center,
                    style: TextStyle(
                        fontSize: 12, color: Color.fromARGB(255, 56, 56, 56)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: const Text(
                    "Fuente de los fondos. ",
                    //textAlign:  TextAlign.center,
                    style: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 56, 56, 56)),
                  ),
                ),
                _Pantalla(),
                _IDMedico(),
                _NombreEmpresa(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _TipoFondo(),
                    ),
                    Expanded(
                      child: _IngresoMensual(),
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
                      "¿Tienes hijos?",
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
                          groupValue: _opcionesConHijos,
                          onChanged: SeleccionadoConHijos,
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
                        groupValue: _opcionesConHijos,
                        onChanged: SeleccionadoConHijos,
                      )),
                    ],
                  ),
                ),
                if (_opcionesConHijos == "Si")
                  ElevatedButton(
                      onPressed: () {
                        mostrarModal(context);
                      },
                      child: Text("Registrar hijos")),
                // if (_siConHijos)
                //   Container(
                //     width: 200,
                //     padding: const EdgeInsets.only(left: 0, bottom: 0),
                //     child: _CuantosHijos(),
                //   ),
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
                      "Estado civil",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 17,
                        //color: Colors.blue
                      ),
                      textScaleFactor: 1,
                    )),
                Container(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: const Text('Soltero',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 126, 126, 126),
                              )),
                          value: "Soltero",
                          groupValue: _opcionesEstadoCivil,
                          onChanged: SeleccionadoEstadoCivil,
                        ),
                      ),
                      
                      Expanded(
                          child: RadioListTile(
                        title: const Text('Casado',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 126, 126, 126),
                            )),
                        value: "Casado",
                        groupValue: _opcionesEstadoCivil,
                        onChanged: SeleccionadoEstadoCivil,
                      )),
                    ],
                  ),
                  
                ),
                if (_casadoEstadoCivil)
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
                                child: _Conyuge_PrimerNombre(),
                              ),
                              Expanded(
                                child: _Conyuge_SegundoNombre(),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _Conyuge_ApellidoPaterno(),
                              ),
                              Expanded(
                                child: _Conyuge_ApellidoMaterno(),
                              ),
                            ],
                          ),
                          _Conyuge_Direccion(),
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
                      "¿Tu madre vive?",
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
                          groupValue: _opcionesLaMadreVive,
                          onChanged: SeleccionadoLaMadreVive,
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
                        groupValue: _opcionesLaMadreVive,
                        onChanged: SeleccionadoLaMadreVive,
                      )),
                    ],
                  ),
                ),
                if (_siLaMadreVive)
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
                                child: _Madre_PrimerNombre(),
                              ),
                              Expanded(
                                child: _Madre_SegundoNombre(),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _Madre_ApellidoPaterno(),
                              ),
                              Expanded(
                                child: _Madre_ApellidoMaterno(),
                              ),
                            ],
                          ),
                          _Madre_Direccion(),
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
                      "¿Tu padre vive?",
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
                          groupValue: _opcionesElPadreVive,
                          onChanged: SeleccionadoElPadreVive,
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
                        groupValue: _opcionesElPadreVive,
                        onChanged: SeleccionadoElPadreVive,
                      )),
                    ],
                  ),
                ),
                if (_siElPadreVive)
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
                                child: _Padre_PrimerNombre(),
                              ),
                              Expanded(
                                child: _Padre_SegundoNombre(),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _Padre_ApellidoPaterno(),
                              ),
                              Expanded(
                                child: _Padre_ApellidoMaterno(),
                              ),
                            ],
                          ),
                          _Padre_Direccion(),
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
                      "¿Mantiene relación a nivel de socio o accionista con alguna empresa nacional o extranjera? ",
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
                          groupValue: _opcionesEsSocioAccionista,
                          onChanged: SeleccionadoEsSocioAccionista,
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
                        groupValue: _opcionesEsSocioAccionista,
                        onChanged: SeleccionadoEsSocioAccionista,
                      )),
                    ],
                  ),
                ),
                /*if (_siEsSocioAccionista)
                  Container(
                      padding: EdgeInsets.only(left: 1.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          //border: Border.all(
                          //color: Colors.blueAccent
                          //)
                          ),
                      child: Column(
                        children: [_CuantasEmpresas()],
                      )),*/
                if (_siEsSocioAccionista)
                  ElevatedButton(
                      onPressed: () {
                        mostrarModalSocios(context);
                      },
                      child: Text("¿Cuántos  socios?")),
                // if (_siConHijos)
                //   Container(
                //     width: 200,
                //     padding: const EdgeInsets.only(left: 0, bottom: 0),
                //     child: _CuantosHijos(),
                //   ),
                
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

  void generarCampos() {
    camposData.clear();
    campos.clear();

    for (int i = 0; i < n; i++) {
      HijosModel nuevoCampo = HijosModel('', '', '', '', '', '', '');
      camposData.add(nuevoCampo);

      campos.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Primer nombre',
                          ),
                          onChanged: (value) {
                            setState(() {
                              nuevoCampo.H_PrimerNombre = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Segundo nombre',
                          ),
                          onChanged: (value) {
                            setState(() {
                              nuevoCampo.H_SegundoNombre = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Primer apellido',
                          ),
                          onChanged: (value) {
                            setState(() {
                              nuevoCampo.H_ApellidoPaterno = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Segundo apellido',
                          ),
                          onChanged: (value) {
                            setState(() {
                              nuevoCampo.H_ApellidoMaterno = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Edad',
                          ),
                          onChanged: (value) {
                            setState(() {
                              nuevoCampo.H_Edad = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Genero',
                          ),
                          onChanged: (value) {
                            setState(() {
                              nuevoCampo.H_Genero = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Dirección',
                          ),
                          onChanged: (value) {
                            setState(() {
                              nuevoCampo.H_Direccion = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                ],  
            ),
          ),
        ),
      );
    }
  }

  void generarCamposSocios() {
    camposDataSocios.clear();
    camposSocios.clear();

    for (int i = 0; i < n; i++) {
      SociosModel nuevoCampoSocios = SociosModel('', '', '', '');
      camposDataSocios.add(nuevoCampoSocios);

      camposSocios.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: ObligatorioSoloTexto,
                          decoration: InputDecoration(
                            labelText: 'Denominación o razón social',
                          ),
                          onChanged: (value) {
                            setState(() {
                              nuevoCampoSocios.H_NombreEsSocioAccionista = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: TextFormField(
                          validator: ObligatorioSoloTexto,
                          decoration: InputDecoration(
                            labelText: '% de Participación',
                          ),
                          onChanged: (value) {
                            setState(() {
                              nuevoCampoSocios.H_ParticipacionEsSocioAccionista = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: ObligatorioSoloTexto,
                          decoration: InputDecoration(
                            labelText: 'Teléfono',
                          ),
                          onChanged: (value) {
                            setState(() { 
                              nuevoCampoSocios.H_TelefonoEsSocioAccionista = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: TextFormField(
                          validator: ObligatorioSoloTextoYNumeros,
                          decoration: InputDecoration(
                            labelText: 'Dirección',
                          ),
                          onChanged: (value) {
                            setState(() {
                              nuevoCampoSocios.H_DireccionEsSocioAccionista = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                ],  
            ),
          ),
        ),
      );
    }
  }


  void mostrarModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Número de hijos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Número de Hijos',
                  ),
                  onChanged: (value) {
                    setState(() {
                      n = int.tryParse(value) ?? 0;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Generar formulario'),
                  onPressed: () {
                    generarCampos();
                    Navigator.of(context).pop();
                    mostrarFormulario(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void mostrarModalSocios(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Número de socios',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _controllerSocios,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Número de socios',
                  ),
                  onChanged: (value) {
                    setState(() {
                      n = int.tryParse(value) ?? 0;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Generar formulario para socios'),
                  onPressed: () {
                    generarCamposSocios();
                    Navigator.of(context).pop();
                    mostrarFormularioSocios(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  var datosHijos = [];
  void guardarDatos() {
    for (var campoData in camposData) {
      //dev.log('Nombre: ${campoData.nombre}, Apellido: ${campoData.apellido}');
      //var lista = campoData.nombre + campoData.apellido;
      var lista = {
        "PrimerNombre":campoData.H_PrimerNombre,
        "SegundoNombre":campoData.H_SegundoNombre,
        "ApellidoPaterno":campoData.H_ApellidoPaterno,
        "ApellidoMaterno":campoData.H_ApellidoMaterno,
        "Edad":campoData.H_Edad,
        "Genero":campoData.H_Genero,
        "Direccion":campoData.H_Direccion,
        "ViveConmigo":''
        };
      setState(() {
        datosHijos.add(lista);
      });
      // Puedes hacer lo que desees con los datos ingresados, como almacenarlos en una base de datos o enviarlos a través de una API.
    }
    /*dev.log("sasd");
    String jsonStringHihos = jsonEncode(datosHijos);
    dev.log(jsonStringHihos.toString());

    print("++++++++");
    print(jsonStringHihos.toString());
    print("++++++++");*/
  }

  var datosSocios = [];
  void guardarDatosSocios() {
    //print("aqui voy");
    for (var campoDataSocios in camposDataSocios) {
      //print("Recorriendo");
      //print("***");
      dev.log('Nombre: ${campoDataSocios.H_NombreEsSocioAccionista}, Apellido: ${campoDataSocios.H_ParticipacionEsSocioAccionista}');
      //var lista = campoData.nombre + campoData.apellido;
      var listaSocios = {
        "NombreEsSocioAccionista":campoDataSocios.H_NombreEsSocioAccionista,
        "ParticipacionEsSocioAccionista":campoDataSocios.H_ParticipacionEsSocioAccionista,
        "TelefonoEsSocioAccionista":campoDataSocios.H_TelefonoEsSocioAccionista,
        "DireccionEsSocioAccionista":campoDataSocios.H_DireccionEsSocioAccionista
        };
      setState(() {
        datosSocios.add(listaSocios);
      });
      // Puedes hacer lo que desees con los datos ingresados, como almacenarlos en una base de datos o enviarlos a través de una API.
    }
    /*dev.log("sasd");
    String jsonStringHihos = jsonEncode(datosHijos);
    dev.log(jsonStringHihos.toString());

    print("++++++++");
    print(jsonStringHihos.toString());
    print("++++++++");*/
  }

  void mostrarFormulario(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Formulario para hijos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 16.0),
                SingleChildScrollView(
                  child: Column(
                    children: campos,
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Guardar'),
                  onPressed: () {
                    guardarDatos();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void mostrarFormularioSocios(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Formulario para socios',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 16.0),
                SingleChildScrollView(
                  child: Column(
                    children: camposSocios,
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Guardar'),
                  onPressed: () {
                    guardarDatosSocios();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _mostrarModalForm(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    List<String> _nombres = [];
    List<String> _apellidos = [];
    int _numCamposAdicionales = 0;

    void _submitForm() {
      if (_formKey.currentState!.validate()) {
        // Validación exitosa, realizar acciones
        // Puedes acceder a los valores de los campos con _nombres y _apellidos
        // Ejemplo de acción:
        for (int i = 0; i < _nombres.length; i++) {
          var nom = _HPrimerNombre.text[i];
          dev.log(nom);
          dev.log('Nombre ${i + 1}: ${nom[i]}');
          dev.log('Apellido ${i + 1}: ${_apellidos[i]}');
        }
      }
      _HPrimerNombre.clear();
    }

    return await showDialog(
        context: context,
        builder: (context) {
          // bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SizedBox(
                width: double.maxFinite,
                child: Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _nombres.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                TextFormField(
                                  controller: _HPrimerNombre,
                                  decoration:
                                      InputDecoration(labelText: 'Nombre'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Por favor ingresa tu nombre';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _nombres[index] = value!;
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Apellido'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Por favor ingresa tu apellido';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _apellidos[index] = value!;
                                  },
                                ),
                                SizedBox(height: 16.0),
                              ],
                            );
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor ingresa un número';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _numCamposAdicionales = int.parse(value!);
                          },
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              for (int i = 0; i < _numCamposAdicionales; i++) {
                                _nombres.add('');
                                _apellidos.add('');
                              }
                              setState(() {});
                            }
                          },
                          child: Text('Agregar campos'),
                        ),
                        // SizedBox(height: 5.0),
                        // ElevatedButton(
                        //   onPressed: _submitForm,
                        //   child: Text('Enviar'),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              title: Text('cuantos hijos tiene?'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK   '),
                  onTap: _submitForm,
                ),
              ],
            );
          });
        });
  }


  Future<void> _mostrarModalFormSocios(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    List<String> _NombreEsSocioAccionista = [];
    List<String> _apellidos = [];
    int _numCamposAdicionales = 0;

    void _submitFormSocios() {
      if (_formKey.currentState!.validate()) {
        // Validación exitosa, realizar acciones
        // Puedes acceder a los valores de los campos con _nombres y _apellidos
        // Ejemplo de acción:
        for (int i = 0; i < _NombreEsSocioAccionista.length; i++) {
          var nom_Socios = _HNombreEsSocioAccionista.text[i];
          dev.log(nom_Socios);
          dev.log('Nombre ___ ${i + 1}: ${nom_Socios[i]}');
          dev.log('Apellido___ ${i + 1}: ${_apellidos[i]}');
        }
      }
      _HNombreEsSocioAccionista.clear();
    }

    return await showDialog(
        context: context,
        builder: (context) {
          // bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SizedBox(
                width: double.maxFinite,
                child: Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _NombreEsSocioAccionista.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                TextFormField(
                                  controller: _HNombreEsSocioAccionista,
                                  decoration:
                                      InputDecoration(labelText: 'Denominación o razón social '),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Por favor ingresa Denominación o razón social';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _NombreEsSocioAccionista[index] = value!;
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: '% de Participación'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Por favor ingresa t% de Participación';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _apellidos[index] = value!;
                                  },
                                ),
                                SizedBox(height: 16.0),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              title: Text('cuantos hijos tiene?'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK   '),
                  onTap: _submitFormSocios,
                ),
              ],
            );
          });
        });
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

  
  Widget _NombreEmpresa() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioInput,
        keyboardType: TextInputType.text,
        controller: NombreEmpresa,
        decoration: InputDecoration(
            labelText: 'Nombre de la empresa o actividad donde recibe fondos.',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _TipoFondo() {
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
              'Tipo de Fondos',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaTipoFondo.map((item) => DropdownMenuItem<String>(
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
              SelectedListaTipoFondo = value;
            },
            onSaved: (value) {
              SelectedListaTipoFondo = value.toString();
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

////////////////////////////////

  Widget _IngresoMensual() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: IngresoMensual,
        decoration: InputDecoration(
            labelText: 'Ingreso mensual',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _CuantosHijos() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: CuantosHijos,
        decoration: InputDecoration(
            labelText: '¿Cuántos hijos tienes?',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Conyuge_PrimerNombre() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Conyuge_PrimerNombre,
        decoration: InputDecoration(
            labelText: 'Primer nombre',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Conyuge_SegundoNombre() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: SoloTexto,
        keyboardType: TextInputType.text,
        controller: Conyuge_SegundoNombre,
        decoration: InputDecoration(
            labelText: 'Segundo nombre',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Conyuge_ApellidoPaterno() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Conyuge_ApellidoPaterno,
        decoration: InputDecoration(
            labelText: 'Apellido paterno',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Conyuge_ApellidoMaterno() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Conyuge_ApellidoMaterno,
        decoration: InputDecoration(
            labelText: 'Apellido materno',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Conyuge_Direccion() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioInput,
        keyboardType: TextInputType.text,
        controller: Conyuge_Direccion,
        decoration: InputDecoration(
            labelText: 'Dirección',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Madre_PrimerNombre() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Madre_PrimerNombre,
        decoration: InputDecoration(
            labelText: 'Primer nombre',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Madre_SegundoNombre() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: SoloTexto,
        keyboardType: TextInputType.text,
        controller: Madre_SegundoNombre,
        decoration: InputDecoration(
            labelText: 'Segundo nombre',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Madre_ApellidoPaterno() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Madre_ApellidoPaterno,
        decoration: InputDecoration(
            labelText: 'Apellido paterno',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Madre_ApellidoMaterno() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Madre_ApellidoMaterno,
        decoration: InputDecoration(
            labelText: 'Apellido materno',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Madre_Direccion() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioInput,
        keyboardType: TextInputType.text,
        controller: Madre_Direccion,
        decoration: InputDecoration(
            labelText: 'Dirección',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Padre_PrimerNombre() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Padre_PrimerNombre,
        decoration: InputDecoration(
            labelText: 'Primer nombre',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Padre_SegundoNombre() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: SoloTexto,
        keyboardType: TextInputType.text,
        controller: Padre_SegundoNombre,
        decoration: InputDecoration(
            labelText: 'Segundo nombre',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Padre_ApellidoPaterno() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Padre_ApellidoPaterno,
        decoration: InputDecoration(
            labelText: 'Apellido paterno',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Padre_ApellidoMaterno() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Padre_ApellidoMaterno,
        decoration: InputDecoration(
            labelText: 'Apellido materno',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Padre_Direccion() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioInput,
        keyboardType: TextInputType.text,
        controller: Padre_Direccion,
        decoration: InputDecoration(
            labelText: 'Dirección',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _CuantasEmpresas() {
    return Container(
      width: 200,
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: CuantasEmpresas,
        decoration: InputDecoration(
            labelText: '¿En cuantas empresas?',
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
            //var hijos= jsonString;
            //print(datosHijos);
            
            if (_formKey.currentState!.validate()) {
              PantallaRecibe = Pantalla.text;
              IDMedicoRecibe = IDMedico.text;
              

              

              NombreEmpresaRecibe = NombreEmpresa.text;
              //ipoFondoRecibe = TipoFondo.text;

              String? TipoFondoRecibe = SelectedListaTipoFondo;
              if (TipoFondoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El Tipo de Fondos es obligatorio'),
                      );
                    });
              }

              IngresoMensualRecibe = IngresoMensual.text;
              //ConHijosRecibe = ConHijos.text;

              String? ConHijosRecibe = _opcionesConHijos;
              //print(ConHijosRecibe);
              if (ConHijosRecibe == "" || ConHijosRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('¿Tienes hijos?'),
                      );
                    });
              }

              CuantosHijosRecibe = _controller.text;
              var HijosRecibe = datosHijos;
              //EstadoCivilRecibe = EstadoCivil.text;
              /*print("*******");
              print(HijosRecibe);
              print("*******");*/
              String? EstadoCivilRecibe = _opcionesEstadoCivil;
              if (EstadoCivilRecibe == "" || EstadoCivilRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El estado civil es obligatorio'),
                      );
                    });
              }

              Conyuge_PrimerNombreRecibe = Conyuge_PrimerNombre.text;
              Conyuge_SegundoNombreRecibe = Conyuge_SegundoNombre.text;
              Conyuge_ApellidoPaternoRecibe = Conyuge_ApellidoPaterno.text;
              Conyuge_ApellidoMaternoRecibe = Conyuge_ApellidoMaterno.text;
              Conyuge_DireccionRecibe = Conyuge_Direccion.text;
              //LaMadreViveRecibe = LaMadreVive.text;
              String? LaMadreViveRecibe = _opcionesLaMadreVive;
              if (LaMadreViveRecibe == "" || LaMadreViveRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('¿La madre vive?'),
                      );
                    });
              }
              Madre_PrimerNombreRecibe = Madre_PrimerNombre.text;
              Madre_SegundoNombreRecibe = Madre_SegundoNombre.text;
              Madre_ApellidoPaternoRecibe = Madre_ApellidoPaterno.text;
              Madre_ApellidoMaternoRecibe = Madre_ApellidoMaterno.text;
              Madre_DireccionRecibe = Madre_Direccion.text;
              //ElPadreViveRecibe = ElPadreVive.text;
              String? ElPadreViveRecibe = _opcionesElPadreVive;
              if (ElPadreViveRecibe == "" || ElPadreViveRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('¿El padre vive?'),
                      );
                    });
              }
              Padre_PrimerNombreRecibe = Padre_PrimerNombre.text;
              Padre_SegundoNombreRecibe = Padre_SegundoNombre.text;
              Padre_ApellidoPaternoRecibe = Padre_ApellidoPaterno.text;
              Padre_ApellidoMaternoRecibe = Padre_ApellidoMaterno.text;
              Padre_DireccionRecibe = Padre_Direccion.text;

              //EsSocioAccionistaRecibe = EsSocioAccionista.text;
              String? EsSocioAccionistaRecibe = _opcionesEsSocioAccionista;
              if (EsSocioAccionistaRecibe == "" ||
                  EsSocioAccionistaRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                            '¿Mantienes relación a nivel de socio o accionista?'),
                      );
                    });
              }
              CuantasEmpresasRecibe = CuantasEmpresas.text;

              var SociosRecibe = datosSocios;
              
              

              if (PantallaRecibe == "" ||
                  IDMedicoRecibe == "" ||
                  NombreEmpresaRecibe == "" ||
                  TipoFondoRecibe == "" ||
                  IngresoMensualRecibe == "" ||
                  ConHijosRecibe == "" ||
                  EstadoCivilRecibe == "" ||
                  LaMadreViveRecibe == "" ||
                  ElPadreViveRecibe == "" ||
                  EsSocioAccionistaRecibe == "") {
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
                    IDMedicoRecibe,
                    NombreEmpresaRecibe,
                    TipoFondoRecibe,
                    IngresoMensualRecibe,
                    ConHijosRecibe,
                    CuantosHijosRecibe,
                    HijosRecibe,
                    EstadoCivilRecibe,
                    Conyuge_PrimerNombreRecibe,
                    Conyuge_SegundoNombreRecibe,
                    Conyuge_ApellidoPaternoRecibe,
                    Conyuge_ApellidoMaternoRecibe,
                    Conyuge_DireccionRecibe,
                    LaMadreViveRecibe,
                    Madre_PrimerNombreRecibe,
                    Madre_SegundoNombreRecibe,
                    Madre_ApellidoPaternoRecibe,
                    Madre_ApellidoMaternoRecibe,
                    Madre_DireccionRecibe,
                    ElPadreViveRecibe,
                    Padre_PrimerNombreRecibe,
                    Padre_SegundoNombreRecibe,
                    Padre_ApellidoPaternoRecibe,
                    Padre_ApellidoMaternoRecibe,
                    Padre_DireccionRecibe,
                    EsSocioAccionistaRecibe,
                    CuantasEmpresasRecibe,
                    SociosRecibe);
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
              MaterialPageRoute(builder: (context) => FinRegMedico33()));
        },
      ),
    );
  }
}
