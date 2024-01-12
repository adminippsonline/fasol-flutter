import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

//import 'FinRegMedico36_sui_imagen_no_irve.dart';

import 'FinRegMedico38.dart';

import 'package:intl/intl.dart';
import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:dio/dio.dart';

class FinRegMedico36 extends StatefulWidget {
  const FinRegMedico36({super.key});

  @override
  State<FinRegMedico36> createState() => _FinRegMedico36State();
}

class _FinRegMedico36State extends State<FinRegMedico36> {
  //se usa para mostrar los datos del estado
  int id_medico = 0;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomFormFinRegMedico36();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(NombreCompletoSession),
    //   ),
    //   drawer: MenuLateralPage(),
    //   bottomNavigationBar: MenuFooterPage(),
    //   body: const MyCustomFormFinRegMedico36(),
    // );
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

  String? OpcionesTipoComprobante;

  //Los controladores para los input
  final Pantalla = TextEditingController();
  final IDMedico = TextEditingController();
  final TipoComprobante = TextEditingController();

  String PantallaRecibe = "";
  String IDMedicoRecibe = "";
  String TipoComprobanteRecibe = "";

  void Ingresar(Pantalla, IDMedico, TipoComprobante, imagen) async {
    dev.log(Pantalla);
    dev.log(IDMedico);
    dev.log(TipoComprobante);
    try {
      var url = Uri.https('fasoluciones.mx', 'api/Medico/Agregar');
      var data = {
        'Pantalla': Pantalla,
        'id_medico': IDMedico,
        'TipoComprobante': TipoComprobante,
        'ComprobanteImagen': imagen
      };
      //print(data);
      var response = await http.post(url, body: data);
      //print("llego aqui 111");
      dev.log(response.body);

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
              MaterialPageRoute(builder: (_) => FinRegMedico38()));
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
    });

    Pantalla.text = 'FinSolicitar36';
    IDMedico.text = "$id_medico";
  }

  File? imagen = null;
  //ImagePicker picker = ImagePicker();
  final picker = ImagePicker();

  String _Base64 = "";

  String? imagePath;

  var globalimageUpdate = "";
  Future selImagen(op) async {
    //var ImagePiker;
    var pickedFile;

    if (op == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
      print(pickedFile);
    } else {
      // pickedFile = await picker.pickImage(source: ImageSource.gallery);
      final ImagePicker _picker = ImagePicker();
      XFile? _pickedFile = await _picker.pickImage(
          source: ImageSource.gallery, requestFullMetadata: false);
      imagePath = _pickedFile!.path;
      imagen = File(_pickedFile.path);
      _pickedFile.readAsBytes().then((value) {
        imagePath = _pickedFile.path;
      });
      setState(() {
        imagePath = _pickedFile.path;
        imagen = File(_pickedFile.path);
        final bytes = File(imagePath!).readAsBytesSync();
        dev.log(bytes.toString());
        globalimageUpdate = base64Encode(bytes);
      });
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
  Future<void> subir_imagen(TipoComprobante) async {
    try {
      print("***************************");
      print("llego aqui******");
      String filename = imagen!.path.split('/').last;
      print("....");
      print(Pantalla);
      print("....");
      print(IDMedico);
      print("....");

      final req = {
        'Pantalla': "FinSolicitar36",
        'id_medico': "$id_medico",
        'file': globalimageUpdate,
        'TipoComprobante': TipoComprobante
      };
      print(req);
      var url = Uri.https('fasoluciones.mx', 'api/Medico/Agregar');
      var request = await http.MultipartRequest('POST', url);
      request = jsonToFormData(request, req);
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      var responseString = responseData;
      final datos = json.decode(responseString);
      dev.log("datosasasas");
      dev.log(datos.toString());

      // if (imagen == null) {
      //   dev.log("esta vacio");
      //   dev.log(globalimageUpdate.toString());
      //   showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           title: Text('Por favor selecciona una imagen'),
      //         );
      //       });
      // } else {
      //   dev.log("tiene imagen");
      //   // Navigator.of(context).pushReplacement(
      //   //     MaterialPageRoute(builder: (_) => FinRegMedico38()));
      // }

      // await dio
      //     .post('http://fasoluciones.mx/ApiApp/Medico/Actualizar.php',
      //         data: formData)
      //     .then((value) {
      //   print("+++");
      //   print(value);
      //   print("+++");
      //   if (value.toString() == '1') {
      //     print("la foto se subio correctamente");
      //     Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (_) => FinRegMedico38()));
      //     FocusScope.of(context).unfocus();
      //   } else {
      //     print("Error");

      //     Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (_) => FinRegMedico38()));
      //     FocusScope.of(context).unfocus();
      //   }
    } catch (e) {
      print(e.toString());
    }
  }

  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
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
                        Icon(Icons.camera, color: Colors.blue)
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
    return BuildScreens('${NombreCompletoSession}', '', '',
        'Información Personal', '', _formulario());
  }

  String? _opcionesComprobante;
  bool _siEsConIne = false;

  int selectedOption = 0;

  void SeleccionadoEstadoCivil(value) {
    setState(() {
      print(value);
      _opcionesComprobante = value;
      _siEsConIne = value == "Mi domicilio coincide con el de la INE";
    });
  }

  Widget _formulario() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // headerTop("Médicos", 'Comprobante de domiciolio particular **'),
                SubitleCards('Comprobante de domicilio particular'),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "*****Por favor, adjunta tu comprobante  de domicilio con una vigencia no mayor a 3 meses",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: const Text('Mi domicilio coincide con la INE ****'),
                  leading: Radio(
                    value: "MismoINE",
                    groupValue: OpcionesTipoComprobante,
                    onChanged: (value) {
                      setState(() {
                        OpcionesTipoComprobante = value!;
                      });
                    },
                  ),
                ),

                ListTile(
                  title: const Text('CFE'),
                  leading: Radio(
                    value: "CFE",
                    groupValue: OpcionesTipoComprobante,
                    onChanged: (value) {
                      setState(() {
                        OpcionesTipoComprobante = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Telefonía'),
                  leading: Radio(
                    value: "Telefonia",
                    groupValue: OpcionesTipoComprobante,
                    onChanged: (value) {
                      setState(() {
                        OpcionesTipoComprobante = value!;
                      });
                    },
                  ),
                ),

                if (OpcionesTipoComprobante == "CFE" ||
                    OpcionesTipoComprobante ==
                        "Telefonia") // Mostrar el botón si se selecciona la opción 1
                  ElevatedButton(
                      onPressed: () {
                        opciones(context);
                      },
                      child: Text('Selecciona una imagen',
                          style: TextStyle(color: Colors.white))),

                _Pantalla(),
                _IDMedico(),

                SizedBox(
                  height: 20,
                ),
                //imagen == null
                //imagen==null ? Center()
                imagen == null ? Center() : Image.file(imagen!),
                if (imagen != null)
                  ElevatedButton(
                      onPressed: () {
                        //  subir_imagen(OpcionesTipoComprobante);
                        IDMedicoRecibe = IDMedico.text;
                        PantallaRecibe = Pantalla.text;
                        TipoComprobanteRecibe = TipoComprobante.text;
                        Ingresar(PantallaRecibe, IDMedicoRecibe,
                            OpcionesTipoComprobante, globalimageUpdate);
                      },
                      child: Text('Subir Imagen',
                          style: TextStyle(color: Colors.white))),
                if (OpcionesTipoComprobante == "MismoINE") _BotonEnviar(),
                /*ElevatedButton(
                      onPressed: () {
                        // subir_imagen();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => FinRegMedico38()));
                      },
                      child: Text("Continuar")),*/
                _Avanzar()
              ]),
        ));
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

  Widget _BotonEnviar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              PantallaRecibe = Pantalla.text;
              IDMedicoRecibe = IDMedico.text;

              String? TipoComprobanteRecibe = OpcionesTipoComprobante;
              print(TipoComprobanteRecibe);
              if (TipoComprobanteRecibe == "" ||
                  TipoComprobanteRecibe == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('El tipo de comprobante es obligatorio'),
                      );
                    });
              }

              print("hola");

              if (PantallaRecibe == "" ||
                  IDMedicoRecibe == "" ||
                  TipoComprobanteRecibe == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error: Todos los campos son obligatorios'),
                      );
                    });
              } else {
                Ingresar(PantallaRecibe, IDMedicoRecibe, TipoComprobanteRecibe,
                    globalimageUpdate);
              }
            }
          },
          child: const Text('Siguiente')),
    );
  }

  Widget _Avanzar() {
    return Container(
      width: double.infinity,
      //padding: EdgeInsets.all(10),
      child: ListTile(
        title: new Center(
            child: new Text(
          "Avanzar",
          style: new TextStyle(fontSize: 12.0),
        )),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FinRegMedico38()));
        },
      ),
    );
  }
}
