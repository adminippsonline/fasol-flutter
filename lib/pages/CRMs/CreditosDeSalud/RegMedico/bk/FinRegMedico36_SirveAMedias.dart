import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

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
import 'package:email_validator/email_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'FinRegMedico36_sui_imagen_no_irve.dart';

import 'package:intl/intl.dart';
import 'dart:io';

class FinRegMedico36 extends StatefulWidget {
  const FinRegMedico36({super.key});

  @override
  State<FinRegMedico36> createState() => _FinRegMedico36State();
}

class _FinRegMedico36State extends State<FinRegMedico36> {
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
      body: const MyCustomFormFinRegMedico36(),
    );
  }
}

// Create a Form widget.
class MyCustomFormFinRegMedico36 extends StatefulWidget {
  const MyCustomFormFinRegMedico36({super.key});

  @override
  MyCustomFormFinRegMedico36State createState() {
    return MyCustomFormFinRegMedico36State();
  }
}

class MyCustomFormFinRegMedico36State
    extends State<MyCustomFormFinRegMedico36> {
  //el fomrKey para formulario
  final _formKey = GlobalKey<FormState>();

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDMedico = TextEditingController();
  final IDInfo = TextEditingController();
  String imagenForm = "";
  String PantallaRecibe = "";
  String IDMedicoRecibe = "";
  String IDInfoRecibe = "";
  String ImagenRecibe = "";
  String ArchivoRecibe = "";

  void Ingresar(Pantalla, IDMedico, IDInfo, Archivo) async {
    try {
      print("lego aqui");
      var url = Uri.https('fasoluciones.mx', 'ApiApp/Medico/Actualizar.php');
      var data = {
        'Pantalla': Pantalla,
        'id_medico': IDMedico,
        'id_info': IDInfo,
        'file': '$Archivo'
      };
      print(data);
      var response =
          await http.post(url, body: data).timeout(const Duration(seconds: 90));
      print("llego aqui 111");
      print(response.body);

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
              MaterialPageRoute(builder: (_) => FinRegMedico36()));
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

  final ImagePicker imgpicker = ImagePicker();
  String _Base64 = "";
  String imagepath = "";

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

    Pantalla.text = 'FinSolicitar36';
    IDMedico.text = "$id_medico";
    IDInfo.text = "$id_info";
  }

  File? imageSelect;
  final _imagePicker = ImagePicker();

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
                    headerTop(
                        "$id_medico $id_info", ' Aqu van los servicos de'),
                    _Pantalla(),
                    _IDMedico(),
                    _IDInfo(),
                    imageSelect == null
                        ? AspectRatio(
                            aspectRatio: 1.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image),
                                Text('No imagen seleccioada')
                              ],
                            ))
                        : AspectRatio(
                            aspectRatio: 1.5,
                            child: Image.file(File(imageSelect!.path)),
                          ),
                    Column(
                      children: [
                        ElevatedButton(
                          child: const Text("imagen de camara"),
                          onPressed: () {
                            print("se presiono camara");
                            pickImageCamara();
                          },
                        ),
                        ElevatedButton(
                          child: const Text("imagen de galería"),
                          onPressed: () {
                            pickImageGallery();
                            print("se presiono galeria");
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    /*ElevatedButton(
                        onPressed: () {
                          subir_imagen();
                        },
                        child: Text('Selecciona una imagen',
                            style: TextStyle(color: Colors.white)))*/
                    _BotonEnviar(),
                  ]),
            )));
  }

  pickImageCamara() async {
    /*final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        imageSelect = File(image.path);
        print("se preiono camara");
        print(imageSelect);
        
      });
    }*/
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.camera);
      /*final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera);*/
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        imageSelect = File(imagepath);
        //print(imagepath);
        //output /data/user/0/com.example.testapp/cache/image_picker7973898508152261600.jpg

        File imagefile = File(imagepath); //convert Path to File
        Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
        String Archivo =
            base64.encode(imagebytes); //convert bytes to base64 string
        print(Archivo);
        _Base64 = Archivo;
        /* Output:
              /9j/4Q0nRXhpZgAATU0AKgAAAAgAFAIgAAQAAAABAAAAAAEAAAQAAAABAAAJ3
              wIhAAQAAAABAAAAAAEBAAQAAAABAAAJ5gIiAAQAAAABAAAAAAIjAAQAAAABAAA
              AAAIkAAQAAAABAAAAAAIlAAIAAAAgAAAA/gEoAA ... long string output
              */

        Uint8List decodedbytes = base64.decode(Archivo);
        //decode base64 stirng to bytes

        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  pickImageGallery() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        imageSelect = File(imagepath);
        //print(imagepath);
        //output /data/user/0/com.example.testapp/cache/image_picker7973898508152261600.jpg

        File imagefile = File(imagepath); //convert Path to File
        Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
        String Archivo =
            base64.encode(imagebytes); //convert bytes to base64 string
        print(Archivo);
        _Base64 = Archivo;
        /* Output:
              /9j/4Q0nRXhpZgAATU0AKgAAAAgAFAIgAAQAAAABAAAAAAEAAAQAAAABAAAJ3
              wIhAAQAAAABAAAAAAEBAAQAAAABAAAJ5gIiAAQAAAABAAAAAAIjAAQAAAABAAA
              AAAIkAAQAAAABAAAAAAIlAAIAAAAgAAAA/gEoAA ... long string output
              */

        Uint8List decodedbytes = base64.decode(Archivo);
        //decode base64 stirng to bytes

        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
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
              //print(PantallaRecibe);
              IDMedicoRecibe = IDMedico.text;
              //print(IDMedicoRecibe);
              IDInfoRecibe = IDInfo.text;
              //print(IDInfoRecibe);

              ArchivoRecibe = _Base64;
              //print(ArchivoRecibe);
              //ArchivoRecibe = "hola";

              /*print("---");
              print(file);
              print("---");*/
              if (PantallaRecibe == "" ||
                  IDMedicoRecibe == "" ||
                  IDInfoRecibe == "" ||
                  ArchivoRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                Ingresar(PantallaRecibe, IDMedicoRecibe, IDInfoRecibe,
                    ArchivoRecibe);
              }
            }
          },
          child: const Text('Siguiente')),
    );
  }
}
