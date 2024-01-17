import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import '../Includes/widgets/text.dart';
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

import 'FinClinicas6.dart';

import 'package:intl/intl.dart';

//PAra validar
//void main() => runApp(const FinClinicas5());
//enum OpcionesGenero { Masculino, Femenino }

class FinClinicas5 extends StatefulWidget {
  const FinClinicas5({super.key});

  @override
  State<FinClinicas5> createState() => _FinClinicas5State();
}

class _FinClinicas5State extends State<FinClinicas5> {
  //se usa para mostrar los datos del estado
  int id_clinica = 0;
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
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      id_clinica = prefs.getInt('id_clinica') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomFormFinClinicas5();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(NombreCompletoSession),
    //   ),
    //   drawer: MenuLateralPage(""),
    //   bottomNavigationBar: MenuFooterPage(),
    //   body: const MyCustomFormFinClinicas5(),
    // );
  }
}

// Create a Form widget.
class MyCustomFormFinClinicas5 extends StatefulWidget {
  const MyCustomFormFinClinicas5({super.key});

  @override
  MyCustomFormFinClinicas5State createState() {
    return MyCustomFormFinClinicas5State();
  }
}

class MyCustomFormFinClinicas5State extends State<MyCustomFormFinClinicas5> {
  //el fomrKey para formulario
  var MasccaraCelular = new MaskTextInputFormatter(
      mask: '## #### ####', filter: {"#": RegExp(r'[0-9]')});

  final _formKey = GlobalKey<FormState>();

  String? OpcionesGenero;

  final List<String> ListaNivelAcademico = [
    'Profesional',
    'Maestría',
    'Doctorado'
  ];
  String? SelectedListaNivelAcademico;

  final List<String> ListaEstadoCivil = [
    'Soltero',
    'Divorciado',
    'Unión libre',
    'Casado',
    'Viudo'
  ];
  String? SelectedListaEstadoCivil;

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
  final IDClinica = TextEditingController();

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
  final Profesion = TextEditingController();
  final NivelAcademico = TextEditingController();
  final EstadoCivil = TextEditingController();
  final Correo = TextEditingController();
  final Celular = TextEditingController();

  String PantallaRecibe = "";
  String IDClinicaRecibe = "";

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
  String ProfesionRecibe = "";
  String NivelAcademicoRecibe = "";
  String EstadoCivilRecibe = "";
  String CorreoRecibe = "";
  String CelularRecibe = "";

  void Ingresar(
      Pantalla,
      IDClinica,
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
      Profesion,
      NivelAcademico,
      EstadoCivil,
      Correo,
      Celular) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Clinica/Agregar');
      var response = await http.post(url, body: {
        'Pantalla': Pantalla,
        'id_clinica': IDClinica,
        'PrimerNombre': PrimerNombre,
        'SegundoNombre': SegundoNombre,
        'ApellidoPaterno': PrimerApellido,
        'ApellidoMaterno': SegundoApellido,
        'Genero': Genero,
        'FechaNacimiento': FechaDeNacimiento,
        'PaisDeNacimiento': PaisDeNacimiento,
        'EstadoDeNacimiento': EstadoDeNacimiento,
        'Nacionalidad': Nacionalidad,
        'CURP': CURP,
        'RFC': RFC,
        'Profesion': Profesion,
        'NivelAcademico': NivelAcademico,
        'EstadoCivil': EstadoCivil,
        'Correo': Correo,
        'Celular': Celular
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
              MaterialPageRoute(builder: (_) => FinClinicas6()));
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
  int id_clinica = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String TelefonoSession = "";
  /*Future<void> mostrar_datos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id_clinica = await prefs.getString('id_clinica');
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
  List _opcionesProfesiones = [];

  @override
  void initState() {
    super.initState();
    mostrar_datos();
    obtenerProfesiones();
  }

  //funcion para obtener profesiones
  Future obtenerProfesiones() async {
    final response = await http.get(Uri.parse(
        'https://fasoluciones.mx/api/Solicitud/Catalogos/Profesiones'));

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

  void mostrar_datos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      NombreCompletoSession =
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      id_clinica = prefs.getInt('id_clinica') ?? 0;
    });

    Pantalla.text = 'FinClinicas5';
    IDClinica.text = "$id_clinica";
  }

  @override
  Widget build(BuildContext context) {
    return BuildScreens(
        'Clínica', '', '', 'Datos de la clínica', '', _formulario());
  }

  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SubitleCards('Datos del representante legal'),
                SizedBox(
                  height: 20,
                ),
                _Pantalla(),
                _IDClinica(),
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
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _EstadoDeNacimiento(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _Nacionalidad(),
                    ),
                  ],
                ),
                /*SizedBox(
                      height: 20,
                    ),*/
                _CURP(),
                _RFC(),
                _Profesion(),
                _NivelAcademico(),
                _EstadoCivil(),
                _Correo(),
                _Celular(),
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

  var dropdownvalue;
  Widget _Profesion() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
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

  Widget _Correo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioCorreo,
        keyboardType: TextInputType.emailAddress,
        controller: Correo,
        decoration: InputDecoration(
            labelText: 'correo',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Celular() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        inputFormatters: [MasccaraCelular],
        validator: ObligatorioCelular,
        keyboardType: TextInputType.phone,
        controller: Celular,
        maxLength: 12,
        decoration: InputDecoration(
            labelText: 'Celular',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: '00 0000 0000',
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
              IDClinicaRecibe = IDClinica.text;

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
              ProfesionRecibe = dropdownvalue;

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

              String? EstadoCivilRecibe = SelectedListaEstadoCivil;
              if (EstadoCivilRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El estado civil es obligatorio'),
                      );
                    });
              }

              CorreoRecibe = Correo.text;
              CelularRecibe = Celular.text;

              if (PantallaRecibe == "" ||
                  IDClinicaRecibe == "" ||
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
                  ProfesionRecibe == "" ||
                  NivelAcademicoRecibe == "" ||
                  EstadoCivilRecibe == "" ||
                  CorreoRecibe == "" ||
                  CelularRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else if (isMayordeEdad == false) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: es un usuario menor edad'),
                      );
                    });
              } else {
                Ingresar(
                    PantallaRecibe,
                    IDClinicaRecibe,
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
                    ProfesionRecibe,
                    NivelAcademicoRecibe,
                    EstadoCivilRecibe,
                    CorreoRecibe,
                    CelularRecibe);
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
              context, MaterialPageRoute(builder: (context) => FinClinicas6()));
        },
      ),
    );
  }
}
