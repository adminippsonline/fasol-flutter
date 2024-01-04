import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'package:get/get.dart';
import '../../headers.dart';
import '../../menu_lateral.dart';
import '../../menu_footer.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
//import 'package:async/async.dart';
//import 'dart:convert' as convert;
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';

import '../PerfilMed.dart';
import '../../RegMedico/modelos/persona.class.dart';
import '../../RegMedico/modelos/medico.class.dart';

import 'package:flutter/services.dart' show rootBundle;

//PAra validar
void main() => runApp(const LoginMed());

class LoginMed extends StatefulWidget {
  const LoginMed({super.key});

  @override
  State<LoginMed> createState() => _LoginMedState();
}

class _LoginMedState extends State<LoginMed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login medico'),
      ),
      drawer: MenuLateralPage(),
      bottomNavigationBar: MenuFooterPage(),
      body: const MyCustomForm(),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.

  Persona persona = Persona('', '', '');

  final _formKey = GlobalKey<FormState>();

  final Correo = TextEditingController();
  final Contrasena = TextEditingController();

  String CorreoRecibe = "";
  String ContrasenaRecibe = "";

  String email = "";

  void Ingresar(Corr, Pass) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'ApiApp/Medico/Login.php');
      var response = await http.post(url, body: {
        'Correo': Corr,
        'Contrasena': Pass
      }).timeout(const Duration(seconds: 90));
      //print("******");
      //print(response.body);
      //print("******");
      if (response.body != "") {
        if (response.body == "Error: El correo no es valido") {
          final Error = response.body;
          print('Error: El correo no es valido');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error: El correo no es valido')),
          );
        } else if (response.body == "Error: Usuario o contraseña incorrectos") {
          final Error = response.body;
          print('Error: Usuario o contraseña incorrectos');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Error: Usuario o contraseña incorrectos')),
          );
        } else {
          print(response.body);

          //guardar_datos("10", "enrique", "tel:34543", "Direccion:antonio oe");
          /*Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => PerfilMed()));
          FocusScope.of(context).unfocus();*/
        }
      }
    } on TimeoutException catch (e) {
      print('Tardo muco la conexion');
    } on Error catch (e) {
      print('http error');
    }
  }

  //Esto es iun metodo
  //se usa para guarar dtos es tipo sesiones
  Future<void> guardar_datos(id, nombre, telefono, direccion) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(id, id);
    await prefs.setString(nombre, nombre);
    await prefs.setString(telefono, telefono);
    await prefs.setString(direccion, direccion);
  }

  //Esto es un metodo
  //se usa para mostrar los datos del estado
  String id = "";
  String nombre = "";
  String telefono = "";
  String direccion = "";
  Future<void> mostrar_datos() async {
    //Se necesitan crear unas variables
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = await prefs.getString('id');
    final nombre = await prefs.getString('nombre');
    final telefono = await prefs.getString('telefono');
    final direccion = await prefs.getString('direccion');
    if (id != "") {
      if (id != null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => PerfilMed()));
        FocusScope.of(context).unfocus();
      }
    }
    print('ento aqui');
    var url = Uri.https('fasoluciones.mx', 'ApiApp/loginGet.php');
    var response = await http.post(url, body: {
      'id': '49',
    }).timeout(const Duration(seconds: 90));
    /*print("*****");
    print(response.body);
    */
    print("*****");
    //var Reuesta = json.decode(response.body);
    var Reuesta = jsonDecode(response.body);
    print(Reuesta);
    print("*****");
    print(Reuesta['id_medico']);

    /*
    print("*****");*/

    // .clear es para eliminar la sesiones
    //prefs.clear();
  }

  //Pra pintar datos initState() es un estado es como sesiones valida que haya sesiones, si exite te redirecciona al ligin
  @override
  void initState() {
    super.initState();
    mostrar_datos();
  }

  @override
  Widget build(BuildContext context) {
    /*rootBundle.loadString('assets/images/myfile.json').then((data) {
      //print(data);
      dynamic jsonData = json.decode(data);
      print("+++++");
      print(jsonData);
      print("+++++");
      persona = Persona.fomJson(jsonData);
      print(persona.documento);
      print(persona.nombre);
      print(persona.edad);

      //setState(() {});
      //Persona persona = Persona.fomJson(jsonData);
      //print(persona);
      //print(persona.documento);
      //print(persona.nombre);
      //print(persona.edad);
    });*/

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        headerTop('Login medico', 'Por favor llena todos los campos'),

        //texbox("desde el metodo"),

        _Correo(),
        _Contrasena(),
        SizedBox(
          height: 20,
        ),

        _BotonEnviar(),
      ]),
    );
  }

  Widget _Correo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: _validarCorreo,
        keyboardType: TextInputType.text,
        controller: Correo,
        decoration: InputDecoration(
            icon: Icon(Icons.email),
            labelText: 'correo',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  String? _validarCorreo(String? value) {
    if (value != null && value.isEmpty) {
      return "El correo es obligatorio";
    }

    if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value!)) {
      return "El correo no es valido";
    }
    return null;
  }

  Widget _Contrasena() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: _validarContrasena,
        keyboardType: TextInputType.text,
        controller: Contrasena,
        obscureText: true,
        decoration: InputDecoration(
            icon: Icon(Icons.password),
            labelText: 'Contraseña',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  String? _validarContrasena(String? value) {
    if (value != null && value.isEmpty) {
      return "Campo obligatorio";
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
              CorreoRecibe = Correo.text;
              ContrasenaRecibe = Contrasena.text;

              final bool ValidarCorreo = EmailValidator.validate(CorreoRecibe);
              var ValidarCorreoFormat = (ValidarCorreo ? 'yes' : 'no');
              if (ValidarCorreoFormat == "yes") {
                if (CorreoRecibe != "" || ContrasenaRecibe != "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Proceando los datos')),
                  );
                  Ingresar(CorreoRecibe, ContrasenaRecibe);
                  /*print('Ingresado correctamtne');
                
                Navigator.of(context).push(MaterialPageRoute<Null>{
                      builder: (BuildContext context){
                        return PerfilMed();
                      }
                });*/
                  /*Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => PerfilMed()));*/
                } else {
                  print('Error intentelo de nuevo');
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error intentelo de nuevo'),
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
              } else {
                print('Error: El correo no es valido desde el form');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Error: El correo no es valido desde el form')),
                );
              }
            }
          },
          child: const Text('Entrar')),
    );
  }
}
