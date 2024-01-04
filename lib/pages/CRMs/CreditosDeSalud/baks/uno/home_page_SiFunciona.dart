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
//import 'package:email_validator/email_validator.dart';
//import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
//import 'package:dropdown_button2/dropdown_button2.dart';

//import 'FinRegMedico31.dart';

//import 'package:intl/intl.dart';

class HomePageCreditosDeSalud extends StatefulWidget {
  const HomePageCreditosDeSalud({super.key});

  @override
  State<HomePageCreditosDeSalud> createState() =>
      _HomePageCreditosDeSaludState();
}

class _HomePageCreditosDeSaludState extends State<HomePageCreditosDeSalud> {
  //se usa para mostrar los datos del estado
  int id_medico = 0;
  int id_info = 0;
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
      id_info = prefs.getInt('id_info') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido $id_medico $id_info  $NombreCompletoSession"),
      ),
      drawer: MenuLateralPage(),
      bottomNavigationBar: MenuFooterPage(),
      body: const MyCustomFormHomePageCreditosDeSalud(),
    );
  }
}

// Create a Form widget.
class MyCustomFormHomePageCreditosDeSalud extends StatefulWidget {
  const MyCustomFormHomePageCreditosDeSalud({super.key});

  @override
  MyCustomFormHomePageCreditosDeSaludState createState() {
    return MyCustomFormHomePageCreditosDeSaludState();
  }
}

