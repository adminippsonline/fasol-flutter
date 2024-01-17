import 'package:flutter/material.dart';

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

import 'FinClinicas17.dart';

import 'package:intl/intl.dart';

//PAra validar
//void main() => runApp(const RegistroCliOlvidaste());
//enum OpcionesGenero { Masculino, Femenino }

class RegistroCliOlvidaste extends StatefulWidget {
  const RegistroCliOlvidaste({super.key});

  @override
  State<RegistroCliOlvidaste> createState() => _RegistroCliOlvidasteState();
}

class _RegistroCliOlvidasteState extends State<RegistroCliOlvidaste> {
  //se usa para mostrar los datos del estado
  int id_medico = 0;
  int id_info = 0;
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
      id_medico = prefs.getInt('id_medico') ?? 0;
      id_info = prefs.getInt('id_info') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido $id_medico $id_info  $NombreCompletoSession"),
      ),
      drawer: MenuLateralPage(""),
      bottomNavigationBar: MenuFooterPage(),
      body: const MyCustomFormRegistroCliOlvidaste(),
    );
  }
}

// Create a Form widget.
class MyCustomFormRegistroCliOlvidaste extends StatefulWidget {
  const MyCustomFormRegistroCliOlvidaste({super.key});

  @override
  MyCustomFormRegistroCliOlvidasteState createState() {
    return MyCustomFormRegistroCliOlvidasteState();
  }
}

class MyCustomFormRegistroCliOlvidasteState
    extends State<MyCustomFormRegistroCliOlvidaste> {
  //el fomrKey para formulario

  var MasccaraCelular = new MaskTextInputFormatter(
      mask: '## #### ####', filter: {"#": RegExp(r'[0-9]')});

  final _formKey = GlobalKey<FormState>();

  String? OpcionesGenero;

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
  final IDMedico = TextEditingController();
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
  final Correo = TextEditingController();
  final Celular = TextEditingController();
  final FirmaElectronica = TextEditingController();

  final CP = TextEditingController();
  final Pais = TextEditingController();
  final CiudadOPoblacion = TextEditingController();
  final Calle = TextEditingController();
  final NumExt = TextEditingController();
  final NumInt = TextEditingController();
  final EntCall = TextEditingController();
  final Estado = TextEditingController();
  final MunDel = TextEditingController();
  final Colonia = TextEditingController();

  String PantallaRecibe = "";
  String IDMedicoRecibe = "";
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
  String CorreoRecibe = "";
  String CelularRecibe = "";
  String FirmaElectronicaRecibe = "";

  String CPRecibe = "";
  String PaisRecibe = "";
  String CiudadOPoblacionRecibe = "";
  String CalleRecibe = "";
  String NumExtRecibe = "";
  String NumIntRecibe = "";
  String EntCallRecibe = "";
  String EstadoRecibe = "";
  String MunDelRecibe = "";
  String ColoniaRecibe = "";

  void Ingresar(
      Pantalla,
      IDMedico,
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
      Correo,
      Celular,
      FirmaElectronica,
      CP,
      Pais,
      CiudadOPoblacion,
      Calle,
      NumExt,
      NumInt,
      EntCall,
      Estado,
      MunDel,
      Colonia) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'ApiApp/Clinica/Actualizar.php');
      var response = await http.post(url, body: {
        'Pantalla': Pantalla,
        'id_medico': IDMedico,
        'id_info': IDInfo,
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
        'Correo': Correo,
        'Celular': Celular,
        'FirmaElectronica': FirmaElectronica,
        'CP': CP,
        'Pais': Pais,
        'CiudadOPoblacion': CiudadOPoblacion,
        'Calle': Calle,
        'NumExt': NumExt,
        'NumInt': NumInt,
        'EntCall': EntCall,
        'Estado': Estado,
        'MunDel': MunDel,
        'Colonia': Colonia
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
              MaterialPageRoute(builder: (_) => FinClinicas17()));
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
  int id_medico = 0;
  int id_info = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String TelefonoSession = "";
  /*Future<void> mostrar_datos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id_medico = await prefs.getString('id_medico');
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
      id_medico = prefs.getInt('id_medico') ?? 0;
      id_info = prefs.getInt('id_info') ?? 0;
    });

    Pantalla.text = 'FinSolicitar30';
    IDMedico.text = "$id_medico";
    IDInfo.text = "$id_info";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    headerTop("$id_medico $id_info",
                        'Por favor llena todos los campos'),
                    _Pantalla(),
                    _IDMedico(),
                    _IDInfo(),
                    Container(
                        padding: EdgeInsets.only(left: 10.0),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            //border: Border.all(
                            //color: Colors.blueAccent
                            //)
                            ),
                        child: const Text(
                          "En desarrollo ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 126, 126, 126)),
                          textScaleFactor: 1,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _BotonEnviar(),
                  ]),
            )));
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
              icon: Icon(Icons.calendar_today), //icon of text field
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

  Widget _FirmaElectronica() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: FirmaElectronica,
        decoration: InputDecoration(
            labelText: 'No. de firma electrónica ',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _CP() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioCP,
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

  Widget _Pais() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Pais,
        decoration: InputDecoration(
            labelText: 'Pais',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _CiudadOPoblacion() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: CiudadOPoblacion,
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
        /*validator: _validarNumInt,*/
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
              'Estado',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaEstado.map((item) => DropdownMenuItem<String>(
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
              SelectedListaEstado = value;
            },
            onSaved: (value) {
              SelectedListaEstado = value.toString();
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

  Widget _MunDel() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
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

  Widget _Colonia() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: Colonia,
        decoration: InputDecoration(
            labelText: 'Colonia',
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
              IDMedicoRecibe = IDMedico.text;
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

              CorreoRecibe = Correo.text;
              CelularRecibe = Celular.text;
              FirmaElectronicaRecibe = FirmaElectronica.text;

              CPRecibe = CP.text;
              PaisRecibe = Pais.text;
              CiudadOPoblacionRecibe = CiudadOPoblacion.text;
              CalleRecibe = Calle.text;
              NumExtRecibe = NumExt.text;
              NumIntRecibe = NumInt.text;
              EntCallRecibe = EntCall.text;
              String? EstadoRecibe = SelectedListaEstado;
              if (EstadoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El estado  es obligatorio'),
                      );
                    });
              }
              MunDelRecibe = MunDel.text;
              ColoniaRecibe = Colonia.text;

              if (PantallaRecibe == "" ||
                  IDMedicoRecibe == "" ||
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
                  CorreoRecibe == "" ||
                  CelularRecibe == "" ||
                  FirmaElectronicaRecibe == "" ||
                  CPRecibe == "" ||
                  PaisRecibe == "" ||
                  CiudadOPoblacionRecibe == "" ||
                  CalleRecibe == "" ||
                  NumExtRecibe == "" ||
                  NumIntRecibe == "" ||
                  EntCallRecibe == "" ||
                  EstadoRecibe == "" ||
                  MunDelRecibe == "" ||
                  ColoniaRecibe == "") {
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
                    CorreoRecibe,
                    CelularRecibe,
                    FirmaElectronicaRecibe,
                    CPRecibe,
                    PaisRecibe,
                    CiudadOPoblacionRecibe,
                    CalleRecibe,
                    NumExtRecibe,
                    NumIntRecibe,
                    EntCallRecibe,
                    EstadoRecibe,
                    MunDelRecibe,
                    ColoniaRecibe);
              }
            }
          },
          child: const Text('Siguiente')),
    );
  }
}
