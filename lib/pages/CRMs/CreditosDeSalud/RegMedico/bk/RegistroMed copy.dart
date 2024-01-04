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

import '../FinRegMedico30.dart';

class RegistroMed extends StatefulWidget {
  const RegistroMed({super.key});

  @override
  State<RegistroMed> createState() => _RegistroMedState();
}

class _RegistroMedState extends State<RegistroMed> {
  final _formKey = GlobalKey<_RegistroMedState>();
  final Correo = TextEditingController();
  final Celular = TextEditingController();
  final Contrasena = TextEditingController();
  final ConfirmarContrasena = TextEditingController();

  String CorreoRecibe = "";
  String CelularRecibe = "";
  String ContrasenaRecibe = "";
  String ConfirmarContrasenaRecibe = "";

  void Ingresar(Corr, Celu, Cont, ConfCont) async {
    print('llego a ingrear datos');
    try {
      var url = Uri.https('fasoluciones.mx', 'ApiApp/Medico/Registro.php');
      var response = await http.post(url, body: {
        'Correo': Corr,
        'Celular': Celu,
        'Contrasena': Cont,
        'ConfirmarContrasena': ConfCont,
      }).timeout(const Duration(seconds: 90));
      print('1111');
      print(response.body);
      print('22222');
      if (response.body != "0") {
        print('si existe aqui -----');
        //guardar_datos("10", "enrique", "tel:34543", "Direccion:antonio oe");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => FinRegMedico30()));
        FocusScope.of(context).unfocus();
      } else {
        print('usuario incorrecto');
      }
    } on TimeoutException catch (e) {
      print('Tardo muco la conexion');
    } on Error catch (e) {
      print('http error');
    }
  }
  /*
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
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => FinRegMedico30()));
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
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de médicos'),
      ),
      drawer: MenuLateralPage(),
      bottomNavigationBar: MenuFooterPage(),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  headerTop('Registro de médicos', ''),

                  //texbox("desde el metodo"),

                  _Correo(),
                  _Celular(),
                  _Contrasena(),
                  _ConfirmarContrasena(),
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
        validator: _validarCorreo,
        keyboardType: TextInputType.text,
        controller: Correo,
        decoration: InputDecoration(
            icon: Icon(Icons.email),
            labelText: 'Correo',
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

  Widget _Celular() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: Celular,
        decoration: InputDecoration(
            icon: Icon(Icons.phone),
            labelText: 'Celular',
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

  Widget _ConfirmarContrasena() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: ConfirmarContrasena,
        obscureText: true,
        decoration: InputDecoration(
            icon: Icon(Icons.password),
            labelText: 'confirmar contraseña',
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
            CelularRecibe = Celular.text;
            ContrasenaRecibe = Contrasena.text;
            ConfirmarContrasenaRecibe = ConfirmarContrasena.text;

            if (CorreoRecibe != "" ||
                CelularRecibe != "" ||
                ContrasenaRecibe != "" ||
                ConfirmarContrasenaRecibe != "") {
              print('paso al boton ingresar');
              Ingresar(CorreoRecibe, CelularRecibe, ContrasenaRecibe,
                  ConfirmarContrasenaRecibe);
              /*print('Ingresado correctamtne');
              
              Navigator.of(context).push(MaterialPageRoute<Null>{
                    builder: (BuildContext context){ConfirmarContrasenaRecibe
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
