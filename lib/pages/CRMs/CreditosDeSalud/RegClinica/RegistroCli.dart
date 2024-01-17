import 'package:flutter/material.dart';

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

import 'FinClinicas3.dart';

import '../PerfilClinica/LoginCli.dart';
import '../RegClinica/RegistroCliOlvidaste.dart';
import '../PerfilClinica/PerfilCliVerificar.dart';

//PAra validar
//void main() => runApp(const RegistroCli());

class RegistroCli extends StatefulWidget {
  const RegistroCli({super.key});

  @override
  State<RegistroCli> createState() => _RegistroCliState();
}

class _RegistroCliState extends State<RegistroCli> {
  @override
  Widget build(BuildContext context) {
    return MyCustomFormClinicaRegistro();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Registro de clínica'),
    //   ),
    //   drawer: MenuLateralPage(""),
    //   bottomNavigationBar: MenuFooterPage(),
    //   body: const MyCustomFormClinicaRegistro(),
    // );
  }
}

// Create a Form widget.
class MyCustomFormClinicaRegistro extends StatefulWidget {
  const MyCustomFormClinicaRegistro({super.key});

  @override
  MyCustomFormClinicaRegistroState createState() {
    return MyCustomFormClinicaRegistroState();
  }
}

class MyCustomFormClinicaRegistroState
    extends State<MyCustomFormClinicaRegistro> {
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

  void Ingresar(Corr, Celu, Cont, ConfCont, AvisoDePrivacidad,
      TerminosYCondiciones) async {
    /*print('La información se esta enviando');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('La información se esta enviando')),
    );*/
    try {
      /*print('Mandando información');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mandando información')), 
      );*/
      var url = Uri.https('fasoluciones.mx', 'api/Clinica/Registro');
      var response = await http.post(url, body: {
        'Correo': Corr,
        'Telefono': Celu,
        'Contrasena': Cont,
        'ConfirmarContrasena': ConfCont,
        'AvisoDePrivacidad': "1",
        'TerminosYCondiciones': "1",
      }).timeout(const Duration(seconds: 90));
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
          int id_clinica = Respuesta['id_clinica'];
          /*showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Registrado correctamente'),
                );
              });*/
          guardar_datos(id_clinica, 'Clínica', Corr, Cont, Celu);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => PerfilCliVerificar()));
          FocusScope.of(context).unfocus();
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
  Future<void> guardar_datos(id_clinica, NombreCompletoSession, CorreoSession,
      ContrasenaSession, TelefonoSession) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id_clinica', id_clinica);
    await prefs.setString('NombreCompletoSession', NombreCompletoSession);
    await prefs.setString('CorreoSession', CorreoSession);
    await prefs.setString('ContrasenaSession', ContrasenaSession);
    await prefs.setString('TelefonoSession', TelefonoSession);
  }

  bool AvisoDePrivacidad = false;
  bool TerminosYCondiciones = false;

  @override
  Widget build(BuildContext context) {
    return BuildScreens('Clínica', '', '', 'Registro', '', _formulario());
  }

  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //  headerTop('Clínica', 'Por favor llena todos los campos'),
                SubitleCards('Por favor llena todos los campos'),
                SizedBox(height: 20),
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

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool passwordObscured = false;
  Widget _Contrasena() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioContrasena,
        keyboardType: TextInputType.text,
        controller: Contrasena,
        obscureText: _obscureText,
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                _toggle();
              },
              child: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            icon: Icon(Icons.password),
            labelText: 'Contraseña',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  bool passwordObscured2 = true;
  void _toggle2() {
    setState(() {
      passwordObscured2 = !passwordObscured2;
    });
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
            suffixIcon: GestureDetector(
              onTap: () {
                _toggle2();
              },
              child: Icon(
                passwordObscured2 ? Icons.visibility_off : Icons.visibility,
              ),
            ),
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
                    /*ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Proceando los datos')),
                    );*/
                    Ingresar(
                        CorreoRecibe,
                        CelularRecibe,
                        ContrasenaRecibe,
                        ConfirmarContrasenaRecibe,
                        AvisoDePrivacidad,
                        TerminosYCondiciones);
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
              context, MaterialPageRoute(builder: (context) => LoginCli()));
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
              MaterialPageRoute(builder: (context) => RegistroCliOlvidaste()));
        },
      ),
    );
  }
}
