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

import 'FinClinicas4.dart';

import 'package:intl/intl.dart';

class FinClinicas3 extends StatefulWidget {
  const FinClinicas3({super.key});

  @override
  State<FinClinicas3> createState() => _FinClinicas3State();
}

class _FinClinicas3State extends State<FinClinicas3> {
  //se usa para mostrar los datos del estado
  int id_clinica = 0;
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
          prefs.getString('NombreCompletoSession') ?? 'Clínica';
      id_clinica = prefs.getInt('id_clinica') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomFormFinClinicas3();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(NombreCompletoSession),
    //   ),
    //   drawer: MenuLateralPage(),
    //   bottomNavigationBar: MenuFooterPage(),
    //   body: const MyCustomFormFinClinicas3(),
    // );
  }
}

// Create a Form widget.
class MyCustomFormFinClinicas3 extends StatefulWidget {
  const MyCustomFormFinClinicas3({super.key});

  @override
  MyCustomFormFinClinicas3State createState() {
    return MyCustomFormFinClinicas3State();
  }
}

class MyCustomFormFinClinicas3State extends State<MyCustomFormFinClinicas3> {
  //el fomrKey para formulario
  var MasccaraCelular = new MaskTextInputFormatter(
      mask: '## #### ####', filter: {"#": RegExp(r'[0-9]')});

  final _formKey = GlobalKey<FormState>();

  final List<String> ListaNacionalidad = [
    'Mexicana',
  ];
  String? SelectedListaNacionalidad;

  TextEditingController FechaConstitucionInput = TextEditingController();
  TextEditingController FechaConstitucionActaConstiInput =
      TextEditingController();
  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDClinica = TextEditingController();

  final DenominacionORazonSocial = TextEditingController();
  final Nacionalidad = TextEditingController();
  final NumActaConstitutiva = TextEditingController();
  final FechaConstitucion = TextEditingController();
  final NombreNotaria = TextEditingController();
  final NoNotaria = TextEditingController();
  final EntidadFederativaNotaria = TextEditingController();
  final FechaConstitucionActaConsti = TextEditingController();
  final FolioDeInscripcion = TextEditingController();
  final EstadoRPP = TextEditingController();
  final RFC = TextEditingController();
  final ActividadEconomica = TextEditingController();
  final NoDeSerie = TextEditingController();
  final CorreoEmpresa = TextEditingController();
  final Telefono = TextEditingController();

  String PantallaRecibe = "";
  String IDClinicaRecibe = "";

  String DenominacionORazonSocialRecibe = "";
  String NacionalidadRecibe = "";
  String NumActaConstitutivaRecibe = "";
  String FechaConstitucionRecibe = "";
  String NombreNotariaRecibe = "";
  String NoNotariaRecibe = "";
  String EntidadFederativaNotariaRecibe = "";
  String FechaConstitucionActaConstiRecibe = "";
  String FolioDeInscripcionRecibe = "";
  String EstadoRPPRecibe = "";
  String RFCRecibe = "";
  String ActividadEconomicaRecibe = "";
  String NoDeSerieRecibe = "";
  String CorreoEmpresaRecibe = "";
  String TelefonoRecibe = "";

