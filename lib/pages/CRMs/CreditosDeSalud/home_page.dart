import 'dart:io';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'includes/colors/colors.dart';
import 'headers.dart';
import 'menu_lateral.dart';
import 'menu_footer.dart';
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
import 'RegSolicitud/RegistroSol.dart';
import 'RegSolicitud/Desgloce.dart';

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
        title: Text("Crédito y Préstamos Personales",
            style: TextStyle(
                //fontFamily: 'cursive',
                color: TITULO_TEXT_BOTON_ENTRAR)),
        backgroundColor: COLOR_PRINCIPAL,
      ),
      drawer: MenuLateralPage(""),
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
  List<int> arraySaltos = [];
  List<int> arraySaltosIndex = [];

  //Los controladores para los input
  /*final Cantidad = CantidadgController();
  final Periodo = PeriodoController();
  final Plazo = PlazoController();*/

  /*final Cantidad = CantidadgController();
  final Periodo = PeriodoController();
  final Plazo = PlazoController();*/

  @override
  void initState() {
    super.initState();
    obtenerMonto();
    fetchData();
  }

  Future<String> obtenerDireccionIP() async {
    try {
      for (var interface in await NetworkInterface.list()) {
        for (var address in interface.addresses) {
          // Verificar si la dirección IP es una dirección IPv4 y no una dirección de bucle local
          if (address.type == InternetAddressType.IPv4 && !address.isLoopback) {
            return address.address;
          }
        }
      }
    } catch (e) {
      print("Error al obtener la dirección IP: $e");
    }

    return "No se pudo obtener la dirección IP";
  }

  String direccionIP = "";
  Future<void> obtenerMonto() async {
    direccionIP = await obtenerDireccionIP();

    var url = Uri.parse(
        "https://fasoluciones.mx/api/Solicitud/SGS/Solicitar?IP=$direccionIP&id_solicitante=0");
    var response = await http.get(url);

    String jsonString = response.body;
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    String arraySaltosString = jsonMap['ArraySaltos'];
    arraySaltosIndex = json.decode(arraySaltosString).cast<int>();
    var periodosProducto = jsonMap['data']['GetPeriodicidadesProducto'];
    arraySaltos = List<int>.from(json.decode(arraySaltosString));

    // Actualiza el valor inicial del Slider después de obtener los datos
    if (arraySaltos.isNotEmpty) {
      setState(() {
        value = arraySaltos.first.toDouble();
      });
    }
  }

  Future<List<Map<String, dynamic>>> obtenerPlazosPeriodicidad(
      var idPerio, var etiquet) async {
    String direccionIP = await obtenerDireccionIP();
    // Simular una llamada a la API para obtener los plazos de periodicidad
    idPerio = 79;

    String apiUrl =
        'https://fasoluciones.mx/api/Solicitud/SGS/GetPlazosPeriodicidad?nIdPeriodo=$idPerio&Etiqueta=$etiquet&IP=$direccionIP&id_solicitante=0';

    HttpClient httpClient = HttpClient();

    try {
      var request = await httpClient.getUrl(Uri.parse(apiUrl));
      HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        String responseBody = await response.transform(utf8.decoder).join();
        Map<String, dynamic> responseData = json.decode(responseBody);

        List<dynamic> plazosList =
            responseData['data']['GetPlazosPeriodicidad'];

        // Convertir la lista de plazos a List<Map<String, dynamic>>
        List<Map<String, dynamic>> plazos =
            List<Map<String, dynamic>>.from(plazosList);

        return plazos;
      } else {
        throw Exception('Error en la llamada a la API');
      }
    } catch (error) {
      dev.log(error.toString());
      throw Exception('Error en la llamada a la API: $error');
    } finally {
      httpClient.close();
    }
  }

  Future<Map<String, dynamic>> obtenerPeriocidad() async {
    try {
      String direccionIP = await obtenerDireccionIP();
      print("Dirección IP del dispositivo: $direccionIP");
      var url = Uri.parse(
          "https://fasoluciones.mx/api/Solicitud/SGS/Solicitar?IP=$direccionIP&id_solicitante=0");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        String jsonString = response.body;
        Map<String, dynamic> jsonMap = json.decode(jsonString);
        // Acceder a GetPeriodicidadesProducto
        List<dynamic> periodicidades =
            jsonMap['data']['GetPeriodicidadesProducto'];
        // Obtener el valor de nIdPeriodo y sDescription
        String nIdPeriodo = periodicidades[0]
            ['nIdPeriodo']; // Puedes cambiar el índice según tus necesidades
        String sDescription = periodicidades[0]['sDescription'];

        // Retornar los valores como un mapa
        return {'nIdPeriodo': nIdPeriodo, 'sDescription': sDescription};
        ;
      } else {
        // Si la respuesta del servidor no es exitosa, manejar el error apropiadamente
        print("Error en la solicitud: ${response.statusCode}");
        return {"error": "Error en la solicitud: ${response.statusCode}"};
      }
    } catch (error) {
      // Manejar cualquier error que pueda ocurrir durante la solicitud
      print("Error en la solicitud: $error");
      return {"error": "Error en la solicitud: $error"};
    }
  }

  int CantidadRecibe = 0;
  String PeriodoRecibe = "";

  double PlazoQuincenalRecibe = 0;
  double PlazoMensualRecibe = 0;

  int _cantidadMinima = 20;
  double _cantidadQuincenal = 12;
  double _cantidadMensual = 6;

  int _quincenasMinima = 12;
  int _mensualidadesMinima = 6;

  String? _opcionesPeriodicidadPago = "Quincenal";
  bool _quincenalPeriodicidadPago = true;
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

  void Ingresar(Cantidad, Periodo, Plazo, DireccionIP) async {
    try {
      print('La información se esta enviando');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La información se esta enviando')),
      );

      var enviar = {
        'Cantidad': "$Cantidad",
        'Periodo': Periodo,
        'Quincenal': "$Plazo",
        'Mensual': "$DireccionIP",
      };
      //print(Enviar);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) =>
              Desgloce("$Cantidad", Periodo, "$Plazo", "$DireccionIP")));
      FocusScope.of(context).unfocus();
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

  List<Map<String, dynamic>>? periodos = [];
  String selectedPeriodo = 'Quincenal';
  String idPeriodos = '79';
  Future<void> fetchData() async {
    String direccionIP = await obtenerDireccionIP();
    print("Dirección IP del dispositivo: $direccionIP");
    var url = Uri.parse(
        "https://fasoluciones.mx/api/Solicitud/SGS/Solicitar?IP=$direccionIP&id_solicitante=0");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        periodos = List.from(data['data']['GetPeriodicidadesProducto']!);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  double _currentValue = 12.0; // Valor inicial del plazo
  var plazoSelecIndex = 0;
  Widget _getTextToShow(var idPeriodo, var etiqueta) {
    if (selectedPeriodo == 'Quincenal') {
      //return Text('Hola');
      return FutureBuilder<List<Map<String, dynamic>>>(
        future: obtenerPlazosPeriodicidad(idPeriodo, etiqueta),
        builder: (context, plazosSnapshot) {
          if (plazosSnapshot.hasData) {
            List<Map<String, dynamic>> plazos = plazosSnapshot.data!;
            String primerPlazo = plazos.first['nPlazo'].toString();
            String ultimoPlazo = plazos.last['nPlazo'].toString();
            // Obtiene el índice del plazo seleccionado
            int indicePlazoSeleccionado = plazos.indexWhere((plazo) =>
                double.parse(plazo['nPlazo'].toString()) == _currentValue);
            plazoSelecIndex = indicePlazoSeleccionado;
            // Puedes hacer algo con los plazos obtenidos
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quincenas: $primerPlazo',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Text(
                      'Quincenas: $ultimoPlazo',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                ),
                Slider(
                  value: _currentValue,
                  min: 12,
                  max: 48,
                  divisions: 36,
                  onChanged: (value) {
                    setState(() {
                      _currentValue = value;
                    });
                  },
                ),
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
                        'Quincenas: ${_currentValue.toInt()}',
                        style: const TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      // Text(
                      //     'Índice del Plazo Seleccionado: $indicePlazoSeleccionado'),
                    ],
                  ),
                ),
                // Text(
                //   'Quincenas: ${_currentValue.toInt()}',
                //   style: TextStyle(fontSize: 24.0),
                // ),
                // Text('Índice del Plazo Seleccionado: $indicePlazoSeleccionado'),
              ],
            );
          } else if (plazosSnapshot.hasError) {
            return Text('Error al obtener los plazos');
          }
          return CircularProgressIndicator(); // Mientras se carga la data
        },
      );
    } else if (selectedPeriodo == 'Mensual') {
      return FutureBuilder<List<Map<String, dynamic>>>(
        future: obtenerPlazosPeriodicidad(idPeriodo, etiqueta),
        builder: (context, plazosSnapshot) {
          if (plazosSnapshot.hasData) {
            List<Map<String, dynamic>> plazos = plazosSnapshot.data!;
            String primerPlazo = plazos.first['nPlazo'].toString();
            String ultimoPlazo = plazos.last['nPlazo'].toString();
            int indicePlazoSeleccionado = plazos.indexWhere((plazo) =>
                double.parse(plazo['nPlazo'].toString()) == _currentValue);
            // Obtiene la etiqueta

            // Puedes hacer algo con los plazos obtenidos
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Meses: $primerPlazo',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Text(
                      'Meses: $ultimoPlazo',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                ),
                Slider(
                  value: _currentValue,
                  min: 12,
                  max: 48,
                  divisions: 36,
                  onChanged: (value) {
                    setState(() {
                      _currentValue = value;
                    });
                  },
                ),
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
                        'Meses: ${_currentValue.toInt()}',
                        style: const TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                          'Índice del Plazo Seleccionado: $indicePlazoSeleccionado'),
                    ],
                  ),
                ),
                // Text(
                //   'Meses: ${_currentValue.toInt()}',
                //   style: TextStyle(fontSize: 24.0),
                // ),
              ],
            );
          } else if (plazosSnapshot.hasError) {
            return Text('Error al obtener los plazos');
          }
          return CircularProgressIndicator(); // Mientras se carga la data
        },
      );
    } else {
      // Puedes manejar otros casos o retornar un widget por defecto
      return Container();
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
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: const Text(
                  "¿Cuánto dinero necesitas?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                  textScaleFactor: 1,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              _InputRange(),
              _tituloPeriodicidad(),
              if (periodos != null)
                for (var periodo in periodos!)
                  RadioListTile<String>(
                    title: Text(periodo['sDescription']),
                    value: periodo['sDescription'],
                    groupValue: selectedPeriodo,
                    onChanged: (value) {
                      setState(() {
                        selectedPeriodo = value!;
                        idPeriodos = periodo['nIdPeriodo'];
                      });
                    },
                  )
              else
                CircularProgressIndicator(),
              _getTextToShow(idPeriodos, selectedPeriodo),
              Container(
                padding: EdgeInsets.all(15),
                child: const Text(
                  "Como entidad financiera estamos regulada y supervisada por la CONDUSEF con la cual obtuvimos nuestro registro como SOFOM y por su parte, por la CNBV en materia de Prevención de Lavado de Dinero y Financiamiento al Terrorismo.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 56, 56, 56),
                  ),
                ),
              ),
              _BotonEnviar(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  double value = 0.0;
  var montoSelectIndex = 0;
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
      Slider(
        value: value,
        onChanged: (double sliderValue) {
          setState(() {
            value = sliderValue;
          });
        },
        onChangeEnd: (double sliderValue) {
          double nearestValue = arraySaltos.reduce((a, b) {
            return (a - sliderValue).abs() < (b - sliderValue).abs() ? a : b;
          }).toDouble();

          setState(() {
            value = nearestValue;
            montoSelectIndex = arraySaltosIndex.indexOf(value.toInt());
          });
        },
        min: arraySaltos.isEmpty ? 0 : arraySaltos.first.toDouble(),
        max: arraySaltos.isEmpty ? 0 : arraySaltos.last.toDouble(),
        divisions: arraySaltos.length >= 2 ? arraySaltos.length - 1 : 1,
        label: arraySaltos.isEmpty ? '' : value.toString(),
      ),
      Text('${arraySaltosIndex.indexOf(value.toInt())}')
    ]);
  }

  Widget _tituloPeriodicidad() {
    return Column(children: <Widget>[
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
    ]);
  }

  Widget _InputQuincenal() {
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
              _quincenasMinima.toString(),
              style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 1),
            const Text(
              "",
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "Quincenas ",
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
    ]);
  }

  Widget _InputMensualidad() {
    return Column(children: <Widget>[
      Container(
        padding: const EdgeInsets.all(10.0),
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
              _mensualidadesMinima.toString(),
              style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 1),
            const Text(
              "",
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "Meses ",
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
              child: Text("6 mensualidades"),
            ),
            Expanded(
              child: Text(
                "24 mensualidades",
                textAlign: TextAlign.right,
                style: TextStyle(),
              ),
            ),
          ],
        ),
      ),
      SliderTheme(
        data: SliderThemeData(),
        child: Slider(
          value: _mensualidadesMinima.toDouble(),
          min: 6,
          max: 24,
          divisions: 18,
          label: _mensualidadesMinima.round().toString(),
          //activeColor: Colors.deepOrange,
          //inactiveColor: Colors.amber,
          onChanged: (value) {
            _mensualidadesMinima = value.round();
            setState(() {
              _mensualidadesMinima = _mensualidadesMinima;
              print(_mensualidadesMinima);
            });
          },
        ),
      ),
    ]);
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
                dev.log(montoSelectIndex.toString());
                dev.log(plazoSelecIndex.toString());
                dev.log(idPeriodos);

                Ingresar(montoSelectIndex.toString(), idPeriodos,
                    plazoSelecIndex.toString(), direccionIP);
                // Ingresar(CantidadRecibe, PeriodoRecibe, PlazoQuincenalRecibe,
                //     PlazoMensualRecibe);
              }
            }
          },
          child: const Text('Siguiente')),
    );
  }
}
