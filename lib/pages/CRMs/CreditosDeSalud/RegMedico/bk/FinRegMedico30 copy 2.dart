import 'package:flutter/material.dart';

import '../../headers.dart';
import '../../menu_lateral.dart';
import '../../menu_footer.dart';
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

import '../FinRegMedico30_1.dart';

import 'package:intl/intl.dart';

//PAra validar
//void main() => runApp(const FinRegMedico30());

class FinRegMedico30 extends StatefulWidget {
  const FinRegMedico30({super.key});

  @override
  State<FinRegMedico30> createState() => _FinRegMedico30State();
}

class _FinRegMedico30State extends State<FinRegMedico30> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información personal'),
      ),
      drawer: MenuLateralPage(),
      bottomNavigationBar: MenuFooterPage(),
      body: const MyCustomFormFinRegMedico30(),
    );
  }
}

// Create a Form widget.
class MyCustomFormFinRegMedico30 extends StatefulWidget {
  const MyCustomFormFinRegMedico30({super.key});

  @override
  MyCustomFormFinRegMedico30State createState() {
    return MyCustomFormFinRegMedico30State();
  }
}

class MyCustomFormFinRegMedico30State
    extends State<MyCustomFormFinRegMedico30> {
  TextEditingController dateinput = TextEditingController();
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();
  //Los controladores para los input
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
      var url = Uri.https('fasoluciones.mx', 'ApiApp/Medico/Actualizar.php');
      var response = await http.post(url, body: {
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
      //print(response.body);

      if (response.body == "Exito") {
        print('si existe');
        //guardar_datos("10", "enrique", "tel:34543", "Direccion:antonio oe");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => FinRegMedico30_1()));
        FocusScope.of(context).unfocus();
      } else {
        //print('Error de actualizacion');
      }
    } on TimeoutException catch (e) {
      //print('Tardo muco la conexion');
    } on Error catch (e) {
      //print('http error');
    }
  }

  //Esto es iun metodo
  //se usa para guarar dtos es tipo sesiones
  /*Future<void> guardar_datos(
      id_medico, NombreCompletoSession, CorreoSession, TelefonoSession) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id_medico', id_medico);
    await prefs.setString('NombreCompletoSession', NombreCompletoSession);
    await prefs.setString('CorreoSession', CorreoSession);
    await prefs.setString('TelefonoSession', TelefonoSession);
  }*/

  //Esto es un metodo
  //se usa para mostrar los datos del estado
  /*String id_medico = "";
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String TelefonoSession = "";
  Future<void> mostrar_datos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id_medico = await prefs.getString('id_medico');
    var NombreCompletoSession = await prefs.getString('NombreCompletoSession');
    var CorreoSession = await prefs.getString('CorreoSession');
    var TelefonoSession = await prefs.getString('TelefonoSession');
    if (id_medico != "") {
      if (id_medico != null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => PerfilMed()));
        FocusScope.of(context).unfocus();
      }
    }
  }*/

  //Pra pintar datos initState() es un estado es como sesiones valida que haya sesiones, si exite te redirecciona al ligin
  /*@override
  void initState() {
    super.initState();
    mostrar_datos();
  }
  */
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                headerTop('Registro', 'Por favor llena todos los campos'),
                _PrimerNombre(),
                _SegundoNombre(),
                _PrimerApellido(),
                _SegundoApellido(),
                Container(
                  padding: EdgeInsets.all(10),
                  child: RadioListTile<String>(
                      title: Text('Masculino'),
                      value: 'Masculino',
                      groupValue: "Genero",
                      onChanged: (value) {
                        print(value); //selected value
                      }),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: RadioListTile<String>(
                      title: Text('Femenino'),
                      value: 'Femenino',
                      groupValue: "Genero",
                      onChanged: (value) {
                        print(value); //selected value
                      }),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: _validarFechaDeNacimiento,
                      controller:
                          dateinput, //editing controller of this TextField
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Fecha de nacimiento",
                          border: OutlineInputBorder(),
                          isDense: false,
                          contentPadding: EdgeInsets.all(10),
                          hintText: '' //label text of field
                          ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          //print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          //print(formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement
                          setState(() {
                            dateinput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          //print("Date is not selected");
                        }
                      },
                    )),
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
              ]),
        ));
  }

  String? _validarFechaDeNacimiento(String? value) {
    if (value != null && value.isEmpty) {
      return "Campo obligatorio";
    }
    return null;
  }

  String? _validarGenero(String? value) {
    if (value != null && value.isEmpty) {
      return "Campo obligatorio";
    }
    return null;
  }

  Widget _PrimerNombre() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: _validarPrimerNombre,
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

  String? _validarPrimerNombre(String? value) {
    if (value != null && value.isEmpty) {
      return "Campo obligatorio";
    }
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'El campo debe de ser a-z y A-Z';
    }
    return null;
  }

  Widget _SegundoNombre() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: _validarSegundoNombre,
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

  String? _validarSegundoNombre(String? value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'El campo debe de ser a-z y A-Z';
    }
    return null;
  }

  Widget _PrimerApellido() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: _validarPrimerApellido,
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

  String? _validarPrimerApellido(String? value) {
    if (value != null && value.isEmpty) {
      return "Campo obligatorio";
    }
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'El campo debe de ser a-z y A-Z';
    }
    return null;
  }

  Widget _SegundoApellido() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: _validarSegundoApellido,
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

  String? _validarSegundoApellido(String? value) {
    if (value != null && value.isEmpty) {
      return "Campo obligatorio";
    }
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'El campo debe de ser a-z y A-Z';
    }
    return null;
  }

  Widget _PaisDeNacimiento() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: _validarPaisDeNacimiento,
        keyboardType: TextInputType.text,
        controller: PaisDeNacimiento,
        decoration: InputDecoration(
            labelText: 'País de nacimiento',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  String? _validarPaisDeNacimiento(String? value) {
    if (value != null && value.isEmpty) {
      return "Campo obligatorio";
    }
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'El campo debe de ser a-z y A-Z';
    }
    return null;
  }

  Widget _EstadoDeNacimiento() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: _validarEstadoDeNacimiento,
        keyboardType: TextInputType.text,
        controller: EstadoDeNacimiento,
        decoration: InputDecoration(
            labelText: 'Estado de nacimiento',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  String? _validarEstadoDeNacimiento(String? value) {
    if (value != null && value.isEmpty) {
      return "Campo obligatorio";
    }
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'El campo debe de ser a-z y A-Z';
    }
    return null;
  }

  Widget _Nacionalidad() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: _validarNacionalidad,
        keyboardType: TextInputType.text,
        controller: Nacionalidad,
        decoration: InputDecoration(
            labelText: 'Nacionalidad',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  String? _validarNacionalidad(String? value) {
    if (value != null && value.isEmpty) {
      return "Campo obligatorio";
    }
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'El campo debe de ser a-z y A-Z';
    }
    return null;
  }

  Widget _CURP() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: _validarCURP,
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

  String? _validarCURP(String? value) {
    if (value != null && value.isEmpty) {
      return "Campo obligatorio";
    }
    String pattern = r'(^[a-zA-Z0-9]*$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'El campo sólo acepta números y texto';
    }
    if (value.length != 5) {
      return "El nmero debe tener 18 digitos";
    }
    return null;
  }

  Widget _RFC() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: _validarRFC,
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

  String? _validarRFC(String? value) {
    if (value != null && value.isEmpty) {
      return "Campo obligatorio";
    }
    String pattern = r'(^[a-zA-Z0-9]*$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'El campo sólo acepta números y texto';
    }
    if (value.length != 13) {
      return "El nmero debe tener 13 digitos";
    }
    return null;
  }

  Widget _EstadoCivil() {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: DecoratedBox(
          decoration: BoxDecoration(
              //color: Colors.lightGreen, //background color of dropdown button
              border: Border.all(
                  color: Colors.black38, width: 1), //border of dropdown button
              borderRadius:
                  BorderRadius.circular(5) //border raiuds of dropdown button
              /*boxShadow: <BoxShadow>[
                //apply shadow on Dropdown button
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                    blurRadius: 5) //blur radius of shadow
              ]*/
              ),
          child: DropdownButtonFormField<String>(
            //isDense: true,
            //validator: _validarEstadoCivil,
            validator: (value) {
              if (value == 'Campo obligatorio') {
                return 'Please select a location';
              }
              return null;
            },
            value: "Estado civil",
            items: [
              //add items in the dropdown
              DropdownMenuItem(
                child: Text("Estado civil"),
                value: "Estado civil",
              ),
              DropdownMenuItem(
                child: Text("Soltero"),
                value: "Soltero",
              ),
              DropdownMenuItem(child: Text("Divorciado"), value: "Divorciado"),
              DropdownMenuItem(
                child: Text("Unión Libre"),
                value: "Unión Libre",
              ),
              DropdownMenuItem(
                child: Text("Casado"),
                value: "Casado",
              ),
              DropdownMenuItem(
                child: Text("Viudo"),
                value: "Viudo",
              )
            ],
            onChanged: (value) {
              //get value when changed
              print("You have selected $value");
            },
            icon: Padding(
                //Icon at tail, arrow bottom is default icon
                padding: EdgeInsets.only(left: 20),
                child: Icon(Icons.arrow_circle_down_sharp)),
            iconEnabledColor: Colors.white, //Icon color
            style: TextStyle(
              //te
              color: Colors.black, //Font color
              //fontSize: 20 //font size on dropdown button
            ),

            dropdownColor:
                Color.fromARGB(255, 255, 255, 255), //dropdown background color
            //underline: Container(), //remove underline
            isExpanded: true, //make true to make width 100%
          )),

      /*Text(
          'Selected Value: $dropdownValue',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
              'Selected Value: $dropdownValue',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )*/
    );
  }

  String? _validarEstadoCivil(String? value) {
    if (value != null && value.isEmpty && value != "Estado civil") {
      return "Campo obligatorio";
    }
    return null;
  }

  Widget _NivelAcademico() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: _validarNivelAcademico,
        keyboardType: TextInputType.text,
        controller: NivelAcademico,
        decoration: InputDecoration(
            labelText: 'NivelAcademico',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  String? _validarNivelAcademico(String? value) {
    if (value != null && value.isEmpty) {
      return "Campo obligatorio";
    }
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'El campo debe de ser a-z y A-Z';
    }
    return null;
  }

  Widget _BotonEnviar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              PrimerNombreRecibe = PrimerNombre.text;
              SegundoNombreRecibe = SegundoNombre.text;
              PrimerApellidoRecibe = PrimerApellido.text;
              SegundoApellidoRecibe = SegundoApellido.text;
              GeneroRecibe = Genero.text;
              FechaDeNacimientoRecibe = FechaDeNacimiento.text;
              PaisDeNacimientoRecibe = PaisDeNacimiento.text;
              EstadoDeNacimientoRecibe = EstadoDeNacimiento.text;
              NacionalidadRecibe = Nacionalidad.text;
              CURPRecibe = CURP.text;
              RFCRecibe = RFC.text;
              EstadoCivilRecibe = EstadoCivil.text;
              NivelAcademicoRecibe = NivelAcademico.text;

              if (PrimerNombreRecibe != "" ||
                  PrimerApellidoRecibe != "" ||
                  SegundoApellidoRecibe != "" ||
                  GeneroRecibe != "" ||
                  FechaDeNacimientoRecibe != "" ||
                  PaisDeNacimientoRecibe != "" ||
                  EstadoDeNacimientoRecibe != "" ||
                  NacionalidadRecibe != "" ||
                  CURPRecibe != "" ||
                  RFCRecibe != "" ||
                  EstadoCivilRecibe != "" ||
                  NivelAcademicoRecibe != "") {
                Ingresar(
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
                /*print('Ingresado correctamtne');
                
                Navigator.of(context).push(MaterialPageRoute<Null>{
                      builder: (BuildContext context){ConfirmarContrasenaRecibe
                        return PerfilMed();
                      }
                });*/
                /*Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => PerfilMed()));*/
              } else {
                //print('Error: Todos los campos son obligatorios');
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              }

              // Navegamos a Home
              //Navigator.pushNamed(context, "/RegMedico/FinRegMedico30_1");
              //print(CorreoRecibe + ' ' + ContrasenaRecibe);
              // si usas pushReplacementNamed la ruta nueva reemplaza la ruta actual.
              // Navigator.pushReplacementNamed(context, '/home');
              //Correo.text = "";
              //Contrasena.text = "";
            }
          },
          child: const Text('Siguiente')),
    );
  }
}
