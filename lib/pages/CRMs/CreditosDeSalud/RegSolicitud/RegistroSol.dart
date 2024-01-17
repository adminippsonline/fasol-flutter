import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import '../Includes/widgets/build_screen.dart';
import '../headers.dart';
import '../menu_lateral.dart';
import '../menu_footer.dart';
import '../../../../../Elementos/validaciones_formularios.dart';
import '../Includes/colors/colors.dart';
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

import 'FinSolicitar10.dart';

import '../PerfilSolicitud/LoginSol.dart';
import '../RegSolicitud/RegistroSolOlvidaste.dart';
import '../PerfilSolicitud/PerfilSolVerificar.dart';

//PAra validar
//void main() => runApp(const RegistroSol());

class RegistroSol extends StatefulWidget {
  String idCredito = "";

  RegistroSol(this.idCredito);

  @override
  State<RegistroSol> createState() => _RegistroSolState();
}

class _RegistroSolState extends State<RegistroSol> {
  @override
  Widget build(BuildContext context) {
    return MyCustomFormSolicitudRegistro(widget.idCredito);
  }
}

// Create a Form widget.
class MyCustomFormSolicitudRegistro extends StatefulWidget {
  String idCredito = "";
  MyCustomFormSolicitudRegistro(this.idCredito);

  @override
  MyCustomFormSolicitudRegistroState createState() {
    return MyCustomFormSolicitudRegistroState();
  }
}

