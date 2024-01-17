import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

//import 'RegistroMedOlvidaste_sui_imagen_no_irve.dart';

import 'package:intl/intl.dart';
import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:dio/dio.dart';

class RegistroMedOlvidaste extends StatefulWidget {
  const RegistroMedOlvidaste({super.key});

  @override
  State<RegistroMedOlvidaste> createState() => _RegistroMedOlvidasteState();
}

class _RegistroMedOlvidasteState extends State<RegistroMedOlvidaste> {
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
      drawer: MenuLateralPage(""),
      bottomNavigationBar: MenuFooterPage(),
      body: const MyCustomFormRegistroMedOlvidaste(),
    );
  }
}

// Create a Form widget.
class MyCustomFormRegistroMedOlvidaste extends StatefulWidget {
  const MyCustomFormRegistroMedOlvidaste({super.key});

  @override
  MyCustomFormRegistroMedOlvidasteState createState() {
    return MyCustomFormRegistroMedOlvidasteState();
  }
}

class MyCustomFormRegistroMedOlvidasteState
    extends State<MyCustomFormRegistroMedOlvidaste> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDMedico = TextEditingController();
  final IDInfo = TextEditingController();

  String PantallaRecibe = "";
  String IDMedicoRecibe = "";
  String IDInfoRecibe = "";

  void Ingresar(Pantalla, IDMedico, IDInfo) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'ApiApp/Medico/Actualizar.php');
      var response = await http.post(url, body: {
        'Pantalla': Pantalla,
        'id_medico': IDMedico,
        'id_info': IDInfo
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
              MaterialPageRoute(builder: (_) => RegistroMedOlvidaste()));
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

    Pantalla.text = 'FinSolicitar35';
    IDMedico.text = "$id_medico";
    IDInfo.text = "$id_info";
  }

  File? imagen = null;
  //ImagePicker picker = ImagePicker();
  final picker = ImagePicker();

  String _Base64 = "";
  String imagepath = "";

  Future selImagen(op) async {
    //var ImagePiker;
    var pickedFile;

    if (op == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
      print(pickedFile);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      print("***");
      print(pickedFile);
      print("***");
      if (pickedFile != null) {
        imagen = File(pickedFile.path);
        //cortar(File(pickedFile.path));
        print(imagen);

        /*try {
        var pickedFile = await picker.pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          print("OPcion 1");
          print(pickedFile);
          print("**");
          imagepath = pickedFile.path;
          File imagefile = File(imagepath); //convert Path to File
          Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
          String Archivo =
              base64.encode(imagebytes); 
          _Base64 = Archivo;

          print(_Base64);

          Uint8List decodedbytes = base64.decode(Archivo);

          setState(() {});
        } else {
          print("No image is selected.");
        }
      } catch (e) {
        print("error while picking file.");
      } */
      } else {
        print("no selecionaste ninguna foto");
      }
    });
    //print("llego aqui 2222");
    Navigator.of(context).pop();
  }

  /*cortar (picked) async {
    File? cortado=await ImageCropper.cropImage(
      sourcePath: picked.path,
      aspectRatio: CropAspectRatio(
        ratioX: 1.0, 
        ratioY: 1.0
      )
    );
    if(cortado!=null){
      setState(() {
        imagen=cortado
      });
    }
  }*/

  Dio dio = new Dio();
  Future<void> subir_imagen() async {
    try {
      String filename = imagen!.path.split('/').last;
      FormData formData = new FormData.fromMap({
        'usuario': 'id',
        'usuario2': 'id2cccccc',
        'file': await MultipartFile.fromFile(imagen!.path, filename: filename)
      });
      await dio
          .post('http://fasoluciones.mx/ApiApp/subirImagenJoss.php',
              data: formData)
          .then((value) {
        if (value.toString() == '1') {
          print("la foto se subio correctamente");
        } else {
          //print("Error");

          /*Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => FinRegMedico37()));
          FocusScope.of(context).unfocus();*/
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
                child: Column(
              children: [
                InkWell(
                  onTap: () {
                    selImagen(1);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey))),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Tomar una foto',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Icon(Icons.phone, color: Colors.blue)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    selImagen(2);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Seleccionar una foto',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Icon(Icons.image, color: Colors.blue)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.red),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Cancelar',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
          );
        });
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
                    headerTop("$id_medico $id_info", 'En desarrollo'),
                    _Pantalla(),
                    _IDMedico(),
                    _IDInfo(),
                    /*ElevatedButton(
                        onPressed: () {
                          opciones(context);
                        },
                        child: Text('Selecciona una imagen',
                            style: TextStyle(color: Colors.white))),

                    SizedBox(
                      height: 20,
                    ),
                    //imagen == null
                    //imagen==null ? Center()
                    imagen == null ? Center() : Image.file(imagen!),
                    ElevatedButton(
                        onPressed: () {
                          subir_imagen();
                        },
                        child: Text('Subir Imagen',
                            style: TextStyle(color: Colors.white)))
                    //_BotonEnviar(),*/
                  ]),
            )));
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

  Widget _IDMedico() {
    return Visibility(
        visible: false,
        child: Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: IDMedico,
            decoration: InputDecoration(
                labelText: 'IDMedico',
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

  Widget _BotonEnviar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              PantallaRecibe = Pantalla.text;
              IDMedicoRecibe = IDMedico.text;
              IDInfoRecibe = IDInfo.text;

              if (PantallaRecibe == "" ||
                  IDMedicoRecibe == "" ||
                  IDInfoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                Ingresar(PantallaRecibe, IDMedicoRecibe, IDInfoRecibe);
              }
            }
          },
          child: const Text('Siguiente')),
    );
  }
}