class MyCustomFormHomePageCreditosDeSaludState
    extends State<MyCustomFormHomePageCreditosDeSalud> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  //Los controladores para los input
  /*final Cantidad = CantidadgController();
  final Periodo = PeriodoController();
  final Plazo = PlazoController();*/

  /*final Cantidad = CantidadgController();
  final Periodo = PeriodoController();
  final Plazo = PlazoController();*/

  int CantidadRecibe = 0;
  String PeriodoRecibe = "";

  double PlazoQuincenalRecibe = 0;
  double PlazoMensualRecibe = 0;

  int _cantidadMinima = 20;
  double _cantidadQuincenal = 12;
  double _cantidadMensual = 6;

  String? _opcionesPeriodicidadPago;
  bool _quincenalPeriodicidadPago = false;
  bool _mensualPeriodicidadPago = false;
  void SeleccionadoPeriodicidadPago(value) {
    setState(() {
      //print(value);
      _opcionesPeriodicidadPago = value;
      _quincenalPeriodicidadPago = value == "Quincenal";
      _mensualPeriodicidadPago = value == "Mensual";
    });
  }

  final PeriodicidadPago = TextEditingController();
  String PeriodicidadPagoRecibe = "";

  void Ingresar(Cantidad, Periodo, Quincenal, Mensual) async {
    try {
      print('La información se esta enviando');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La información se esta enviando')),
      );
      /*String? CantidadEnviar = "aa";
      String? PeriodoEnviar = Periodo;
      String? QuincenalEnviar = "ccc";
      String? MensualEnviar = Mensual;*/
      var url =
          Uri.https('fasoluciones.mx', 'ApiApp/Solicitud/SGS/Consultar.php');
      var response = await http.post(url, body: {
        'Cantidad': "$Cantidad",
        'Periodo': Periodo,
        'Quincenal': "$Quincenal",
        'Mensual': "$Mensual",
      }).timeout(const Duration(seconds: 90));
      print("holammmm");
      print(response.body);
    } on TimeoutException catch (e) {
      //print('Tardo muco la conexion');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('La conexión tardo mucho'),
            );
          });
    } on Error catch (e) {
      //print('http error');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('Error: HTTP://'),
            );
          });
    }
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
                    headerTop("¿Cuánto dinero necesitas? ", ''),
                    _InputRange(),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10.0),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            //border: Border.all(
                            //color: Colors.blueAccent
                            //)
                            ),
                        child: const Text(
                          "Periodicidad de pagos",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                          textScaleFactor: 1,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: const Text('Quincenal'),
                              value: "Quincenal",
                              groupValue: _opcionesPeriodicidadPago,
                              onChanged: SeleccionadoPeriodicidadPago,
                            ),
                          ),
                          Expanded(
                              child: RadioListTile(
                            title: const Text('Mensual'),
                            value: "Mensual",
                            groupValue: _opcionesPeriodicidadPago,
                            onChanged: SeleccionadoPeriodicidadPago,
                          )),
                        ],
                      ),
                    ),
                    if (_quincenalPeriodicidadPago)
                      Column(children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10.0),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                //border: Border.all(
                                //color: Colors.blueAccent
                                //)
                                ),
                            child: const Text(
                              "Plazos para pagar",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                              ),
                              textScaleFactor: 1,
                            )),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Expanded(
                                child: Text("12 quincenas"),
                              ),
                              Expanded(
                                child: Text(
                                  "48 quincenas",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 1.0),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                //border: Border.all(
                                //color: Colors.blueAccent
                                //)
                                ),
                            child: _slideQuindenalPeriodicidadPago()),
                      ]),
                    if (_mensualPeriodicidadPago)
                      Column(children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10.0),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                //border: Border.all(
                                //color: Colors.blueAccent
                                //)
                                ),
                            child: const Text(
                              "Plazo para pagar",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                              ),
                              textScaleFactor: 1,
                            )),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Expanded(
                                child: Text("6 meses"),
                              ),
                              Expanded(
                                child: Text(
                                  "24 meses",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 1.0),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                //border: Border.all(
                                //color: Colors.blueAccent
                                //)
                                ),
                            child: _slideMensuallPeriodicidadPago()),
                      ]),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _BotonEnviar(),
                  ]),
            )));
  }

  Widget _InputRange() {
    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.deepOrange),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              _cantidadMinima.toString(),
              style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 1),
            const Text(
              ",000",
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "mxn ",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Expanded(
              child: Text("Min 20,000"),
            ),
            Expanded(
              child: Text(
                "Max 200,000",
                textAlign: TextAlign.right,
                style: TextStyle(),
              ),
            ),
          ],
        ),
      ),
      SliderTheme(
        data: SliderThemeData(
            /*activeTrackColor: Colors.deepOrange,
            inactiveTrackColor: Colors.amber,
            thumbColor: Colors.pink,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 18.0),
            overlayColor: Colors.indigo.withOpacity(0.18),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 40.0),
            activeTickMarkColor: Colors.blue,
            inactiveTickMarkColor: Colors.white,
            trackHeight: 18.0,
            valueIndicatorColor: Colors.red,
            valueIndicatorTextStyle: TextStyle(fontSize: 14.0)*/
            ),
        child: Slider(
          value: _cantidadMinima.toDouble(),
          min: 20,
          max: 200,
          divisions: 36,
          label: _cantidadMinima.round().toString(),
          //activeColor: Colors.deepOrange,
          //inactiveColor: Colors.amber,
          onChanged: (value) {
            _cantidadMinima = value.round();
            setState(() {
              _cantidadMinima = _cantidadMinima;
              print(_cantidadMinima);
            });
          },
        ),
      ),
    ]);
  }

  Widget _slideQuindenalPeriodicidadPago() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Slider(
        value: _cantidadQuincenal,
        min: 12,
        max: 48,
        divisions: 36,
        label: _cantidadQuincenal.round().toString(),
        onChanged: (double value) {
          setState(() {
            _cantidadQuincenal = value;
            print("Pintando queincenal");
            print(_cantidadQuincenal);
          });
        },
      ),
    );
  }

  Widget _slideMensuallPeriodicidadPago() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Slider(
        value: _cantidadMensual,
        min: 6,
        max: 24,
        divisions: 18,
        label: _cantidadMensual.round().toString(),
        onChanged: (double value) {
          setState(() {
            _cantidadMensual = value;
          });
        },
      ),
    );
  }

  Widget _BotonEnviar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              /*CantidadRecibe = Cantidad.text;
              PeriodoRecibe = Periodo.text;
              PlazoRecibe = Plazo.text;*/

              CantidadRecibe = _cantidadMinima;
              String? PeriodoRecibe = _opcionesPeriodicidadPago;
              PlazoQuincenalRecibe = _cantidadQuincenal;
              PlazoMensualRecibe = _cantidadMensual;

              if (PeriodoRecibe == "" || PeriodoRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El periodo es obligatorio'),
                      );
                    });
              } else if (CantidadRecibe == "" ||
                  PeriodoRecibe == "" ||
                  PlazoQuincenalRecibe == "" ||
                  PlazoMensualRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                //print("llegando aqui 1");
                Ingresar(CantidadRecibe, PeriodoRecibe, PlazoQuincenalRecibe,
                    PlazoMensualRecibe);
              }
            }
          },
          child: const Text('Siguiente')),
    );
  }
}
