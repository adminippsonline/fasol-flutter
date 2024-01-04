import 'package:flutter/material.dart';

import '../Includes/widgets/build_screen.dart';
import '../headers.dart';
import '../menu_lateral.dart';
import '../menu_footer.dart';
//estas dos creo son para las apis que se consumen
import 'package:http/http.dart' as http;
import 'dart:async';
//Me parece que es para convertir el json
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
//Paqueteria para sesiones tipo cookies
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';


import 'PerfilMedVerificar.dart';
import '../RegMedico/RegistroMed.dart';
import '../RegMedico/RegistroMedOlvidaste.dart';

//PAra validar
//void main() => runApp(const LoginMed());

class LoginMed extends StatefulWidget {
  const LoginMed({super.key});

  @override
  State<LoginMed> createState() => _LoginMedState();
}

class _LoginMedState extends State<LoginMed> {
  @override
  Widget build(BuildContext context) {
    return MyCustomFormMedico();
  }
}

// Create a Form widget.
class MyCustomFormMedico extends StatefulWidget {
  const MyCustomFormMedico({super.key});

  @override
  MyCustomFormMedicoState createState() {
    return MyCustomFormMedicoState();
  }
}

class MyCustomFormMedicoState extends State<MyCustomFormMedico> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();
  //Los controladores para los input
  final Correo = TextEditingController();
  final Contrasena = TextEditingController();
  //Variables para datos que se reciben del input
  String CorreoRecibe = "";
  String ContrasenaRecibe = "";

  String email = "";

  void Ingresar(Corr, Pass) async {
    try {
      var data = {'Correo': Corr, 'Contrasena': Pass};
      var url = Uri.https('fasoluciones.mx', 'api/Medico/Loguear');
      var response =await http.post(url, body: data).timeout(const Duration(seconds: 90));
      if (response.body != "") {
        if (response.body != "0" && response.body != "") {
          var Respuesta = jsonDecode(response.body);
          String status = Respuesta['status'];
          String CorreoSession = Corr;
          String ContrasenaSession = Pass;
          String msg = Respuesta['msg'];          
          if (status == "Error") {            
            showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(msg),
                  );
                });
          }
          else if (status == "OK") {
            int id_medico = Respuesta['id_medico'];
            guardar_datos(
                id_medico,
                Corr,
                Pass);   
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) =>
                      PerfilMedVerificar()));
              FocusScope.of(context).unfocus();

          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error en el login'),
                  );
                });
          }
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error en el login"),
                );
              });
        }
      }
    } on TimeoutException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('La conexión tardo mucho'),
            );
          });
    } on Error catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('Error: HTTP://'),
            );
          });
    }
  }

  //Esto es iun metodo
  //se usa para guarar dtos es tipo sesiones
  Future<void> guardar_datos(id_medico,
    CorreoSession, ContrasenaSession) async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id_medico', id_medico);
    await prefs.setString('CorreoSession', CorreoSession);
    await prefs.setString('ContrasenaSession', ContrasenaSession);
    await prefs.setString('TelefonoSession', TelefonoSession);
  }

  //Esto es un metodo
  //se usa para mostrar los datos del estado
  int id_medico = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String ContrasenaSession = "";
  String TelefonoSession = "";
  Future<void> mostrar_datos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id_medico = await prefs.getInt('id_medico');
    var NombreCompletoSession = await prefs.getString('NombreCompletoSession');
    var CorreoSession = await prefs.getString('CorreoSession');
    var TelefonoSession = await prefs.getString('TelefonoSession');
    if (id_medico != "") {
      if (id_medico != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => PerfilMedVerificar()));
        FocusScope.of(context).unfocus();
      }
    }
  }

  //Pra pintar datos initState() es un estado es como sesiones valida que haya sesiones, si exite te redirecciona al ligin
  @override
  void initState() {
    super.initState();
    mostrar_datos();
  }

  bool passwordObscured = true;
  @override
  Widget build(BuildContext context) {
    if (id_medico != null && id_medico != '0' && id_medico != 0) {
      return Form(key: _formKey, child: SingleChildScrollView());
    } else {
      return BuildScreens(
          'Médico', '', '', 'Iniciar Sesión', '', _formulario());
    }
  }

  Widget _formulario() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SubitleCards('Por favor llena todos los campos'),
              const SizedBox(
                height: 20,
              ),
              _Correo(),
              _Contrasena(),
              const SizedBox(
                height: 20,
              ),
              _BotonEnviar(),
              _BotonRegistro(),
              _BotonOlvidaste()
            ]),
      ),
    );
  }

  Widget _Correo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: _validarCorreo,
        keyboardType: TextInputType.emailAddress,
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
        obscureText: passwordObscured,
        decoration: InputDecoration(
          icon: Icon(Icons.password),
          labelText: 'Contraseña',
          border: OutlineInputBorder(),
          isDense: false,
          contentPadding: EdgeInsets.all(10),
          hintText: '',
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                passwordObscured = !passwordObscured;
              });
            },
            icon: Icon(
                passwordObscured ? Icons.visibility_off : Icons.visibility),
          ),
        ),
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
                if (CorreoRecibe != "" && ContrasenaRecibe != "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Proceando los datos')),
                  );
                  Ingresar(CorreoRecibe, ContrasenaRecibe);
                } else {
                  //print('Error intentelo de nuevo');
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error intentelo de nuevo'),
                        );
                      });
                }
              } else {
                //print('Error: El correo no es valido desde el form');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Error: El correo no es valido')),
                );
              }
            }
          },
          child: const Text('Entrar')),
    );
  }

  Widget _BotonRegistro() {
    return Container(
      width: double.infinity,
      //padding: EdgeInsets.all(10),
      child: ListTile(
        title: new Center(
            child: new Text(
          "Registro",
          style: new TextStyle(fontSize: 12.0),
        )),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegistroMed()));
        },
      ),
    );
  }

  Widget _BotonOlvidaste() {
    return Container(
      width: double.infinity,
      //padding: EdgeInsets.all(10),
      child: ListTile(
        title: new Center(
            child: new Text(
          "¿Olvidaste tu contraseña?",
          style: new TextStyle(fontSize: 12.0),
        )),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegistroMedOlvidaste()));
        },
      ),
    );
  }
}
