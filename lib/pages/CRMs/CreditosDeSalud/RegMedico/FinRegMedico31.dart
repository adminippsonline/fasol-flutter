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

import 'FinRegMedico31.dart';
import 'FinRegMedico32.dart';
import 'FinRegMedico33.dart';

import 'package:intl/intl.dart';

class FinRegMedico31 extends StatefulWidget {
  const FinRegMedico31({super.key});

  @override
  State<FinRegMedico31> createState() => _FinRegMedico31State();
}

class _FinRegMedico31State extends State<FinRegMedico31> {
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
    return MyCustomFormFinRegMedico31();
  }
}

// Create a Form widget.
class MyCustomFormFinRegMedico31 extends StatefulWidget {
  const MyCustomFormFinRegMedico31({super.key});

  @override
  MyCustomFormFinRegMedico31State createState() {
    return MyCustomFormFinRegMedico31State();
  }
}

//enum OpcionesFirmaElectronica { Si, No }
//enum OpcionesCargoPolitico { Si, No }
//enum OpcionesEsConyugue { Si, No }

class MyCustomFormFinRegMedico31State
    extends State<MyCustomFormFinRegMedico31> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  var MasccaraPeriodo = new MaskTextInputFormatter(
      mask: '0000-0000', filter: {"0": RegExp(r'[0-9]')});

  String? _opcionesTipoDePersona;
  bool _personafisicaConActividadTipoDePersona = false;
  bool _personafisicaTipoDePersona = true;

  void SeleccionadoTipoDePersona(value) {
    setState(() {
      _opcionesTipoDePersona = value;
      if (_opcionesTipoDePersona ==
          "Persona Física con actividad empresarial y profesional") {
        _personafisicaConActividadTipoDePersona =
            value == "Persona Física con actividad empresarial y profesional";
        _personafisicaTipoDePersona = false;
      } else {
        //print(_opcionesTipoDePersona);
        //_personafisicaTipoDePersona = true;
        _personafisicaTipoDePersona = value == "Persona física";

        _personafisicaConActividadTipoDePersona = false;
      }
    });
  }

  String? _opcionesOrigenDeLosRecursos;
  bool _especifiqueOrigenDeLosRecursos = false;

  void SeleccionadoOrigenDeLosRecursos(value) {
    setState(() {
      _opcionesOrigenDeLosRecursos = value;
      if (_opcionesOrigenDeLosRecursos == "Otros") {
        _especifiqueOrigenDeLosRecursos = value == "Otros";
      } else {
        _especifiqueOrigenDeLosRecursos = false;
      }
    });
  }

  String? _opcionesFirmaElectronica;
  bool _siFirmaElectronica = false;

  void SeleccionadoFirmaElectronica(value) {
    setState(() {
      print(value);
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
    'Persona Física con actividad empresarial y profesional',
    'Persona física',
  ];
  String? SelectedListaTipoDePersona;

  final List<String> ListaOrigenDeLosRecursos = [
    'Sueldos y honarios',
    'Comercio',
    'Otros'
  ];
  String? SelectedListaOrigenDeLosRecursos;

  final List<String> ListaAntiguedadConsultorioTiempo = ['Años', 'Meses'];
  String? SelectedListaAntiguedadConsultorioTiempo;

  final List<String> ListaDestino = [
    'Gastos en general',
    'Inversión de negocio'
  ];
  String? SelectedListaDestino;

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

  final List<String> ListaProfesion = [
    'Profesión 1',
    'Profesión 2',
  ];
  String? SelectedListaProfesion;

  final List<String> ListaOcupacion = [
    'Ocupación 1',
    'Ocupación 2',
  ];
  String? SelectedListaOcupacion;

  final List<String> ListaActividadEconomica = [
    'Actividad económica 1',
    'Actividad económica 2',
  ];
  String? SelectedListaActividadEconomica;

  final List<String> ListaEspecialidad = [
    'Especialidad 1',
    'Especialidad 2',
  ];
  String? SelectedListaEspecialidad;

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDMedico = TextEditingController();

  final TipoDePersona = TextEditingController();
  final Profesion = TextEditingController();
  final Ocupacion = TextEditingController();
  final ActividadEconomica = TextEditingController();
  final Especialidad = TextEditingController();
  final CedulaProfecional = TextEditingController();
  final CedulaDeEspecialidad = TextEditingController();
  final FirmaElectronica = TextEditingController();
  final NumeroFirmaElectronica = TextEditingController();
  final OrigenDeLosRecursos = TextEditingController();
  final Especifique = TextEditingController();
  final Destino = TextEditingController();
  final NombreDelConsultorio = TextEditingController();
  final NombreConsultorioLaboras = TextEditingController();
  final AntiguedadConsultorio = TextEditingController();
  final AntiguedadConsultorioTiempo = TextEditingController();
  final CP = TextEditingController();
  final Pais = TextEditingController();
  final Ciudad = TextEditingController();
  final Calle = TextEditingController();
  final NumExt = TextEditingController();
  final NumInt = TextEditingController();
  final EntCall = TextEditingController();
  final Estado = TextEditingController();
  final MunDel = TextEditingController();
  final Colonia = TextEditingController();
  final CargoPolitico = TextEditingController();
  final Cargo = TextEditingController();
  final PeriodoDelCargo = TextEditingController();
  final EsConyugue = TextEditingController();
  final PrimerNombre = TextEditingController();
  final SegundoNombre = TextEditingController();
  final ApellidoPaterno = TextEditingController();
  final ApellidoMaterno = TextEditingController();

  String PantallaRecibe = "";
  String IDMedicoRecibe = "";

  String TipoDePersonaRecibe = "";
  String ProfesionRecibe = "";
  String OcupacionRecibe = "";
  String ActividadEconomicaRecibe = "";
  String EspecialidadRecibe = "";
  String CedulaProfecionalRecibe = "";
  String CedulaDeEspecialidadRecibe = "";
  String FirmaElectronicaRecibe = "";
  String NumeroFirmaElectronicaRecibe = "";
  String OrigenDeLosRecursosRecibe = "";
  String EspecifiqueRecibe = "";
  String DestinoRecibe = "";
  String NombreDelConsultorioRecibe = "";
  String NombreConsultorioLaborasRecibe = "";
  String AntiguedadConsultorioRecibe = "";
  String AntiguedadConsultorioTiempoRecibe = "";
  String CPRecibe = "";
  String PaisRecibe = "";
  String CiudadRecibe = "";
  String CalleRecibe = "";
  String NumExtRecibe = "";
  String NumIntRecibe = "";
  String EntCallRecibe = "";
  String EstadoRecibe = "";
  String MunDelRecibe = "";
  String ColoniaRecibe = "";
  String CargoPoliticoRecibe = "";
  String CargoRecibe = "";
  String PeriodoDelCargoRecibe = "";
  String EsConyugueRecibe = "";
  String PrimerNombreRecibe = "";
  String SegundoNombreRecibe = "";
  String ApellidoPaternoRecibe = "";
  String ApellidoMaternoRecibe = "";
  File? imagen = null;

  void Ingresar(
      Pantalla,
      IDMedico,
      TipoDePersona,
      Profesion,
      Ocupacion,
      ActividadEconomica,
      Especialidad,
      CedulaProfecional,
      CedulaDeEspecialidad,
      FirmaElectronica,
      NumeroFirmaElectronica,
      OrigenDeLosRecursos,
      Especifique,
      Destino,
      NombreDelConsultorio,
      NombreConsultorioLaboras,
      AntiguedadConsultorio,
      AntiguedadConsultorioTiempo,
      CP,
      Pais,
      Ciudad,
      Calle,
      NumExt,
      NumInt,
      EntCall,
      Estado,
      MunDel,
      Colonia,
      CargoPolitico,
      Cargo,
      PeriodoDelCargo,
      EsConyugue,
      PrimerNombre,
      SegundoNombre,
      ApellidoPaterno,
      ApellidoMaterno) async {
    // dev.log(Pantalla.toString());
    // dev.log(IDMedico);
    // dev.log(TipoDePersona.toString());
    // dev.log(Profesion.toString());
    // dev.log(Ocupacion.toString());
    // dev.log(ActividadEconomica.toString());
    // dev.log(Especialidad.toString());
    // dev.log(CedulaProfecional.toString());
    // dev.log(CedulaDeEspecialidad.toString());
    // dev.log(FirmaElectronica.toString());
    // dev.log(NumeroFirmaElectronica.toString());
    // dev.log(OrigenDeLosRecursos.toString());
    // dev.log(Especifique.toString());
    // dev.log(Destino.toString());
    // dev.log(NombreDelConsultorio.toString());
    // dev.log(NombreConsultorioLaboras.toString());
    // dev.log(AntiguedadConsultorio.toString());
    // dev.log(AntiguedadConsultorioTiempo.toString());
    // dev.log(CP.toString());
    // dev.log(Pais.toString());
    // dev.log(Ciudad.toString());
    // dev.log(Calle.toString());
    // dev.log(NumExt.toString());
    // dev.log(NumInt.toString());
    // dev.log(EntCall.toString());
    // dev.log(Estado.toString());
    // dev.log(MunDel.toString());
    // dev.log(Colonia.toString());
    // dev.log(CargoPolitico.toString());
    // dev.log(Cargo.toString());
    // dev.log(PeriodoDelCargo.toString());
    // dev.log(EsConyugue.toString());
    // dev.log(PrimerNombre.toString());
    // dev.log(SegundoNombre.toString());
    // dev.log(ApellidoPaterno.toString());
    // dev.log(ApellidoMaterno.toString());
    try {
      if (AntiguedadConsultorioTiempo == "" ||
          AntiguedadConsultorioTiempo == null) {
        AntiguedadConsultorioTiempo = "";
      }

      final req = {
        'Pantalla': Pantalla,
        'id_medico': IDMedico,
        'TipoDePersona': TipoDePersona,
        'Profesion': Profesion,
        'OtraEspecialidad': "",
        'Ocupacion': Ocupacion,
        'ActividadEconomica': ActividadEconomica,
        'Especialidad': Especialidad,
        'CedulaProfecional': CedulaProfecional,
        'CedulaDeEspecialidad': CedulaDeEspecialidad,
        'FirmaElectronica': FirmaElectronica,
        'NumeroFirmaElectronica': NumeroFirmaElectronica,
        'OrigenDeLosRecursos': OrigenDeLosRecursos,
        'Especifique': Especifique,
        'Destino': Destino,
        'NombreDelConsultorio': NombreDelConsultorio,
        'NombreConsultorioLaboras': NombreConsultorioLaboras,
        'AntiguedadConsultorio': AntiguedadConsultorio,
        'AntiguedadConsultorioTiempo': AntiguedadConsultorioTiempo,
        'CP': CP,
        'Pais': Pais,
        'Ciudad': Ciudad,
        'Calle': Calle,
        'NumExt': NumExt,
        'NumInt': NumInt,
        'EntCall': EntCall,
        'Estado': Estado,
        'Colonia': Colonia,
        'MunDel': MunDel,
        'CargoPolitico': CargoPolitico,
        'Cargo': Cargo,
        'PeriodoDelCargo': PeriodoDelCargo,
        'EsConyugue': EsConyugue,
        'PrimerNombre': PrimerNombre,
        'SegundoNombre': SegundoNombre,
        'ApellidoPaterno': ApellidoPaterno,
        'ApellidoMaterno': ApellidoMaterno,
        'CedulaProfesionalArchivo': globalimageUpdate //" "
      };
      //print(req); 
      var url = Uri.https('fasoluciones.mx', 'api/Medico/Agregar');
      var request = await http.MultipartRequest('POST', url);
      request = jsonToFormData(request, req);
      final response = await request.send();

      final responseData = await response.stream.bytesToString();

      var responseString = responseData;
      final datos = json.decode(responseString);
      var status = datos['status'].toString();
      dev.log("datosss");
      dev.log(status.toString());

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
              MaterialPageRoute(builder: (_) => FinRegMedico32()));
          FocusScope.of(context).unfocus();
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => FinRegMedico33()));
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

      // var body = json.encode(bodyEnviar);

      //var bodyData = jsonEncode(bodyEnviar);

      // var response = await http
      //     .post(url,
      //         headers: {
      //           "Content-Type": "application/json",
      //         },
      //         body: body
      //         //  body: {
      //         //   'Pantalla': Pantalla,
      //         //   'id_medico': IDMedico,
      //         //   'TipoDePersona': TipoDePersona,
      //         //   'Profesion': Profesion,
      //         //   'OtraEspecialidad': "",
      //         //   'Ocupacion': Ocupacion,
      //         //   'ActividadEconomica': ActividadEconomica,
      //         //   'Especialidad': Especialidad,
      //         //   'CedulaProfecional': CedulaProfecional,
      //         //   'CedulaDeEspecialidad': CedulaDeEspecialidad,
      //         //   'FirmaElectronica': FirmaElectronica,
      //         //   'NumeroFirmaElectronica': NumeroFirmaElectronica,
      //         //   'OrigenDeLosRecursos': OrigenDeLosRecursos,
      //         //   'Especifique': Especifique,
      //         //   'Destino': Destino,
      //         //   'NombreDelConsultorio': NombreDelConsultorio,
      //         //   'NombreConsultorioLaboras': NombreConsultorioLaboras,
      //         //   'AntiguedadConsultorio': AntiguedadConsultorio,
      //         //   'AntiguedadConsultorioTiempo': AntiguedadConsultorioTiempo,
      //         //   'CP': CP,
      //         //   'Pais': Pais,
      //         //   'Ciudad': Ciudad,
      //         //   'Calle': Calle,
      //         //   'NumExt': NumExt,
      //         //   'NumInt': NumInt,
      //         //   'EntCall': EntCall,
      //         //   'Estado': Estado,
      //         //   'Colonia': Colonia,
      //         //   'MunDel': MunDel,
      //         //   'CargoPolitico': CargoPolitico,
      //         //   'Cargo': Cargo,
      //         //   'PeriodoDelCargo': PeriodoDelCargo,
      //         //   'EsConyugue': EsConyugue,
      //         //   'PrimerNombre': PrimerNombre,
      //         //   'SegundoNombre': SegundoNombre,
      //         //   'ApellidoPaterno': ApellidoPaterno,
      //         //   'ApellidoMaterno': ApellidoMaterno,
      //         //   'CedulaProfesionalArchivo': ""
      //         //   }
      //         )
      //     .timeout(const Duration(seconds: 90));
      // dev.log("llego aqui 111");
      // dev.log(response.statusCode.toString());
      // dev.log(response.body.toString());

      // if (response.body != "0" && response.body != "") {
      //   var Respuesta = jsonDecode(response.body);
      //   print(Respuesta);
      //   String status = Respuesta['status'];
      //   if (status == "OK") {
      //     //print('si existe aqui -----');
      //     showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //             title: Text('Registrado correctamente'),
      //           );
      //         });
      //     if (CargoPolitico == "Si" || EsConyugue == "Si") {
      //       Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (_) => FinRegMedico32()));
      //       FocusScope.of(context).unfocus();
      //     } else {
      //       Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (_) => FinRegMedico33()));
      //       FocusScope.of(context).unfocus();
      //     }
      //   } else {
      //     //print('Error en el registro');
      //     showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //             title: Text('Error en el registro'),
      //           );
      //         });
      //   }
      // } else {
      //   //print('Error en el registro');
      //   showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           title: Text("Error en el registro"),
      //         );
      //       });
      // }
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
      dev.log(e.stackTrace.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error: HTTP:// ${e.toString()}'),
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

  //variable que mostrara las profesiones
  List _opcionesProfesiones = [];
  List _opcionesOcupaciones = [];
  List _opcionesActividadesEconomicas = [];
  List _opcionesEspecialidades = [];

  @override
  void initState() {
    super.initState();
    mostrar_datos();
    obtenerOpciones();
    obtenerOcupacion();
    obtenerActividadesEconomicas();
    obtenerEspecialidades();
  }

  void mostrar_datos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      NombreCompletoSession =
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      id_medico = prefs.getInt('id_medico') ?? 0;
    });

    Pantalla.text = 'FinSolicitar31';
    IDMedico.text = "$id_medico";
  }

  //funcion para obtener profesiones
  Future obtenerOpciones() async {
    final response = await http.get(
        Uri.parse('https://fasoluciones.mx/api/Solicitud/Catalogos/Profesiones'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      dev.log(jsonData.toString());
      setState(() {
        _opcionesProfesiones = jsonData;
      });
    } else {
      throw Exception('Error al obtener las opciones');
    }
  }

  //funcion para obtener ocupaciones
  Future obtenerOcupacion() async {
    final response = await http.get(
        Uri.parse('https://fasoluciones.mx/api/Solicitud/Catalogos/Ocupaciones'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      dev.log(jsonData.toString());
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
      dev.log(jsonData.toString());
      setState(() {
        _opcionesActividadesEconomicas = jsonData;
      });
    } else {
      throw Exception('Error al obtener las opciones');
    }
  }

  Future obtenerEspecialidades() async {
    final response = await http.get(Uri.parse(
        'https://fasoluciones.mx/api/Solicitud/Catalogos/Especialidades'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      dev.log(jsonData.toString());
      setState(() {
        _opcionesEspecialidades = jsonData;
      });
    } else {
      throw Exception('Error al obtener las opciones');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BuildScreens('${NombreCompletoSession}', '', '',
        'Información Personal', '', _formulario());
  }

  String? imagePath;
  var globalimageUpdate = "";
  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //  headerTop("Médicos", 'A cerca de ti'),
                SubitleCards('Acerca de ti'),
                const SizedBox(
                  height: 20,
                ),
                _Pantalla(),
                _IDMedico(),
                _TipoDePersona(),
                _Profesion(),
                _Ocupacion(),
                _ActividadEconomica(),
                _Especialidad(),
                _CedulaProfecional(),
                
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: Text("Cédula Profesional (Archivo)"),
                        onPressed: () async {
                          dev.log("cedula");
                          setState(() {
                            dialog(context);
                          });
                        }),
                  ],
                ),
                imagen == null
                    ? Center()
                    : Text(
                        "${imagen!.path.toString()}",
                        style: TextStyle(color: Colors.black),
                      ),
                _CedulaDeEspecialidad(),      
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
                _OrigenDeLosRecursos(),
                Row(
                  children: <Widget>[
                    if (_especifiqueOrigenDeLosRecursos)
                      Expanded(
                        child: _Especifique(),
                      ),
                    Expanded(
                      child: _Destino(),
                    ),
                  ],
                ),
                if (_personafisicaConActividadTipoDePersona)
                  Container(
                      padding: EdgeInsets.only(left: 1.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          //border: Border.all(
                          //color: Colors.blueAccent
                          //)
                          ),
                      child: _NombreDelConsultorio()),
                if (_personafisicaTipoDePersona)
                  Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 1.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              //border: Border.all(
                              //color: Colors.blueAccent
                              //)
                              ),
                          child: _NombreConsultorioLaboras()),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 1.0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  //border: Border.all(
                                  //color: Colors.blueAccent
                                  //)
                                  ),
                              child: _AntiguedadConsultorio(),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.only(left: 1.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    //border: Border.all(
                                    //color: Colors.blueAccent
                                    //)
                                    ),
                                child: _AntiguedadConsultorioTiempo()),
                          ),
                        ],
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
                      "Domicilio del consultorio",
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
                _Calle(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _NumExt(),
                    ),
                    Expanded(
                      child: _NumInt(),
                    ),
                  ],
                ),
                _EntCall(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _Estado(),
                    ),
                    Expanded(
                      child: _Ciudad(),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _MunDel(),
                    ),
                    Expanded(
                      child: _Colonia(),
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
 
  //ImagePicker picker = ImagePicker();
  final picker = ImagePicker();

  var pickedFile;
  Future<void> dialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Obtener Imagen"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Galeria"),
                    onTap: () async {
                      final ImagePicker _picker = ImagePicker();
                      XFile? _pickedFile = await _picker.pickImage(source: ImageSource.gallery,requestFullMetadata: false);
                      imagePath = _pickedFile!.path;
                      imagen = File(_pickedFile.path);
                      _pickedFile.readAsBytes().then((value) {
                        imagePath = _pickedFile.path;
                      });
                      setState(() {
                        print("aqui estoy en imagen");
                        imagePath = _pickedFile.path;
                        imagen = File(_pickedFile.name);
                        final bytes = File(imagePath!).readAsBytesSync();
                        //dev.log(bytes.toString());
                        globalimageUpdate = base64Encode(bytes);
                      });
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(child: Text("Tomar foto"), 
                    onTap: ()  {},
                  )
                ],
              ),
            ),
          );
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
              SeleccionadoTipoDePersona(value);
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

  /*Widget _Profesion() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Profesion,
        decoration: InputDecoration(
            labelText: 'Profesión',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }*/

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

  // Widget _ActividadEconomica() {
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
  //             'Actividad económica',
  //             style: TextStyle(fontSize: 14),
  //           ),
  //           items:
  //               ListaActividadEconomica.map((item) => DropdownMenuItem<String>(
  //                     value: item,
  //                     child: Text(
  //                       item,
  //                       style: const TextStyle(
  //                         fontSize: 14,
  //                       ),
  //                     ),
  //                   )).toList(),
  //           validator: ObligatorioSelect,
  //           onChanged: (value) {
  //             SelectedListaActividadEconomica = value;
  //           },
  //           onSaved: (value) {
  //             SelectedListaActividadEconomica = value.toString();
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

  /*Widget _Especialidad() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Especialidad,
        decoration: InputDecoration(
            labelText: 'Especialidad',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }*/

  String? _opcionSeleccionadaEspecialidad;
  var dropdownvalueEspecialidad;
  Widget _Especialidad() {
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
            'Especialidad',
            style: TextStyle(fontSize: 12),
          ),
          items: _opcionesEspecialidades.map((item) {
            return DropdownMenuItem(
              value: item['nombreespecialidad'].toString(),
              child: Text(item['nombreespecialidad'].toString()),
            );
          }).toList(),
          buttonStyleData: const ButtonStyleData(
            height: 50,
            padding: EdgeInsets.only(left: 0, right: 9),
          ),
          onChanged: (newVal) {
            setState(() {
              dropdownvalueEspecialidad = newVal;
            });
          },
          value: dropdownvalueEspecialidad,
        ),
      ),
    );
  }

  // Widget _Especialidad() {
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
  //             'Especialidad',
  //             style: TextStyle(fontSize: 14),
  //           ),
  //           items: ListaEspecialidad.map((item) => DropdownMenuItem<String>(
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
  //             SelectedListaEspecialidad = value;
  //           },
  //           onSaved: (value) {
  //             SelectedListaEspecialidad = value.toString();
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
  // Widget _Especialidad() {
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
  //             'Especialidad',
  //             style: TextStyle(fontSize: 14),
  //           ),
  //           items: ListaEspecialidad.map((item) => DropdownMenuItem<String>(
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
  //             SelectedListaEspecialidad = value;
  //           },
  //           onSaved: (value) {
  //             SelectedListaEspecialidad = value.toString();
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

  Widget _CedulaProfecional() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: CedulaProfecional,
        decoration: InputDecoration(
            labelText: 'Cédula profesional',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _CedulaDeEspecialidad() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: CedulaDeEspecialidad,
        decoration: InputDecoration(
            labelText: 'Cédula de especialidad',
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

  Widget _OrigenDeLosRecursos() {
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
              'Origen de los recursos',
              style: TextStyle(fontSize: 14),
            ),
            items:
                ListaOrigenDeLosRecursos.map((item) => DropdownMenuItem<String>(
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
              SelectedListaOrigenDeLosRecursos = value;
              SeleccionadoOrigenDeLosRecursos(value);
            },
            onSaved: (value) {
              SelectedListaOrigenDeLosRecursos = value.toString();
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

  Widget _Especifique() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Especifique,
        decoration: InputDecoration(
            labelText: 'Especifique',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Destino() {
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
              'Destino',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaDestino.map((item) => DropdownMenuItem<String>(
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
              SelectedListaDestino = value;
            },
            onSaved: (value) {
              SelectedListaDestino = value.toString();
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

  Widget _NombreDelConsultorio() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioInput,
        keyboardType: TextInputType.text,
        controller: NombreDelConsultorio,
        decoration: InputDecoration(
            labelText: 'Nombre del consultorio',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _NombreConsultorioLaboras() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioInput,
        keyboardType: TextInputType.text,
        controller: NombreConsultorioLaboras,
        decoration: InputDecoration(
            labelText: 'Nombre del consultorio donde laboras',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _AntiguedadConsultorio() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: AntiguedadConsultorio,
        maxLength: 2,
        decoration: InputDecoration(
            labelText: 'Antigüedad',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: '',
            counterText: ''),
      ),
    );
  }

  Widget _AntiguedadConsultorioTiempo() {
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
              'Antiguedad',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaAntiguedadConsultorioTiempo.map(
                (item) => DropdownMenuItem<String>(
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
              SelectedListaAntiguedadConsultorioTiempo = value;
            },
            onSaved: (value) {
              SelectedListaAntiguedadConsultorioTiempo = value.toString();
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
    dev.log("t");
    final req = {"CP": codigo};
    var url = Uri.parse('https://fasoluciones.mx/api/Solicitud/Catalogos/CP/');

    var request = await http.MultipartRequest('POST', url);
    request = jsonToFormData(request, req);

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData =
          await response.stream.bytesToString(); //response.stream.toBytes();
      //dev.log(responseData.toString());

      var responseString = responseData;
      final dat = json.decode(responseString);
      dev.log("adata");
      dev.log(dat.toString());
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
            dev.log("algo");
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
            dev.log(dropdownvalueOcupacion.toString());
            if (_formKey.currentState!.validate()) {
              PantallaRecibe = Pantalla.text;
              IDMedicoRecibe = IDMedico.text;

              String? TipoDePersonaRecibe = SelectedListaTipoDePersona;
              print(TipoDePersonaRecibe);
              if (TipoDePersonaRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El tipo de persona es obligatorio'),
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
              dev.log(ProfesionRecibe);
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
              print(OcupacionRecibe);
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
              print(ActividadEconomicaRecibe);
              String? EspecialidadRecibe = dropdownvalueEspecialidad.toString();
              dev.log("esp");
              dev.log(EspecialidadRecibe);
              if (EspecialidadRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La especialidad es obligatoria'),
                      );
                    });
              }
              print(EspecialidadRecibe);

              CedulaProfecionalRecibe = CedulaProfecional.text;
              CedulaDeEspecialidadRecibe = CedulaDeEspecialidad.text;

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
                    FirmaElectronicaRecibe="";
              }

              NumeroFirmaElectronicaRecibe = NumeroFirmaElectronica.text;

              String? OrigenDeLosRecursosRecibe =
                  SelectedListaOrigenDeLosRecursos;
              print(OrigenDeLosRecursosRecibe);
              if (OrigenDeLosRecursosRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title:
                            Text('El origen de los recusrsos es obligatorio'),
                      );
                    });
              }
              EspecifiqueRecibe = Especifique.text;
              String? DestinoRecibe = SelectedListaDestino;
              print(DestinoRecibe);

              if (OrigenDeLosRecursosRecibe == "Otros") {
                if (DestinoRecibe == "") {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Definir otros es obligatorio'),
                        );
                      });
                }
              }
              NombreDelConsultorioRecibe = NombreDelConsultorio.text;
              NombreConsultorioLaborasRecibe = NombreConsultorioLaboras.text;
              AntiguedadConsultorioRecibe = AntiguedadConsultorio.text;
              String? AntiguedadConsultorioTiempoRecibe =
                  SelectedListaAntiguedadConsultorioTiempo;
              if (AntiguedadConsultorioTiempoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La antiguedad es obligatoria'),
                      );
                    });
              }
              CPRecibe = CP.text;

              String? PaisRecibe = SelectedListaPais;
              print(PaisRecibe);
              if (PaisRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El país es obligatorio'),
                      );
                    });
              }

              CiudadRecibe = Ciudad.text;
              CalleRecibe = Calle.text;
              NumExtRecibe = NumExt.text;
              NumIntRecibe = NumInt.text;
              EntCallRecibe = EntCall.text;
              String? EstadoRecibe = Estado.text;
              if (EstadoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El estado es obligatorio'),
                      );
                    });
              }
              MunDelRecibe = MunDel.text;
              String? CargoPoliticoRecibe = _opcionesCargoPolitico;
              if (CargoPoliticoRecibe == "" || CargoPoliticoRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La opción cargo político es obligatoria'),
                      );
                    });
                    CargoPoliticoRecibe="";
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
                    EsConyugueRecibe="";
              }
              PrimerNombreRecibe = PrimerNombre.text;
              SegundoNombreRecibe = SegundoNombre.text;
              ApellidoPaternoRecibe = ApellidoPaterno.text;
              ApellidoMaternoRecibe = ApellidoMaterno.text;

              String? ColoniaRecibe = _selectedColony;

              print(ColoniaRecibe);
              if (ColoniaRecibe == "" || ColoniaRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La colonia es obligatoria'),
                      );
                    });
                ColoniaRecibe="";    
              }

              if (PantallaRecibe == "" ||
                  IDMedicoRecibe == "" ||
                  TipoDePersonaRecibe == "" ||
                  ProfesionRecibe == "" ||
                  OcupacionRecibe == "" ||
                  ActividadEconomicaRecibe == "" ||
                  EspecialidadRecibe == "" ||
                  CedulaProfecionalRecibe == "" ||
                  CedulaDeEspecialidadRecibe == "" ||
                  FirmaElectronicaRecibe == "" ||
                  FirmaElectronicaRecibe == null ||
                  OrigenDeLosRecursosRecibe == "" ||
                  DestinoRecibe == "" ||
                  CPRecibe == "" ||
                  PaisRecibe == "" ||
                  // CiudadRecibe == "" ||
                  CalleRecibe == "" ||
                  NumExtRecibe == "" ||
                  //NumIntRecibe == "" ||
                  EntCallRecibe == "" ||
                  EstadoRecibe == "" ||
                  MunDelRecibe == "" ||
                  ColoniaRecibe == "" ||
                  ColoniaRecibe == null ||
                  CargoPoliticoRecibe == "" || CargoPoliticoRecibe == null ||
                  EsConyugueRecibe == "" || EsConyugueRecibe == null) {
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
                    TipoDePersonaRecibe,
                    ProfesionRecibe,
                    OcupacionRecibe,
                    ActividadEconomicaRecibe,
                    EspecialidadRecibe,
                    CedulaProfecionalRecibe,
                    CedulaDeEspecialidadRecibe,
                    FirmaElectronicaRecibe,
                    NumeroFirmaElectronicaRecibe,
                    OrigenDeLosRecursosRecibe,
                    EspecifiqueRecibe,
                    DestinoRecibe,
                    NombreDelConsultorioRecibe,
                    NombreConsultorioLaborasRecibe,
                    AntiguedadConsultorioRecibe,
                    AntiguedadConsultorioTiempoRecibe,
                    CPRecibe,
                    PaisRecibe,
                    CiudadRecibe,
                    CalleRecibe,
                    NumExtRecibe,
                    NumIntRecibe,
                    EntCallRecibe,
                    EstadoRecibe,
                    MunDelRecibe,
                    ColoniaRecibe,
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
              MaterialPageRoute(builder: (context) => FinRegMedico32()));
        },
      ),
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
