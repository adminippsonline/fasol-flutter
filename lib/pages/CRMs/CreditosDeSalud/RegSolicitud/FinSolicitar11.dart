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

import 'FinSolicitar12.dart';

import 'package:intl/intl.dart';

//PAra validar
//void main() => runApp(const FinSolicitar11());
//enum OpcionesGenero { Masculino, Femenino }

class FinSolicitar11 extends StatefulWidget {
  const FinSolicitar11({super.key});

  @override
  State<FinSolicitar11> createState() => _FinSolicitar11State();
}

class _FinSolicitar11State extends State<FinSolicitar11> {
  //se usa para mostrar los datos del estado
  int id_solicitud = 0;
  int id_credito = 0;
  String NombreCompletoSession = "Información personal";
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
      id_credito = prefs.getInt('id_credito') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomFormFinSolicitar11();
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar11 extends StatefulWidget {
  const MyCustomFormFinSolicitar11({super.key});

  @override
  MyCustomFormFinSolicitar11State createState() {
    return MyCustomFormFinSolicitar11State();
  }
}

class MyCustomFormFinSolicitar11State
    extends State<MyCustomFormFinSolicitar11> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  String? OpcionesGenero;

  final List<String> ListaEstadoCivil = [
    'Soltero',
    'Divorciado',
    'Union libre',
    'Casado',
    'Viudo'
  ];
  String? SelectedListaEstadoCivil;

  final List<String> ListaNivelAcademico = [
    'Profesional',
    'Maestría',
    'Doctorado'
  ];
  String? SelectedListaNivelAcademico;

  final List<String> ListaEstadoDeNacimiento = [
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
  String? SelectedListaEstadoDeNacimiento;

  final List<String> ListaPaisDeNacimiento = [
    'México',
  ];
  String? SelectedListaPaisDeNacimiento;

  final List<String> ListaNacionalidad = [
    'Mexicana',
  ];
  String? SelectedListaNacionalidad;

  TextEditingController FechaDeNacimientoInput = TextEditingController();
  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDLR = TextEditingController();
  final IDInfo = TextEditingController();

  final PrimerNombre = TextEditingController();
  final SegundoNombre = TextEditingController();
  final PrimerApellido = TextEditingController();
  final SegundoApellido = TextEditingController();
  final Genero = TextEditingController();
  final FechaDeNacimiento = TextEditingController();
  final PaisDeNacimiento = TextEditingController();
  final EstadoDeNacimiento = TextEditingController();
  final Nacionalidad = TextEditingController();
  final CURP = TextEditingController();
  final RFC = TextEditingController();
  final EstadoCivil = TextEditingController();
  final NivelAcademico = TextEditingController();

  String PantallaRecibe = "";
  String IDLRRecibe = "";
  String IDInfoRecibe = "";

  String PrimerNombreRecibe = "";
  String SegundoNombreRecibe = "";
  String PrimerApellidoRecibe = "";
  String SegundoApellidoRecibe = "";
  String GeneroRecibe = "";
  String FechaDeNacimientoRecibe = "";
  String PaisDeNacimientoRecibe = "";
  String EstadoDeNacimientoRecibe = "";
  String NacionalidadRecibe = "";
  String CURPRecibe = "";
  String RFCRecibe = "";
  String EstadoCivilRecibe = "";
  String NivelAcademicoRecibe = "";

  void Ingresar(
      Pantalla,
      IDLR,
      IDInfo,
      PrimerNombre,
      SegundoNombre,
      PrimerApellido,
      SegundoApellido,
      Genero,
      FechaDeNacimiento,
      PaisDeNacimiento,
      EstadoDeNacimiento,
      Nacionalidad,
      CURP,
      RFC,
      EstadoCivil,
      NivelAcademico) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');
      var response = await http.post(url, body: {
        'Pantalla': Pantalla,
        'id_solicitud': IDLR,
        'id_credito': IDInfo,
        'PrimerNombre': PrimerNombre,
        'SegundoNombre': SegundoNombre,
        'PrimerApellido': PrimerApellido,
        'SegundoApellido': SegundoApellido,
        'FechaDeNacimiento': FechaDeNacimiento,
        'Genero': Genero,
        'PaisDeNacimiento': PaisDeNacimiento,
        'EstadoDeNacimiento': EstadoDeNacimiento,
        'Nacionalidad': Nacionalidad,
        'CURP': CURP,
        'RFC': RFC,
        'EstadoCivil': EstadoCivil,
        'NivelAcademico': NivelAcademico,
      }).timeout(const Duration(seconds: 90));
      //print("llego aqui 111");
      //print(response.body);

      if (response.body != "0" && response.body != "") {
        var Respuesta = jsonDecode(response.body);
        //print(Respuesta);
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
          guardar_datos(PrimerNombre);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => FinSolicitar12()));
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