class MyCustomFormSolicitudRegistroState
    extends State<MyCustomFormSolicitudRegistro> {
  var MasccaraCelular = new MaskTextInputFormatter(
      mask: '## #### ####', filter: {"#": RegExp(r'[0-9]')});

  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();
  //Los controladores para los input
  final Correo = TextEditingController();
  final Celular = TextEditingController();
  final Contrasena = TextEditingController();
  final ConfirmarContrasena = TextEditingController();

  String CorreoRecibe = "";
  String CelularRecibe = "";
  String ContrasenaRecibe = "";
  String ConfirmarContrasenaRecibe = "";

  String email = "";
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
  void Ingresar(Corr, Celu, Cont, ConfCont, AvisoDePrivacidad,
      TerminosYCondiciones, var idCredito) async {
    dev.log("ingresar");
    direccionIP = await obtenerDireccionIP();
    /*print('La información se esta enviando');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('La información se esta enviando')),
    );*/
    try {
      /*print('Mandando información');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mandando información')),
      );*/
      var url = Uri.https('fasoluciones.mx', 'api/Solicitud/Registro');
      var response = await http.post(url, body: {
        'Correo': Corr,
        'Telefono': Celu,
        'Contrasena': Cont,
        'ConfirmarContrasena': ConfCont,
        'AvisoDePrivacidad': "1",
        'TerminosYCondiciones': "1",
        'id_credito': widget.idCredito,
        'ip': direccionIP
      }).timeout(const Duration(seconds: 90));
      dev.log(response.body.toString());
      /*print('Ingresado en fasol');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresado en fasol')),
      );*/
      if (response.body != "0" && response.body != "") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(response.body),
              );
            });
        var Respuesta = jsonDecode(response.body);

        String status = Respuesta['status'];
        String msg = Respuesta['msg'];
        if (status == "OK") {
          int id_solicitud = Respuesta['id_solicitud'];

          guardar_datos(id_solicitud, 'Solicitud', Corr, Cont, Celu);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('pas aa verificar'),
                );
              });

          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => PerfilSolVerificar(widget.idCredito)));
          FocusScope.of(context).unfocus();
          //}
        } else {
          //print('Error en el registro');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("$msg"),
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

  //Esto es iun metodo
  //se usa para guarar dtos es tipo sesiones
  Future<void> guardar_datos(id_solicitud, NombreCompletoSession, CorreoSession,
      ContrasenaSession, TelefonoSession) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id_solicitud', id_solicitud);
    await prefs.setString('NombreCompletoSession', NombreCompletoSession);
    await prefs.setString('CorreoSession', CorreoSession);
    await prefs.setString('ContrasenaSession', ContrasenaSession);
    await prefs.setString('TelefonoSession', TelefonoSession);
  }

  bool AvisoDePrivacidad = false;
  bool TerminosYCondiciones = false;
  bool passwordObscured = true;
  bool passwordObscured2 = true;

  @override
  Widget build(BuildContext context) {
    return BuildScreens('Solicitud', '', '', 'Registro', '', _formulario());
  }

  @override
  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SubitleCards('Por favor llena todos los campos*****'),
                const SizedBox(
                  height: 20,
                ),
                _Correo(),
                _Celular(),
                _Contrasena(),
                _ConfirmarContrasena(),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('Aviso de privacidad',
                      style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 87, 89, 92))),
                  value: AvisoDePrivacidad,
                  onChanged: (value) {
                    //print(value);
                    setState(() {
                      AvisoDePrivacidad = !AvisoDePrivacidad;
                      //print(AvisoDePrivacidad);
                    });
                  },
                ),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('Términos y condiciones',
                      style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 87, 89, 92))),
                  value: TerminosYCondiciones,
                  onChanged: (value) {
                    setState(() {
                      TerminosYCondiciones = !TerminosYCondiciones;
                    });
                  },
                ),
                /*SizedBox(
                      height: 20,
                    ),*/
                _BotonEnviar(),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Al dar clic en crear mi cuenta aceptas los términos y condiciones y el aviso de privacidad de Fasol Soluciones ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                _BotonIngresar(),
                //_BotonOlvidaste(),
                SizedBox(
                  height: 40,
                ),
              ]),
        ));
  }

  Widget _Correo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioCorreo,
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

  Widget _Celular() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        inputFormatters: [MasccaraCelular],
        validator: ObligatorioCelular,
        keyboardType: TextInputType.phone,
        controller: Celular,
        maxLength: 12,
        decoration: InputDecoration(
            icon: Icon(Icons.phone),
            labelText: 'Celular',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: '00 0000 0000',
            counterText: ''),
      ),
    );
  }

  Widget _Contrasena() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioContrasena,
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

  Widget _ConfirmarContrasena() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioContrasenaConfirmar,
        keyboardType: TextInputType.text,
        controller: ConfirmarContrasena,
        obscureText: passwordObscured2,
        decoration: InputDecoration(
          icon: Icon(Icons.password),
          labelText: 'confirmar contraseña',
          border: OutlineInputBorder(),
          isDense: false,
          contentPadding: EdgeInsets.all(10),
          hintText: '',
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                passwordObscured2 = !passwordObscured2;
              });
            },
            icon: Icon(
                passwordObscured ? Icons.visibility_off : Icons.visibility),
          ),
        ),
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
              CorreoRecibe = Correo.text;
              CelularRecibe = Celular.text;
              ContrasenaRecibe = Contrasena.text;
              ConfirmarContrasenaRecibe = ConfirmarContrasena.text;

              final bool ValidarCorreo = EmailValidator.validate(CorreoRecibe);
              var ValidarCorreoFormat = (ValidarCorreo ? 'yes' : 'no');
              if (ValidarCorreoFormat == "yes") {
                if (CorreoRecibe != "" &&
                    CelularRecibe != "" &&
                    ContrasenaRecibe != "" &&
                    ConfirmarContrasenaRecibe != "" &&
                    AvisoDePrivacidad == true &&
                    TerminosYCondiciones == true) {
                  if (ContrasenaRecibe == ConfirmarContrasenaRecibe) {
                    dev.log(widget.idCredito);

                    Ingresar(
                        CorreoRecibe,
                        CelularRecibe,
                        ContrasenaRecibe,
                        ConfirmarContrasenaRecibe,
                        AvisoDePrivacidad,
                        TerminosYCondiciones,
                        widget.idCredito);
                  } else {
                    //print('Error: Las contraseñas no coinciden');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error: Las contraseñas no coinciden'),
                          );
                        });
                  }
                } else {
                  //print('Error: Todos los campos son obligatorios');
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title:
                              Text('Error: Todos los campos son obligatorios'),
                        );
                      });
                }
              } else {
                //print('Error: El correo no es valido');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Error: El correo no es valido')),
                );
              }
            }
          },
          child: const Text('Registrarme')),
    );
  }

  Widget _BotonIngresar() {
    return Container(
      width: double.infinity,
      //padding: EdgeInsets.all(10),
      child: ListTile(
        title: new Center(
            child: new Text(
          "Ingresar",
          style: new TextStyle(fontSize: 12.0),
        )),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginSol()));
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
              MaterialPageRoute(builder: (context) => RegistroSolOlvidaste()));
        },
      ),
    );
  }
}
