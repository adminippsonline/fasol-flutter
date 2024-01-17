import 'package:flutter/material.dart';
import '../Includes/widgets/build_screen.dart';
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

import 'FinSolicitar14.dart';

import 'package:intl/intl.dart';

class FinSolicitar13_1 extends StatefulWidget {
  String idCredito = "";
  FinSolicitar13_1(this.idCredito);

  @override
  State<FinSolicitar13_1> createState() => _FinSolicitar13_1State();
}

class _FinSolicitar13_1State extends State<FinSolicitar13_1> {
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
    return MyCustomFormFinSolicitar13_1(widget.idCredito);
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar13_1 extends StatefulWidget {
  String idCredito = "";
  MyCustomFormFinSolicitar13_1(this.idCredito);

  @override
  MyCustomFormFinSolicitar13_1State createState() {
    return MyCustomFormFinSolicitar13_1State();
  }
}

class MyCustomFormFinSolicitar13_1State
    extends State<MyCustomFormFinSolicitar13_1> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  String? OpcionesGenero;

  String? _opcionesPagarasSolo;
  bool _noPagarasSolo = false;

  void SeleccionadoPagarasSolo(value) {
    setState(() {
      print("--------");
      print(value);
      _opcionesPagarasSolo = value;
      _noPagarasSolo = value == "Un tercero";
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

  TextEditingController FechaDeNacimientoInput = TextEditingController();

  final List<String> ListaPaisDeNacimiento = [
    'México',
  ];
  String? SelectedListaPaisDeNacimiento;

  final List<String> ListaNacionalidad = [
    'Mexicana',
  ];
  String? SelectedListaNacionalidad;

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

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDLR = TextEditingController();
  final IDInfo = TextEditingController();

  final PagarasSolo = TextEditingController();
  final PrimerNombre = TextEditingController();
  final SegundoNombre = TextEditingController();
  final ApellidoPaterno = TextEditingController();
  final ApellidoMaterno = TextEditingController();
  final Genero = TextEditingController();
  final FechaDeNacimiento = TextEditingController();
  final PaisDeNacimiento = TextEditingController();
  final EstadoDeNacimiento = TextEditingController();
  final Nacionalidad = TextEditingController();
  final CURP = TextEditingController();
  final RFC = TextEditingController();

  final PorqueAportara = TextEditingController();
  final RelacionContigo = TextEditingController();
  final NumerpPagos = TextEditingController();
  final ConqueFrecuenciaLoHara = TextEditingController();
  final ACuantoAsciendeIngresos = TextEditingController();
  final ActividadEconomica = TextEditingController();
  final Profesion = TextEditingController();

  final FirmaElectronica = TextEditingController();
  final NumeroFirmaElectronica = TextEditingController();

  String PantallaRecibe = "";
  String IDLRRecibe = "";
  String IDInfoRecibe = "";

  String PagarasSoloRecibe = "";
  String PrimerNombreRecibe = "";
  String SegundoNombreRecibe = "";
  String ApellidoPaternoRecibe = "";
  String ApellidoMaternoRecibe = "";
  String GeneroRecibe = "";
  String FechaDeNacimientoRecibe = "";
  String PaisDeNacimientoRecibe = "";
  String EstadoDeNacimientoRecibe = "";
  String NacionalidadRecibe = "";
  String CURPRecibe = "";
  String RFCRecibe = "";

  String PorqueAportaraRecibe = "";
  String RelacionContigoRecibe = "";
  String NumerpPagosRecibe = "";
  String ConqueFrecuenciaLoHaraRecibe = "";
  String ACuantoAsciendeIngresosRecibe = "";
  String ActividadEconomicaRecibe = "";
  String ProfesionRecibe = "";

  String FirmaElectronicaRecibe = "";
  String NumeroFirmaElectronicaRecibe = "";

  void Ingresar(
      Pantalla,
      IDLR,
      IDInfo,
      PagarasSolo,
      PrimerNombre,
      SegundoNombre,
      ApellidoPaterno,
      ApellidoMaterno,
      Genero,
      FechaDeNacimiento,
      PaisDeNacimiento,
      EstadoDeNacimiento,
      Nacionalidad,
      CURP,
      RFC,
      PorqueAportara,
      RelacionContigo,
      NumerpPagos,
      ConqueFrecuenciaLoHara,
      ACuantoAsciendeIngresos,
      ActividadEconomica,
      Profesion,
      FirmaElectronica,
      NumeroFirmaElectronica) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');
      var response = await http.post(url, body: {
        'Pantalla': Pantalla,
        'id_solicitud': IDLR,
        'id_credito': widget.idCredito,
        'PagarasSolo': PagarasSolo,
        'PrimerNombre': PrimerNombre,
        'SegundoNombre': SegundoNombre,
        'ApellidoPaterno': ApellidoPaterno,
        'ApellidoMaterno': ApellidoMaterno,
        'Genero': Genero,
        'FechaDeNacimiento': FechaDeNacimientoRecibe,
        'PaisDeNacimiento': PaisDeNacimiento,
        'EstadoDeNacimiento': EstadoDeNacimiento,
        'Nacionalidad': Nacionalidad,
        'CURP': CURP,
        'RFC': RFC,
        'PorqueAportara': PorqueAportara,
        'RelacionContigo': RelacionContigo,
        'NumeroPagos': NumerpPagos,
        'ConqueFrecuenciaLoHara': ConqueFrecuenciaLoHara,
        'ACuantoAsciendeIngresos': ACuantoAsciendeIngresos,
        'ActividadEconomica': ActividadEconomica,
        'Profesion': Profesion,
        'FirmaElectronica': FirmaElectronica,
        'NumeroFirmaElectronica': NumeroFirmaElectronica,
      }).timeout(const Duration(seconds: 90));

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
              builder: (_) => FinSolicitar14(widget.idCredito)));
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

  List _opcionesProfesiones = [];
  List _opcionesActividadesEconomicas = [];

  @override
  void initState() {
    super.initState();
    mostrar_datos();
    obtenerOpciones();
    obtenerActividadesEconomicas();
  }

  void mostrar_datos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      NombreCompletoSession = prefs.getString('NombreCompletoSession') ?? '';
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_credito = prefs.getInt('id_credito') ?? 0;
    });

    Pantalla.text = 'FinSolicitar13_1';
    IDLR.text = "$id_solicitud";
    IDInfo.text = "$id_credito";
  }

  //funcion para obtener profesiones
  Future obtenerOpciones() async {
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
                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        //border: Border.all(
                        //color: Colors.blueAccent
                        //)
                        ),
                    child: Text(
                      "¿Quién es el propietario de los recursos con los que se pagará el crédito? ",
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
                          title: const Text('Yo',
                              style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 126, 126, 126),
                              )),
                          value: "Yo",
                          groupValue: _opcionesPagarasSolo,
                          onChanged: SeleccionadoPagarasSolo,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Expanded(
                          child: RadioListTile(
                        title: const Text('Un tercero',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 126, 126, 126),
                            )),
                        value: "Un tercero",
                        groupValue: _opcionesPagarasSolo,
                        onChanged: SeleccionadoPagarasSolo,
                      )),
                    ],
                  ),
                ),
                if (_noPagarasSolo)
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
                        _PrimerNombre(),

                        _SegundoNombre(),
                        _ApellidoPaterno(),
                        _ApellidoMaterno(),

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
                            child: Row(children: [
                              Expanded(
                                child: RadioListTile(
                                    contentPadding: EdgeInsets.all(0.0),
                                    value: "Masculino",
                                    groupValue: OpcionesGenero,
                                    //dense: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
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
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      title: Text("Femenino"),
                                      onChanged: (val) {
                                        setState(() {
                                          OpcionesGenero = val;
                                        });
                                      }))
                            ])),
                        _FechaDeNacimiento(),
                        _PaisDeNacimiento(),
                        _EstadoDeNacimiento(),

                        _CURP(),
                        _RFC(),
                        _Nacionalidad(),
                        _PorqueAportara(),
                        _RelacionContigo(),

                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "¿Con qué periódicidad o frecuencia lo hará? ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 51, 131, 250)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: _NumerpPagos(),
                            ),
                            Expanded(
                              child: _ConqueFrecuenciaLoHara(),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        _ACuantoAsciendeIngresos(),
                        _ActividadEconomica(),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: _Profesion(),
                            ),
                          ],
                        ),

                        /*SizedBox(
                      height: 20,
                    ),*/

                        ////////////////////////
                        ///

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
                                        color:
                                            Color.fromARGB(255, 126, 126, 126),
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
                      ],
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

  Widget _PorqueAportara() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: PorqueAportara,
        decoration: InputDecoration(
            labelText: '¿Por qué aportará recursos?',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _RelacionContigo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: RelacionContigo,
        decoration: InputDecoration(
            labelText: 'Relación contigo',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _NumerpPagos() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: NumerpPagos,
        decoration: InputDecoration(
            labelText: 'Número de pagos periodicos',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _ConqueFrecuenciaLoHara() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: ConqueFrecuenciaLoHara,
        decoration: InputDecoration(
            labelText: 'Pagos',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _ACuantoAsciendeIngresos() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: ACuantoAsciendeIngresos,
        decoration: InputDecoration(
            labelText: '¿A cúanto ascienden sus ingresos? ',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
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

              //PagarasSoloRecibe = PagarasSolo.text;

              String? PagarasSoloRecibe = _opcionesPagarasSolo;
              print(PagarasSoloRecibe);
              if (PagarasSoloRecibe == "" || PagarasSoloRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Selecciona una opción'),
                      );
                    });
                PagarasSoloRecibe = "";
              }

              /*print("**");
            print(PantallaRecibe);
            print(IDLRRecibe);
            print(IDInfoRecibe);
            print(PagarasSoloRecibe);
            print("**");*/

              if (PantallaRecibe == "" ||
                  IDLRRecibe == "" ||
                  IDInfoRecibe == "" ||
                  PagarasSoloRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                if (PagarasSoloRecibe == "Un tercero") {
                  PrimerNombreRecibe = PrimerNombre.text;
                  SegundoNombreRecibe = SegundoNombre.text;
                  ApellidoPaternoRecibe = ApellidoPaterno.text;
                  ApellidoMaternoRecibe = ApellidoMaterno.text;

                  String? GeneroRecibe = OpcionesGenero;
                  FechaDeNacimientoRecibe = FechaDeNacimientoInput.text;
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
                            title:
                                Text('La fecha de nacimiento es obligatoria'),
                          );
                        });
                  }

                  String? PaisDeNacimientoRecibe =
                      SelectedListaPaisDeNacimiento;
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
                            title:
                                Text('El estado de nacimiento es obligatorio'),
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

                  PorqueAportaraRecibe = PorqueAportara.text;
                  RelacionContigoRecibe = RelacionContigo.text;
                  NumerpPagosRecibe = NumerpPagos.text;
                  ConqueFrecuenciaLoHaraRecibe = ConqueFrecuenciaLoHara.text;
                  ACuantoAsciendeIngresosRecibe = ACuantoAsciendeIngresos.text;

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

                  String? ActividadEconomicaRecibe =
                      dropdownvalueActividadEconomica
                          .toString(); //SelectedListaActividadEconomica;
                  if (ActividadEconomicaRecibe == "") {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                Text('La actividad económica es obligatoria'),
                          );
                        });
                  }
                  print(ActividadEconomicaRecibe);

                  String? FirmaElectronicaRecibe = _opcionesFirmaElectronica;
                  if (FirmaElectronicaRecibe == "" ||
                      FirmaElectronicaRecibe == null) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                'La opción firma electrónica es obligatoria'),
                          );
                        });
                  }

                  NumeroFirmaElectronicaRecibe = NumeroFirmaElectronica.text;

                  if (PrimerNombreRecibe == "" ||
                      SegundoNombreRecibe == "" ||
                      ApellidoPaternoRecibe == "" ||
                      ApellidoMaternoRecibe == "" ||
                      GeneroRecibe == "" ||
                      FechaDeNacimientoRecibe == "" ||
                      PaisDeNacimientoRecibe == "" ||
                      EstadoDeNacimientoRecibe == "" ||
                      NacionalidadRecibe == "" ||
                      CURPRecibe == "" ||
                      RFCRecibe == "" ||
                      PorqueAportaraRecibe == "" ||
                      RelacionContigoRecibe == "" ||
                      NumerpPagosRecibe == "" ||
                      ConqueFrecuenciaLoHaraRecibe == "" ||
                      ACuantoAsciendeIngresosRecibe == "" ||
                      ActividadEconomicaRecibe == "" ||
                      ProfesionRecibe == "" ||
                      FirmaElectronicaRecibe == "") {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                'Error: Todos los campos son obligatorios (Propietario de los recursos)'),
                          );
                        });
                  } else {
                    Ingresar(
                        PantallaRecibe,
                        IDLRRecibe,
                        IDInfoRecibe,
                        PagarasSoloRecibe,
                        PrimerNombreRecibe,
                        SegundoNombreRecibe,
                        ApellidoPaternoRecibe,
                        ApellidoMaternoRecibe,
                        GeneroRecibe,
                        FechaDeNacimientoRecibe,
                        PaisDeNacimientoRecibe,
                        EstadoDeNacimientoRecibe,
                        NacionalidadRecibe,
                        CURPRecibe,
                        RFCRecibe,
                        PorqueAportaraRecibe,
                        RelacionContigoRecibe,
                        NumerpPagosRecibe,
                        ConqueFrecuenciaLoHaraRecibe,
                        ACuantoAsciendeIngresosRecibe,
                        ActividadEconomicaRecibe,
                        ProfesionRecibe,
                        FirmaElectronicaRecibe,
                        NumeroFirmaElectronicaRecibe);
                  }
                } else {
                  Ingresar(
                      PantallaRecibe,
                      IDLRRecibe,
                      IDInfoRecibe,
                      PagarasSoloRecibe,
                      PrimerNombreRecibe,
                      SegundoNombreRecibe,
                      ApellidoPaternoRecibe,
                      ApellidoMaternoRecibe,
                      GeneroRecibe,
                      FechaDeNacimientoRecibe,
                      PaisDeNacimientoRecibe,
                      EstadoDeNacimientoRecibe,
                      NacionalidadRecibe,
                      CURPRecibe,
                      RFCRecibe,
                      PorqueAportaraRecibe,
                      RelacionContigoRecibe,
                      NumerpPagosRecibe,
                      ConqueFrecuenciaLoHaraRecibe,
                      ACuantoAsciendeIngresosRecibe,
                      ActividadEconomicaRecibe,
                      ProfesionRecibe,
                      FirmaElectronicaRecibe,
                      NumeroFirmaElectronicaRecibe);
                }
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
                  builder: (context) => FinSolicitar14(widget.idCredito)));
        },
      ),
    );
  }
}