  //Esto es iun metodo
  //se usa para guarar dtos es tipo sesiones
  Future<void> guardar_datos(NombreCompletoSession) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('NombreCompletoSession', NombreCompletoSession);
  }

  //Esto es un metodo
  //se usa para mostrar los datos del estado
  int id_solicitud = 0;
  int id_credito = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String TelefonoSession = "";
  /*Future<void> mostrar_datos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id_solicitud = await prefs.getString('id_solicitud');
    var NombreCompletoSession = await prefs.getString('NombreCompletoSession');
    var CorreoSession = await prefs.getString('CorreoSession');
    var TelefonoSession = await prefs.getString('TelefonoSession');
  }

  //Pra pintar datos initState() es un estado es como sesiones valida que haya sesiones, si exite te redirecciona al ligin
  @override
  void initState() {
    super.initState();
    mostrar_datos();
  }*/

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

    Pantalla.text = 'FinSolicitar11';
    IDLR.text = "$id_solicitud";
    IDInfo.text = "$id_credito";
  }

  @override
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
                    SubitleCards("Información personal"),
                    SizedBox(
                      height: 20,
                    ),
                    _Pantalla(),
                    _IDLR(),
                    _IDInfo(),
                    _PrimerNombre(),
                    _SegundoNombre(),
                    _PrimerApellido(),
                    _SegundoApellido(),
                    
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
                          "Genero",
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
                                contentPadding: EdgeInsets.all(0.0),
                                value: "Masculino",
                                groupValue: OpcionesGenero,
                                //dense: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                title: Text("Masculino"),
                                onChanged: (val) {
                                  setState(() {
                                    OpcionesGenero = val;
                                  });
                                }),
                          ),
                          Expanded(
                              child: RadioListTile(
                                  contentPadding: EdgeInsets.all(0.0),
                                  value: "Femenino",
                                  groupValue: OpcionesGenero,
                                  //dense: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  title: Text("Femenino"),
                                  onChanged: (val) {
                                    setState(() {
                                      OpcionesGenero = val;
                                    });
                                  })),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _FechaDeNacimiento(),
                    _PaisDeNacimiento(),
                    _EstadoDeNacimiento(),
                    _Nacionalidad(),
                    _CURP(),
                    _RFC(),
                    _EstadoCivil(),
                    _NivelAcademico(),
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

  /*String? _validarGenero(String? value) {
    if (value != null && value.isEmpty) {
      return "Campo obligatorio";
    }
    return null;
  }*/

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

  Widget _PrimerApellido() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: PrimerApellido,
        decoration: InputDecoration(
            labelText: 'Apellido paterno',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _SegundoApellido() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: SegundoApellido,
        decoration: InputDecoration(
            labelText: 'Apellido materno',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _FechaDeNacimiento() {
    return Container(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          validator: ObligatorioFechaDeNacimiento,
          controller:
              FechaDeNacimientoInput, //editing controller of this TextField
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_today), //icon of text field
              labelText: "Fecha de nacimiento",
              border: OutlineInputBorder(),
              isDense: false,
              contentPadding: EdgeInsets.all(10),
              hintText: '' //label text of field
              ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1940),
                lastDate: DateTime.now());

            if (pickedDate != null) {
              //print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              validarEdad(pickedDate);
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);

              //print(formattedDate); //formatted date output using intl package =>  2021-03-16
              //you can implement different kind of Date Format here according to your requirement
              setState(() {
                //print(formattedDate);
                FechaDeNacimientoInput.text =
                    formattedDate; //set output date to TextField value.
              });
            } else {
              //print("Date is not selected");
            }
          },
        ));
  }

  bool isMayordeEdad = false;
  void validarEdad(DateTime fechaNacimiento) {
    bool esMayorDeEdad =
        DateTime.now().difference(fechaNacimiento).inDays >= 365 * 18;

    if (esMayorDeEdad) {
      setState(() {
        isMayordeEdad = true;
      });
      dev.log("El usuario es mayor de edad");
    } else {
      isMayordeEdad = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('El usuario es menor de edad'),
            );
          });
      dev.log("El usuario es menor de edad");
    }
  } 

  Widget _PaisDeNacimiento() {
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
              'Pais de nacimiento',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaPaisDeNacimiento.map((item) => DropdownMenuItem<String>(
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
              //Do something when changing the item if you want.
              SelectedListaPaisDeNacimiento = value;
            },
            onSaved: (value) {
              SelectedListaPaisDeNacimiento = value.toString();
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

  Widget _EstadoDeNacimiento() {
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
              'Estado de nacimiento',
              style: TextStyle(fontSize: 14),
            ),
            items:
                ListaEstadoDeNacimiento.map((item) => DropdownMenuItem<String>(
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
              //Do something when changing the item if you want.
              SelectedListaEstadoDeNacimiento = value;
            },
            onSaved: (value) {
              SelectedListaEstadoDeNacimiento = value.toString();
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

  Widget _Nacionalidad() {
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
              'Nacionalidad',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaNacionalidad.map((item) => DropdownMenuItem<String>(
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
              //Do something when changing the item if you want.
              SelectedListaNacionalidad = value;
            },
            onSaved: (value) {
              SelectedListaNacionalidad = value.toString();
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

  Widget _CURP() {  
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        inputFormatters: [UpperCaseTextFormatter()],
        textCapitalization: TextCapitalization.characters,
        validator: ObligatorioCURP,
        keyboardType: TextInputType.text,
        controller: CURP,
        maxLength: 18,
        decoration: InputDecoration(
            labelText: 'CURP',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _RFC() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        inputFormatters: [UpperCaseTextFormatter()],
        textCapitalization: TextCapitalization.characters,
        validator: ObligatorioRFC,
        keyboardType: TextInputType.text,
        controller: RFC,
        maxLength: 13,
        decoration: InputDecoration(
            labelText: 'RFC',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _EstadoCivil() {
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
              'Estado civil',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaEstadoCivil.map((item) => DropdownMenuItem<String>(
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
              //Do something when changing the item if you want.
              SelectedListaEstadoCivil = value;
            },
            onSaved: (value) {
              SelectedListaEstadoCivil = value.toString();
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

  Widget _NivelAcademico() {
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
              'Nivel academico',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaNivelAcademico.map((item) => DropdownMenuItem<String>(
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
              //Do something when changing the item if you want.
              SelectedListaNivelAcademico = value;
            },
            onSaved: (value) {
              SelectedListaNivelAcademico = value.toString();
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

              PrimerNombreRecibe = PrimerNombre.text;
              SegundoNombreRecibe = SegundoNombre.text;
              PrimerApellidoRecibe = PrimerApellido.text;
              SegundoApellidoRecibe = SegundoApellido.text;
              String? GeneroRecibe = OpcionesGenero;
              print(GeneroRecibe);
              if (GeneroRecibe == "" || GeneroRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El genero es obligatorio'),
                      );
                    });
              }
              FechaDeNacimientoRecibe = FechaDeNacimientoInput.text;
              if (FechaDeNacimientoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La fecha de nacimiento es obligatoria'),
                      );
                    });
              }

              String? PaisDeNacimientoRecibe = SelectedListaPaisDeNacimiento;
              if (PaisDeNacimientoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El pais de nacimiento es obligatorio'),
                      );
                    });
              }

              String? EstadoDeNacimientoRecibe =
                  SelectedListaEstadoDeNacimiento;
              if (EstadoDeNacimientoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El estado de nacimiento es obligatorio'),
                      );
                    });
              }
              //NacionalidadRecibe = Nacionalidad.text;

              String? NacionalidadRecibe = SelectedListaNacionalidad;
              if (NacionalidadRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La nacionalidad es obligatoria'),
                      );
                    });
              }
              CURPRecibe = CURP.text;
              RFCRecibe = RFC.text;
              String? EstadoCivilRecibe = SelectedListaEstadoCivil;
              if (EstadoCivilRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El estado estado civil es obligatorio'),
                      );
                    });
              }
              String? NivelAcademicoRecibe = SelectedListaNivelAcademico;
              if (NivelAcademicoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El nivel academico es obligatorio'),
                      );
                    });
              }
