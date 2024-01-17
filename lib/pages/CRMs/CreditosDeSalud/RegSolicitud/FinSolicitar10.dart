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

import 'FinSolicitar11.dart';

import 'package:intl/intl.dart';

class FinSolicitar10 extends StatefulWidget {
  String idCredito = "";
  FinSolicitar10(this.idCredito);

  @override
  State<FinSolicitar10> createState() => _FinSolicitar10State();
}

class _FinSolicitar10State extends State<FinSolicitar10> {
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
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomFormFinSolicitar10(widget.idCredito);
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar10 extends StatefulWidget {
  String idCredito = "";
  MyCustomFormFinSolicitar10(this.idCredito);

  @override
  MyCustomFormFinSolicitar10State createState() {
    return MyCustomFormFinSolicitar10State();
  }
}

class MyCustomFormFinSolicitar10State
    extends State<MyCustomFormFinSolicitar10> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  TextEditingController FechaTentativaDeOperacionInput =
      TextEditingController();

  final List<String> ListaEstadoUbicacionMedico = [
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
  String? SelectedListaEstadoUbicacionMedico;

  /*final List<String> ListaEspecialidad = ['Especialidad 1', 'Especialidad 2'];*/
  String? SelectedListaEspecialidad;

  final List<String> Listaid_medico = ['medico 1', 'medico 2'];
  String? SelectedListaid_medico;

  TextEditingController dateinput = TextEditingController();
  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDSolicitud = TextEditingController();
  final IDCredito = TextEditingController();

  final TipoDeCirugia = TextEditingController();
  final PrecioCirugia = TextEditingController();
  final FechaTentativaDeOperacion = TextEditingController();

  String PantallaRecibe = "";
  String IDSolicitudRecibe = "";
  String IDCreditoRecibe = "";

  String TipoDeCirugiaRecibe = "";
  String PrecioCirugiaRecibe = "";
  String FechaTentativaDeOperacionRecibe = "";

  List _opcionesEspecialidades = [];
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

  void Ingresar(
      Pantalla,
      IDSolicitud,
      IDCredito,
      Especialidad,
      TipoDeCirugia,
      EstadoUbicacionMedico,
      id_medico,
      PrecioCirugia,
      FechaTentativaDeOperacion) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');
      var data = {
        'Pantalla': Pantalla,
        'id_solicitud': IDSolicitud,
        'id_credito': IDCredito,
        'Especialidad': Especialidad,
        'TipoDeCirugia': TipoDeCirugia,
        'EstadoUbicacionMedico': EstadoUbicacionMedico,
        'id_medico': "2",
        'PrecioCirugia': PrecioCirugia,
        'FechaTentativaDeOperacion': FechaTentativaDeOperacion,
      };

      dev.log("creditosss");
      dev.log(IDCredito);

      var response =
          await http.post(url, body: data).timeout(const Duration(seconds: 90));
      //print("llego aqui 111");
      //print(response.body);
      dev.log(response.statusCode.toString());
      dev.log(response.body);
      if (response.body != "0" && response.body != "") {
        print(response.body);
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
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => FinSolicitar11(widget.idCredito)));
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
    obtenerEspecialidades();
  }

  void mostrar_datos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      NombreCompletoSession = prefs.getString('NombreCompletoSession') ?? '';
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_credito = prefs.getInt('id_credito') ?? 0;
    });

    Pantalla.text = 'FinSolicitar10';
    IDSolicitud.text = "$id_solicitud";
    IDCredito.text = "$id_credito";
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
                SubitleCards(
                    "¿Qué cirugía o tratamiento médico te deseas realizar?"),
                SizedBox(
                  height: 20,
                ),
                _Pantalla(),
                _IDSolicitud(),
                _IDCredito(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _Especialidad(),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _TipoDeCirugia(),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _EstadoUbicacionMedico(),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _id_medico(),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _PrecioCirugia(),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _FechaTentativaDeOperacion(),
                    ),
                  ],
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

  Widget _IDSolicitud() {
    return Visibility(
        visible: false,
        child: Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: IDSolicitud,
            decoration: InputDecoration(
                labelText: 'IDSolicitud',
                border: OutlineInputBorder(),
                isDense: false,
                contentPadding: EdgeInsets.all(10),
                hintText: ''),
          ),
        ));
  }

  Widget _IDCredito() {
    return Visibility(
        visible: false,
        child: Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: IDCredito,
            decoration: InputDecoration(
                labelText: 'IDCredito',
                border: OutlineInputBorder(),
                isDense: false,
                contentPadding: EdgeInsets.all(10),
                hintText: ''),
          ),
        ));
  }

  Widget _TipoDeCirugia() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: TipoDeCirugia,
        decoration: InputDecoration(
            labelText: 'Tipo de cirugía a realizarse',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _PrecioCirugia() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: PrecioCirugia,
        decoration: InputDecoration(
            labelText: 'Precio de la cirugía',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  /*Widget _Especialidad() {
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
              'Especialidad médica',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaEspecialidad.map((item) => DropdownMenuItem<String>(
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
              SelectedListaEspecialidad = value;
            },
            onSaved: (value) {
              SelectedListaEspecialidad = value.toString();
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
  }*/
  String? _opcionSeleccionadaEspecialidad;
  var dropdownvalueEspecialidad;
  Widget _Especialidad() {
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

  Widget _EstadoUbicacionMedico() {
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
            items: ListaEstadoUbicacionMedico.map(
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
              SelectedListaEstadoUbicacionMedico = value;
              getDoctorsByCity(SelectedListaEstadoUbicacionMedico);
            },
            onSaved: (value) {
              SelectedListaEstadoUbicacionMedico = value.toString();
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

  List<dynamic> _doctorList = [];
  Future getDoctorsByCity(var city) async {
    var url = Uri.parse(
        'https://fasoluciones.mx/api/Solicitud/Catalogos/MedicoPorEstado/$city');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final dat = json.decode(response.body);

      if (dat.containsKey('data') &&
          dat['data'] is List &&
          dat['data'].isNotEmpty) {
        var data = dat['data'][0];
        dev.log(data.toString());

        if (data.containsKey('primer_nombre')) {
          setState(() {
            _doctorList = List<String>.from(
                dat['data'].map((address) => address['primer_nombre']));
          });
        } else {
          print(
              "La clave 'primer_nombre' no está presente en el primer elemento de la lista.");
        }
      } else {
        print(
            "La clave 'data' no está presente o la lista está vacía en la respuesta JSON.");
      }
    } else {
      throw Exception('Error al obtener las opciones');
    }
    // if (response.statusCode == 200) {
    //   final dat = json.decode(response.body);
    //   var data = json.decode(response.body)['data'][0];
    //   dev.log(data.toString());
    //   setState(() {
    //     _doctorList = List<String>.from(
    //         dat['data'].map((address) => address['primer_nombre']));
    //   });
    //   setState(() {});
    // } else {
    //   throw Exception('Error al obtener las opciones');
    // }
  }

  Widget _id_medico() {
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
            'Selecciona a tu médico ',
            style: TextStyle(fontSize: 14),
          ),
          items: _doctorList?.map((value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              })?.toList() ??
              [],
          //validator: ObligatorioSelect,
          onChanged: (value) {
            SelectedListaid_medico = value as String?;
          },
          onSaved: (value) {
            SelectedListaid_medico = value.toString();
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
        ),
        // child: DropdownButtonFormField2(
        //   decoration: InputDecoration(
        //     isDense: true,
        //     contentPadding: EdgeInsets.zero,
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(5),
        //     ),
        //   ),
        //   isExpanded: true,
        //   hint: const Text(
        //     'Selecciona a tu médico ',
        //     style: TextStyle(fontSize: 14),
        //   ),
        //   items: _doctorList.map((value) {
        //     return DropdownMenuItem<String>(value: value, child: Text(value));
        //   }).toList(),
        //   validator: ObligatorioSelect,
        //   onChanged: (value) {
        //     SelectedListaid_medico = value;
        //   },
        //   onSaved: (value) {
        //     SelectedListaid_medico = value.toString();
        //   },
        //   buttonStyleData: const ButtonStyleData(
        //     height: 55,
        //     padding: EdgeInsets.only(left: 0, right: 10),
        //   ),
        //   iconStyleData: const IconStyleData(
        //     icon: Icon(
        //       Icons.arrow_drop_down,
        //       color: Colors.black45,
        //     ),
        //     iconSize: 30,
        //   ),
        //   dropdownStyleData: DropdownStyleData(
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(1),
        //     ),
        //   ),
        // )
      ),
    );
  }

  Widget _FechaTentativaDeOperacion() {
    return Container(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          validator: ObligatorioFecha,
          controller:
              FechaTentativaDeOperacionInput, //editing controller of this TextField
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_today),
              labelText: "¿Cuándo te gustaría operarte? ",
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
                FechaTentativaDeOperacionInput.text =
                    formattedDate; //set output date to TextField value.
              });
            } else {
              //print("Date is not selected");
            }
          },
        ));
  }

  Widget _BotonEnviar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              PantallaRecibe = Pantalla.text;
              IDSolicitudRecibe = IDSolicitud.text;

              TipoDeCirugiaRecibe = TipoDeCirugia.text;
              PrecioCirugiaRecibe = PrecioCirugia.text;
              String? EspecialidadRecibe = dropdownvalueEspecialidad;

              if (EspecialidadRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La especialidad es obligatoria'),
                      );
                    });
              }
              String? EstadoUbicacionMedicoRecibe =
                  SelectedListaEstadoUbicacionMedico;
              if (EstadoUbicacionMedicoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La especialidad medica es obligatoria'),
                      );
                    });
              }
              String? id_medicoRecibe = SelectedListaid_medico;
              if (id_medicoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El médico es obligatorio'),
                      );
                    });
              }

              FechaTentativaDeOperacionRecibe =
                  FechaTentativaDeOperacionInput.text;
              if (FechaTentativaDeOperacionRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La fecha es obligatoria'),
                      );
                    });
              }

              if (PantallaRecibe == "" ||
                  IDSolicitudRecibe == "" ||
                  EspecialidadRecibe == "" ||
                  TipoDeCirugiaRecibe == "" ||
                  EstadoUbicacionMedicoRecibe == "" ||
                  id_medicoRecibe == "" ||
                  PrecioCirugiaRecibe == "" ||
                  FechaTentativaDeOperacionRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                dev.log(widget.idCredito);
                Ingresar(
                    PantallaRecibe,
                    IDSolicitudRecibe,
                    widget.idCredito,
                    EspecialidadRecibe,
                    TipoDeCirugiaRecibe,
                    EstadoUbicacionMedicoRecibe,
                    id_medicoRecibe,
                    PrecioCirugiaRecibe,
                    FechaTentativaDeOperacionRecibe);
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
                  builder: (context) => FinSolicitar11(widget.idCredito)));
        },
      ),
    );
  }
}