  void Ingresar(
      Pantalla,
      IDClinica,
      DenominacionORazonSocial,
      Nacionalidad,
      NumActaConstitutiva,
      FechaConstitucion,
      NombreNotaria,
      NoNotaria,
      EntidadFederativaNotaria,
      FechaConstitucionActaConsti,
      FolioDeInscripcion,
      EstadoRPP,
      RFC,
      ActividadEconomica,
      NoDeSerie,
      CorreoEmpresa,
      Telefono) async {
    try {
      //print("Paso par aca");
      var url = Uri.https('fasoluciones.mx', 'api/Clinica/Agregar');
      var data={
        'Pantalla': Pantalla,
        'id_clinica': IDClinica,
        'DenominacionORazonSocial': DenominacionORazonSocial,
        'Nacionalidad': Nacionalidad,
        'NumActaConstitutiva': NumActaConstitutiva,
        'FechaConstitucion': FechaConstitucion,
        'NombreNotaria': NombreNotaria,
        'NoNotaria': NoNotaria,
        'EntidadFederativaNotaria': EntidadFederativaNotaria,
        'FechaConstitucionActaConsti': FechaConstitucionActaConsti,
        'FolioDeInscripcion': FolioDeInscripcion,
        'EstadoRPP': EstadoRPP,
        'RFC': RFC,
        'ActividadEconomica': ActividadEconomica,
        'NoDeSerie': NoDeSerie,
        'CorreoEmpresa': CorreoEmpresa,
        'TelefonoEmpresampresa': Telefono
      };
      //print(data);
      var response = await http.post(url, body: data).timeout(const Duration(seconds: 90));
      //print("llego aqui 111--");
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
              MaterialPageRoute(builder: (_) => FinClinicas4()));
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
  int id_clinica = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String TelefonoSession = "";
  List _opcionesActividadesEconomicas = [];

  @override
  void initState() {
    super.initState();
    mostrar_datos();
    obtenerActividadesEconomicas();
  }

  void mostrar_datos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      NombreCompletoSession =
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      id_clinica = prefs.getInt('id_clinica') ?? 0;
    });

    Pantalla.text = 'FinClinicas3';
    IDClinica.text = "$id_clinica";
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
        'Clínica', '', '', 'Datos de la clínica', '', _formulario());
  }

  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // headerTop("Clínica ", 'Datos de la empresa'),
                SubitleCards('Datos de la empresa'),
                SizedBox(
                  height: 20,
                ),
                _Pantalla(),
                _IDClinica(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _DenominacionORazonSocial(),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _Nacionalidad(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _NumActaConstitutiva(),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _FechaConstitucion(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _NombreNotaria(),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _NoNotaria(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _EntidadFederativaNotaria(),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _FechaConstitucionActaConsti(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _FolioDeInscripcion(),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _EstadoRPP(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _RFC(),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _ActividadEconomica(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _NoDeSerie(),
                    ),
                  ],
                ),
                _CorreoEmpresa(),
                _Telefono(),
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

  

  Widget _DenominacionORazonSocial() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioInput,
        keyboardType: TextInputType.text,
        controller: DenominacionORazonSocial,
        decoration: InputDecoration(
            labelText: 'Denominación o razón social ',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
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

  Widget _NumActaConstitutiva() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTextoYNumeros,
        keyboardType: TextInputType.text,
        controller: NumActaConstitutiva,
        decoration: InputDecoration(
            labelText: 'No. de acta constitutiva',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _FechaConstitucion() {
    return Container(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          validator: ObligatorioFecha,
          controller:
              FechaConstitucionInput, //editing controller of this TextField
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_today), //icon of text field
              labelText: "Fecha de contitución de la empresa",
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
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              //print(formattedDate); //formatted date output using intl package =>  2021-03-16
              //you can implement different kind of Date Format here according to your requirement
              setState(() {
                //print(formattedDate);
                FechaConstitucionInput.text =
                    formattedDate; //set output date to TextField value.
              });
            } else {
              //print("Date is not selected");
            }
          },
        ));
  }

  Widget _NombreNotaria() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: NombreNotaria,
        decoration: InputDecoration(
            labelText: 'Nombre del notario o corredor público ',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _NoNotaria() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: NoNotaria,
        decoration: InputDecoration(
            labelText: 'No. de notaría',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _EntidadFederativaNotaria() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: EntidadFederativaNotaria,
        decoration: InputDecoration(
            labelText: 'Entidad federativa notaría ',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _FechaConstitucionActaConsti() {
    return Container(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          validator: ObligatorioFecha,
          controller:
              FechaConstitucionActaConstiInput, //editing controller of this TextField
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_today), //icon of text field
              labelText:
                  "Fecha de inscripción del acta constitutiva registro público",
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
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              //print(formattedDate); //formatted date output using intl package =>  2021-03-16
              //you can implement different kind of Date Format here according to your requirement
              setState(() {
                //print(formattedDate);
                FechaConstitucionActaConstiInput.text =
                    formattedDate; //set output date to TextField value.
              });
            } else {
              //print("Date is not selected");
            }
          },
        ));
  }

  Widget _FolioDeInscripcion() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: FolioDeInscripcion,
        decoration: InputDecoration(
            labelText: 'Folio de inscripción RPP',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _EstadoRPP() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: EstadoRPP,
        decoration: InputDecoration(
            labelText: 'Estado RPP ',
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
        validator: ObligatorioRFCEmpresa,
        keyboardType: TextInputType.text,
        controller: RFC,
        maxLength: 12,
        decoration: InputDecoration(
            labelText: 'RFC',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
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
            'Actividad Económica',
            style: TextStyle(fontSize: 12),
          ),
          items: _opcionesActividadesEconomicas.map((item) {
            return DropdownMenuItem(
              value: item['id_ActEc'].toString(),
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

  Widget _NoDeSerie() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioSoloTexto,
        keyboardType: TextInputType.text,
        controller: NoDeSerie,
        decoration: InputDecoration(
            labelText: 'No. de serie de e.firma ',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _CorreoEmpresa() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioCorreo,
        keyboardType: TextInputType.emailAddress,
        controller: CorreoEmpresa,
        decoration: InputDecoration(
            labelText: 'Correo empresa',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Telefono() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        inputFormatters: [MasccaraCelular],
        validator: ObligatorioCelular,
        keyboardType: TextInputType.phone,
        controller: Telefono,
        maxLength: 12,
        decoration: InputDecoration(
            labelText: 'Teléfono empresa',
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

              DenominacionORazonSocialRecibe = DenominacionORazonSocial.text;
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
              NumActaConstitutivaRecibe = NumActaConstitutiva.text;
              FechaConstitucionRecibe = FechaConstitucionInput.text;
              if (FechaConstitucionRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La fecha de constitución es obligatoria'),
                      );
                    });
              }

              NombreNotariaRecibe = NombreNotaria.text;
              NoNotariaRecibe = NoNotaria.text;
              EntidadFederativaNotariaRecibe = EntidadFederativaNotaria.text;

              FechaConstitucionActaConstiRecibe =
                  FechaConstitucionActaConstiInput.text;
              if (FechaConstitucionActaConstiRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('La fecha de inscripción es obligatoria'),
                      );
                    });
              }

              FolioDeInscripcionRecibe = FolioDeInscripcion.text;
              EstadoRPPRecibe = EstadoRPP.text;
              RFCRecibe = RFC.text;
              ActividadEconomicaRecibe = dropdownvalueActividadEconomica;
              NoDeSerieRecibe = NoDeSerie.text;
              CorreoEmpresaRecibe = CorreoEmpresa.text;
              TelefonoRecibe = Telefono.text;

              if (PantallaRecibe == "" ||
                  IDClinicaRecibe == "" ||
                  DenominacionORazonSocialRecibe == "" ||
                  NacionalidadRecibe == "" ||
                  NumActaConstitutivaRecibe == "" ||
                  FechaConstitucionRecibe == "" ||
                  NombreNotariaRecibe == "" ||
                  NoNotariaRecibe == "" ||
                  EntidadFederativaNotariaRecibe == "" ||
                  FechaConstitucionActaConstiRecibe == "" ||
                  FolioDeInscripcionRecibe == "" ||
                  EstadoRPPRecibe == "" ||
                  RFCRecibe == "" ||
                  ActividadEconomicaRecibe == "" ||
                  NoDeSerieRecibe == "" ||
                  CorreoEmpresaRecibe == "" ||
                  TelefonoRecibe == "") {
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
                    IDClinicaRecibe,
                    DenominacionORazonSocialRecibe,
                    NacionalidadRecibe,
                    NumActaConstitutivaRecibe,
                    FechaConstitucionRecibe,
                    NombreNotariaRecibe,
                    NoNotariaRecibe,
                    EntidadFederativaNotariaRecibe,
                    FechaConstitucionActaConstiRecibe,
                    FolioDeInscripcionRecibe,
                    EstadoRPPRecibe,
                    RFCRecibe,
                    ActividadEconomicaRecibe,
                    NoDeSerieRecibe,
                    CorreoEmpresaRecibe,
                    TelefonoRecibe);
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
              MaterialPageRoute(builder: (context) => FinClinicas4()));
        },
      ),
    );
  }
}