print(PantallaRecibe);
print(IDLRRecibe);
print(IDInfoRecibe);
print(PrimerNombreRecibe);
print(PrimerApellidoRecibe);
print(SegundoApellidoRecibe);
print(GeneroRecibe);
print(GeneroRecibe);
print(FechaDeNacimientoRecibe);
print(PaisDeNacimientoRecibe);
print(EstadoDeNacimientoRecibe);
print(NacionalidadRecibe);
print(CURPRecibe);
print(RFCRecibe);
print(EstadoCivilRecibe);
print(NivelAcademicoRecibe);

              if (PantallaRecibe == "" ||
                  IDLRRecibe == "" ||
                  IDInfoRecibe == "" ||
                  PrimerNombreRecibe == "" ||
                  PrimerApellidoRecibe == "" ||
                  SegundoApellidoRecibe == "" ||
                  GeneroRecibe == "" ||
                  GeneroRecibe == null ||
                  FechaDeNacimientoRecibe == "" ||
                  PaisDeNacimientoRecibe == "" ||
                  EstadoDeNacimientoRecibe == "" ||
                  NacionalidadRecibe == "" ||
                  CURPRecibe == "" ||
                  RFCRecibe == "" ||
                  EstadoCivilRecibe == "" ||
                  NivelAcademicoRecibe == "") {
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
                    PrimerNombreRecibe,
                    SegundoNombreRecibe,
                    PrimerApellidoRecibe,
                    SegundoApellidoRecibe,
                    GeneroRecibe,
                    FechaDeNacimientoRecibe,
                    PaisDeNacimientoRecibe,
                    EstadoDeNacimientoRecibe,
                    NacionalidadRecibe,
                    CURPRecibe,
                    RFCRecibe,
                    EstadoCivilRecibe,
                    NivelAcademicoRecibe);
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
              MaterialPageRoute(builder: (context) => FinSolicitar12()));
        },
      ),
    );
  }
}
