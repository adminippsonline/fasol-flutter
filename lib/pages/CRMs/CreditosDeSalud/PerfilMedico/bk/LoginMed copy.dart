import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'package:get/get.dart';
import '../../headers.dart';
import '../../menu_lateral.dart';
import '../../menu_footer.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
//import 'package:async/async.dart';
import 'dart:convert' as convert;
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../PerfilMed.dart';

class LoginMed extends StatefulWidget {
  const LoginMed({super.key});

  @override
  State<LoginMed> createState() => _LoginMedState();
}

class _LoginMedState extends State<LoginMed> {
  final Correo = TextEditingController();
  final Contrasena = TextEditingController();
  final _keyForm = GlobalKey<_LoginMedState>();

  String CorreoRecibe = "";
  String ContrasenaRecibe = "";

  void Ingresar(Corr, Pass) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'ApiApp/Medico/Login.php');
      var response = await http.post(url, body: {
        'Correo': Corr,
        'Contrasena': Pass
      }).timeout(const Duration(seconds: 90));
      print(response.body);
      if (response.body != "") {
        if (response.body == "Error: El correo no es valido") {
          print('usuario incorrecto');
        } else if (response.body == "Error: Usuario o contraseña incorrectos") {
          print('usuario incorrecto');
        } else {
          print('si existe');
          //guardar_datos("10", "enrique", "tel:34543", "Direccion:antonio oe");
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => PerfilMed()));
          FocusScope.of(context).unfocus();
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
    print("verificando");
    // .clear es para eliminar la sesiones
    //prefs.clear();
  }

  //Pra pintar datos initState() es un estado es como sesiones valida que haya sesiones, si exite te redirecciona al ligin
  @override
  void initState() {
    super.initState();
    mostrar_datos();
  }

  //Esete es uan funcion para pintar un texbox facil
  Widget texbox(String Descripcion) {
    return TextFormField(
      decoration: InputDecoration(hintText: Descripcion),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login medico'),
      ),
      drawer: MenuLateralPage(),
      bottomNavigationBar: MenuFooterPage(),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Form(
            key: _keyForm,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  headerTop('Login medico', 'Por favor llena todos los campos'),

                  //texbox("desde el metodo"),

                  _Correo(),
                  _Contrasena(),
                  SizedBox(
                    height: 20,
                  ),

                  _BotonEnviar(),
                ])),
      ))),
    );
  }

  Widget _Correo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: (String? value) {
          if (value != null && value.isEmpty) {
            return "Campo obligatorio";
          }

          return null;
        },
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

  Widget _Contrasena() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: (String? value) {
          if (value != null && value.isEmpty) {
            return "Campo obligatorio";
          }

          return null;
        },
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

  Widget _BotonEnviar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {
            CorreoRecibe = Correo.text;
            ContrasenaRecibe = Contrasena.text;
            if (CorreoRecibe != "" || ContrasenaRecibe != "") {
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
            print(CorreoRecibe + ' ' + ContrasenaRecibe);
            // si usas pushReplacementNamed la ruta nueva reemplaza la ruta actual.
            // Navigator.pushReplacementNamed(context, '/home');
            Correo.text = "";
            Contrasena.text = "";
          },
          child: const Text('Entrar')),
    );
  }
}
