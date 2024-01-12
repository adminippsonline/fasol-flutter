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

import 'FinSolicitar16.dart';

import 'package:intl/intl.dart';

import '../modelos/model_cp.dart';

class FinSolicitar15 extends StatefulWidget {
  const FinSolicitar15({super.key});

  @override
  State<FinSolicitar15> createState() => _FinSolicitar15State();
}

class _FinSolicitar15State extends State<FinSolicitar15> {
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
    return MyCustomFormFinSolicitar15();
  }
}

// Create a Form widget.
class MyCustomFormFinSolicitar15 extends StatefulWidget {
  const MyCustomFormFinSolicitar15({super.key});

  @override
  MyCustomFormFinSolicitar15State createState() {
    return MyCustomFormFinSolicitar15State();
  }
}

class MyCustomFormFinSolicitar15State
    extends State<MyCustomFormFinSolicitar15> {
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

  final List<String> ListaTipodeVivienda = [
    'Propia',
    'En renta',
    'Con familiar',
    'En proceso de pago'
  ];
  String? SelectedListaTipodeVivienda;

  final List<String> ListaAntiguedadTiempo = ['Años', 'Meses'];
  String? SelectedListaAntiguedadTiempo;

  TextEditingController dateinput = TextEditingController();
  //Los controladores para los input
  final Pantalla = TextEditingController();
  final idLR = TextEditingController();
  final IDInfo = TextEditingController();

  final CP = TextEditingController();
  final Pais = TextEditingController();
  final Ciudad = TextEditingController();
  final Calle = TextEditingController();
  final Genero = TextEditingController();
  final NumExt = TextEditingController();
  final NumInt = TextEditingController();
  final EntCall = TextEditingController();
  final Estado = TextEditingController();
  final MunDel = TextEditingController();
  final Colonia = TextEditingController();
  final TipodeVivienda = TextEditingController();
  final Antiguedad = TextEditingController();
  final AntiguedadTiempo = TextEditingController();

  String PantallaRecibe = "";
  String idLRRecibe = "";
  String IDInfoRecibe = "";

  String CPRecibe = "";
  String PaisRecibe = "";
  String CiudadRecibe = "";
  String CalleRecibe = "";
  String GeneroRecibe = "";
  String NumExtRecibe = "";
  String NumIntRecibe = "";
  String EntCallRecibe = "";
  String EstadoRecibe = "";
  String MunDelRecibe = "";
  String ColoniaRecibe = "";
  String TipodeViviendaRecibe = "";
  String AntiguedadRecibe = "";
  String AntiguedadTiempoRecibe = "";

  void Ingresar(
      Pantalla,
      idLR,
      IDInfo,
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
      TipodeVivienda,
      Antiguedad,
      AntiguedadTiempo) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Agregar');
      var response = await http.post(url, body: {
        'Pantalla': Pantalla,
        'id_solicitud': idLR,
        'id_credito': IDInfo,
        'CP': CP,
        'Pais': Pais,
        'Ciudad': Ciudad,
        'Calle': Calle,
        'NumExt': NumExt,
        'NumInt': NumInt,
        'EntCall': EntCall,
        'Estado': Estado,
        'MunDel': MunDel,
        'Colonia': Colonia,
        'TipodeVivienda': TipodeVivienda,
        'Antiguedad': Antiguedad,
        'AntiguedadTiempo': AntiguedadTiempo
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
              MaterialPageRoute(builder: (_) => FinSolicitar16()));
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
      NombreCompletoSession = prefs.getString('NombreCompletoSession') ?? '';
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_credito = prefs.getInt('id_credito') ?? 0;
    });

    Pantalla.text = 'FinSolicitar15';
    idLR.text = "$id_solicitud";
    IDInfo.text = "$id_credito";
  }

  String selectedValue = "";
  List<String> _colonias = [];
  //funcion para obtener profesiones
  List<Data> colonias = [];

  List<dynamic> _colonyList = [];
  Future obtenerCP(var codigo) async {
    dev.log("t");
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
                SubitleCards("Solicitar un crédito "),
                SizedBox(
                  height: 20,
                ),
                _Pantalla(),
                _idLR(),
                _IDInfo(),
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
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _TipodeVivienda(),
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

  Widget _idLR() {
    return Visibility(
        visible: false,
        child: Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: idLR,
            decoration: InputDecoration(
                labelText: 'idLR',
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

  Widget _TipodeVivienda() {
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
              'Tipo de vivienda',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaTipodeVivienda.map((item) => DropdownMenuItem<String>(
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
              SelectedListaTipodeVivienda = value;
            },
            onSaved: (value) {
              SelectedListaTipodeVivienda = value.toString();
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

  Widget _Antiguedad() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloNumeros,
        keyboardType: TextInputType.number,
        controller: Antiguedad,
        decoration: InputDecoration(
            labelText: 'Antiguedad',
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

  Widget _BotonEnviar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              PantallaRecibe = Pantalla.text;
              idLRRecibe = idLR.text;
              IDInfoRecibe = IDInfo.text;

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
              ColoniaRecibe = Colonia.text;
              String? TipodeViviendaRecibe = SelectedListaTipodeVivienda;
              if (TipodeViviendaRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El tipo de vivienda es obligatorio'),
                      );
                    });
              }
              AntiguedadRecibe = Antiguedad.text;
              String? AntiguedadTiempoRecibe = SelectedListaAntiguedadTiempo;
              if (AntiguedadTiempoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El tiempo de antiguedad es obligatorio'),
                      );
                    });
              }

              print(PantallaRecibe);
              print(idLRRecibe);
              print(IDInfoRecibe);
              print(CPRecibe);
              print(PaisRecibe);
              print(CiudadRecibe);
              print(CalleRecibe);
              print(NumExtRecibe);
              print(NumIntRecibe);
              print(EntCallRecibe);
              print(EstadoRecibe);
              print(MunDelRecibe);
              print(TipodeViviendaRecibe);
              print(AntiguedadRecibe);
              print(AntiguedadTiempoRecibe);

              if (PantallaRecibe == "" ||
                  idLRRecibe == "" ||
                  IDInfoRecibe == "" ||
                  CPRecibe == "" ||
                  PaisRecibe == "" ||
                  CiudadRecibe == "" ||
                  CalleRecibe == "" ||
                  NumExtRecibe == "" ||
                  NumIntRecibe == "" ||
                  EntCallRecibe == "" ||
                  EstadoRecibe == "" ||
                  MunDelRecibe == "" ||
                  TipodeViviendaRecibe == "" ||
                  AntiguedadRecibe == "" ||
                  AntiguedadTiempoRecibe == "") {
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
                    idLRRecibe,
                    IDInfoRecibe,
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
                    TipodeViviendaRecibe,
                    AntiguedadRecibe,
                    AntiguedadTiempoRecibe);
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
              MaterialPageRoute(builder: (context) => FinSolicitar16()));
        },
      ),
    );
  }
}
