import 'package:dio/dio.dart';
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

import 'FinRegMedico31.dart';

import 'package:intl/intl.dart';

import '../modelos/model_cp.dart';

class FinRegMedico30_1 extends StatefulWidget {
  const FinRegMedico30_1({super.key});

  @override
  State<FinRegMedico30_1> createState() => _FinRegMedico30_1State();
}

class _FinRegMedico30_1State extends State<FinRegMedico30_1> {
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
      NombreCompletoSession = prefs.getString('NombreCompletoSession') ?? '';
      id_medico = prefs.getInt('id_medico') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomFormFinRegMedico30_1();
  }
}

// Create a Form widget.
class MyCustomFormFinRegMedico30_1 extends StatefulWidget {
  const MyCustomFormFinRegMedico30_1({super.key});

  @override
  MyCustomFormFinRegMedico30_1State createState() {
    return MyCustomFormFinRegMedico30_1State();
  }
}

class MyCustomFormFinRegMedico30_1State
    extends State<MyCustomFormFinRegMedico30_1> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

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

  TextEditingController dateinput = TextEditingController();
  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDMedico = TextEditingController();

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

  String PantallaRecibe = "";
  String IDMedicoRecibe = "";

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

  void Ingresar(Pantalla, IDMedico, CP, Pais, Ciudad, Calle, NumExt,
      NumInt, EntCall, Estado, MunDel, Colonia) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Medico/Agregar');
      var response = await http.post(url, body: {
        'Pantalla': Pantalla,
        'id_medico': IDMedico,
        'CP': CP,
        'Pais': Pais,
        'Ciudad': Ciudad,
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
              MaterialPageRoute(builder: (_) => FinRegMedico31()));
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

  List _coloniaf = [];

  @override
  void initState() {
    super.initState();
    mostrar_datos();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _coloniaf.clear();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    CP.dispose();
  }

  void _onFocusChange() {
    _coloniaf.clear();
    dev.log("Focus: ${_focus.hasFocus.toString()}");
  }

  void mostrar_datos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      NombreCompletoSession =
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      id_medico = prefs.getInt('id_medico') ?? 0;
    });

    Pantalla.text = 'FinSolicitar30_1';
    IDMedico.text = "$id_medico";
  }

  String selectedValue = "";
  List<String> _colonias = [];
  //funcion para obtener profesiones
  List<Data> colonias = []; 

  List<dynamic> _colonyList = [];
  Future obtenerCP(var codigo) async {
    dev.log("t");
    final req = {"": codigo};
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
      // List<Data> coloniaList = data.map((item) => Data.fromJson(item)).toList();

      // setState(() {
      //   colonias = coloniaList;
      // });
      // List<dynamic> colonias = jsonData;
      // colonias.addAll(jsonData.map((item) => Data(
      //     idCP: item['id_cp'],
      //     cP: item["CP"],
      //     colonia: item["Colonia"],
      //     dTipoAsenta: item["dtipoasenta"],
      //     munDel: item["MunDel"],
      //     estado: item["Estado"],
      //     ciudad: item["Ciudad"],
      //     dCP: item["d_CP"],
      //     cEstado: item["c_estado"],
      //     cOficina: item["c_oficina"],
      //     cCP: item["c_CP"],
      //     cTipoAsenta: item["c_tipo_asenta"],
      //     cMnpio: item["c_mnpio"],
      //     idAsentaCpcons: item["id_asenta_cpcons"],
      //     dZona: item["d_zona"],
      //     cCveCiudad: item["c_cve_ciudad"])));
      // dev.log("al");
      // dev.log(colonias.toString());
      // dev.log("messages");
      // dev.log(jsonData["data"].toString());
      // List obten = jsonData["data"];
      // var colonia, munDel, estado, ciudad;
      // //dev.log(obten.toString());
      // var cpData = obten.toList();
      // dev.log(cpData.toString());
      // dev.log("message");
      // dev.log(cpData.toString());

      //List listcolonias = List<String>.from(obten["Colonia"]);

      // for (var a in obten) {
      //   setState(() {
      //     _coloniaf.add(a["Colonia"].toString());
      //     colonia = a["Colonia"].toString();
      //     munDel = a["MunDel"].toString();
      //     estado = a["Estado"].toString();
      //     ciudad = a["Ciudad"].toString();
      //     Colonia.text = colonia;
      //     MunDel.text = munDel;
      //     Estado.text = estado;
      //     Ciudad.text = ciudad;
      //   });
      // }
      // setState(() {
      //   _coloniaf.clear();
      // });
      // if (codigo = !codigo) {
      //   setState(() {
      //     _coloniaf.clear();
      //   });
      // }
    } else {
      throw Exception('Error al obtener las opciones');
    }
  }

  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }

  @override
  Widget build(BuildContext context) {
    return BuildScreens('${NombreCompletoSession}', '', '', 'Información Personal',
        '', _formulario());
  }

  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // headerTop("Médicos", 'Domicilio particular del médico'),
                SubitleCards('Domicilio particular del médico'),
                const SizedBox(
                  height: 20,
                ),
                _Pantalla(),
                _IDMedico(),
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

  

  FocusNode _focus = FocusNode();

  Widget _CP() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        //focusNode: _focus,
        validator: ObligatorioCP,
        //onChanged: obtenerCP,
        onChanged: (value) {
          if (value.length == 5) {
            dev.log("algo");
            obtenerCP(value);
          } else if (value.length < 4) {
            _selectedColony = null;
          }
        },
        // onChanged: (value) {
        //   obtenerCP(value);

        //   dev.log(value.toString());
        //   if (value.isEmpty) {
        //     dev.log("se esta borrando");
        //     setState(() {
        //       _clearDropdown;
        //     });
        //   }
        // },
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

  /*Widget _Pais() {
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
  }*/

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
        validator: validarCampo,
        //validator: ObligatorioSoloTexto,
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

  Widget _MunDel() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: validarCampo,
        //validator: ObligatorioSoloTexto,
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

  var dropdownvalueEspecialidad;
  bool _selected = false;
  String _loveLevel = '';
  String selectedColonia = " ";

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

          // onChanged: (valueSelectedByUser) {
          //   setState(() {
          //     _dropDownItemSelected(valueSelectedByUser!);
          //     _coloniaf.clear();
          //   });
          // },
          // onChanged: (newVal) {
          //   setState(() {
          //     dropdownvalueEspecialidad = newVal;
          //   });
          // },
          // dropdownvalueEspecialidad,
        ));
  }

  void _clearDropdown() {
    dev.log("limpiandodrop");
    setState(() {
      selectedColonia = " ";
      _coloniaf.clear();
    });
  }

  void _dropDownItemSelected(String valueSelectedByUser) {
    setState(() {
      _loveLevel = valueSelectedByUser;
      _selected = true;
    });
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

              //dev.log(ColoniaRecibe.toString());

              CPRecibe = CP.text;
              //PaisRecibe = Pais.text;
              String? PaisRecibe = SelectedListaPais;
              if (PaisRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El país  es obligatorio'),
                      );
                    });
              }
              CiudadRecibe = Ciudad.text;
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
              EstadoRecibe = Estado.text;
              MunDelRecibe = MunDel.text;

              //ColoniaRecibe = _selectedColony.toString();

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
                  CPRecibe == "" ||
                  PaisRecibe == "" ||
                  CiudadRecibe == "" ||
                  CalleRecibe == "" ||
                  NumExtRecibe == "" ||
                  // NumIntRecibe == "" ||
                  EntCallRecibe == "" ||
                  EstadoRecibe == "" ||
                  MunDelRecibe == "" ||
                  ColoniaRecibe == "" ||
                  ColoniaRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                dev.log(CPRecibe.toString());
                Ingresar(
                    PantallaRecibe,
                    IDMedicoRecibe,
                    CPRecibe,
                    PaisRecibe,
                    CiudadRecibe,
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
              MaterialPageRoute(builder: (context) => FinRegMedico31()));
        },
      ),
    );
  }
}
