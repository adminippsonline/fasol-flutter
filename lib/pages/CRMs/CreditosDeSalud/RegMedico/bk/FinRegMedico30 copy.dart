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

import '../FinRegMedico30_1.dart';

class FinRegMedico30 extends StatefulWidget {
  const FinRegMedico30({super.key});

  @override
  State<FinRegMedico30> createState() => _FinRegMedico30State();
}

class _FinRegMedico30State extends State<FinRegMedico30> {
  final PrimerNombre = TextEditingController();
  final SegundoNombre = TextEditingController();
  final PrimerApellido = TextEditingController();
  final SegundoApellido = TextEditingController();
  final Genero = TextEditingController();
  final FechaDeNacimiento = TextEditingController();
  final PaisDeNacimiento = TextEditingController();
  final EstadoDeNacimiento = TextEditingController();
  final Nacionalidad = TextEditingController();
  final CURP = TextEditingController();
  final RFC = TextEditingController();
  final EstadoCivil = TextEditingController();
  final NivelAcademico = TextEditingController();
  final _keyForm = GlobalKey<_FinRegMedico30State>();

  String PrimerNombreRecibe = "";
  String SegundoNombreRecibe = "";
  String PrimerApellidoRecibe = "";
  String SegundoApellidoRecibe = "";
  String GeneroRecibe = "";
  String FechaDeNacimientoRecibe = "";
  String PaisDeNacimientoRecibe = "";
  String EstadoDeNacimientoRecibe = "";
  String NacionalidadRecibe = "";
  String CURPRecibe = "";
  String RFCRecibe = "";
  String EstadoCivilRecibe = "";
  String NivelAcademicoRecibe = "";

  void Ingresar(
      PrimerNombre,
      SegundoNombre,
      PrimerApellido,
      SegundoApellido,
      Genero,
      FechaDeNacimiento,
      PaisDeNacimiento,
      EstadoDeNacimiento,
      Nacionalidad,
      CURP,
      RFC,
      EstadoCivil,
      NivelAcademico) async {
    try {
      var url = Uri.https('fasoluciones.mx', 'ApiApp/Medico/Actualizar.php');
      var response = await http.post(url, body: {
        'PrimerNombre': PrimerNombre,
        'SegundoNombre': SegundoNombre,
        'PrimerApellido': PrimerApellido,
        'SegundoApellido': SegundoApellido,
        'FechaDeNacimiento': FechaDeNacimiento,
        'Genero': Genero,
        'PaisDeNacimiento': PaisDeNacimiento,
        'EstadoDeNacimiento': EstadoDeNacimiento,
        'Nacionalidad': Nacionalidad,
        'CURP': CURP,
        'RFC': RFC,
        'EstadoCivil': EstadoCivil,
        'NivelAcademico': NivelAcademico,
      }).timeout(const Duration(seconds: 90));
      print(response.body);

      if (response.body == "Exito") {
        print('si existe');
        //guardar_datos("10", "enrique", "tel:34543", "Direccion:antonio oe");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => FinRegMedico30_1()));
        FocusScope.of(context).unfocus();
      } else {
        print('Error de actualizacion');
      }
    } on TimeoutException catch (e) {
      print('Tardo muco la conexion');
    } on Error catch (e) {
      print('http error');
    }
  }

  //Esto es iun metodo
  //se usa para guarar dtos es tipo sesiones
  /*Future<void> guardar_datos(id, nombre, telefono, direccion) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(id, id);
    await prefs.setString(nombre, nombre);
    await prefs.setString(telefono, telefono);
    await prefs.setString(direccion, direccion);
  }*/

  //Esto es un metodo
  //se usa para mostrar los datos del estado
  String id = "";
  String nombre = "";
  String telefono = "";
  String direccion = "";
  Future<void> mostrar_datos() async {
    //Se necesitan crear unas variables

    print("aqui vamos");
    // .clear es para eliminar la sesiones
    //prefs.clear();

    var url = Uri.https('fasoluciones.mx', 'ApiApp/LoginCampos.php');
    var response = await http.post(url, body: {
      'Pantalla': '2',
    }).timeout(const Duration(seconds: 90));
    print(response.body);
  }

  //Pra pintar datos initState() es un estado es como sesiones valida que haya sesiones, si exite te redirecciona al ligin
  @override
  void initState() {
    super.initState();
    mostrar_datos();
  }

  @override
  Widget build(BuildContext context) {
    final tituloPrincipal = "Información personal fvvvfvf";
    return Scaffold(
      appBar: AppBar(
        title: Text(tituloPrincipal),
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
                  headerTop(tituloPrincipal, ''),

                  //texbox("desde el metodo"),

                  _PrimerNombre(),
                  _SegundoNombre(),
                  _PrimerApellido(),
                  _SegundoApellido(),
                  _Genero(),
                  _FechaDeNacimiento(),
                  _PaisDeNacimiento(),
                  _EstadoDeNacimiento(),
                  _Nacionalidad(),
                  _CURP(),
                  _RFC(),
                  _EstadoCivil(),
                  _NivelAcademico(),

                  SizedBox(
                    height: 20,
                  ),

                  _BotonEnviar(),
                ])),
      ))),
    );
  }

  Widget _PrimerNombre() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: PrimerNombre,
        decoration: InputDecoration(
            labelText: 'PrimerNombre',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _SegundoNombre() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: SegundoNombre,
        decoration: InputDecoration(
            labelText: 'SegundoNombre',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _PrimerApellido() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: PrimerApellido,
        decoration: InputDecoration(
            labelText: 'PrimerApellido',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _SegundoApellido() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: SegundoApellido,
        decoration: InputDecoration(
            labelText: 'SegundoApellido',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Genero() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: Genero,
        decoration: InputDecoration(
            labelText: 'Genero',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _FechaDeNacimiento() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: FechaDeNacimiento,
        decoration: InputDecoration(
            labelText: 'FechaDeNacimiento',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _PaisDeNacimiento() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: PaisDeNacimiento,
        decoration: InputDecoration(
            labelText: 'PaisDeNacimiento',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _EstadoDeNacimiento() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: EstadoDeNacimiento,
        decoration: InputDecoration(
            labelText: 'EstadoDeNacimiento',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _Nacionalidad() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: Nacionalidad,
        decoration: InputDecoration(
            labelText: 'Nacionalidad',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _CURP() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: CURP,
        decoration: InputDecoration(
            labelText: 'CURP',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _RFC() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: RFC,
        decoration: InputDecoration(
            labelText: 'RFC',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _EstadoCivil() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: EstadoCivil,
        decoration: InputDecoration(
            labelText: 'EstadoCivil',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }

  Widget _NivelAcademico() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: NivelAcademico,
        decoration: InputDecoration(
            labelText: 'NivelAcademico',
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
            PrimerNombreRecibe = PrimerNombre.text;
            SegundoNombreRecibe = SegundoNombre.text;
            PrimerApellidoRecibe = PrimerApellido.text;
            SegundoApellidoRecibe = SegundoApellido.text;
            GeneroRecibe = Genero.text;
            FechaDeNacimientoRecibe = FechaDeNacimiento.text;
            PaisDeNacimientoRecibe = PaisDeNacimiento.text;
            EstadoDeNacimientoRecibe = EstadoDeNacimiento.text;
            NacionalidadRecibe = Nacionalidad.text;
            CURPRecibe = CURP.text;
            RFCRecibe = RFC.text;
            EstadoCivilRecibe = EstadoCivil.text;
            NivelAcademicoRecibe = NivelAcademico.text;

            if (PrimerNombreRecibe != "" ||
                PrimerApellidoRecibe != "" ||
                SegundoApellidoRecibe != "" ||
                GeneroRecibe != "" ||
                FechaDeNacimientoRecibe != "" ||
                PaisDeNacimientoRecibe != "" ||
                EstadoDeNacimientoRecibe != "" ||
                NacionalidadRecibe != "" ||
                CURPRecibe != "" ||
                RFCRecibe != "" ||
                EstadoCivilRecibe != "" ||
                NivelAcademicoRecibe != "") {
              Ingresar(
                  PrimerNombreRecibe,
                  SegundoNombreRecibe,
                  PrimerApellidoRecibe,
                  SegundoApellidoRecibe,
                  GeneroRecibe,
                  FechaDeNacimientoRecibe,
                  PaisDeNacimientoRecibe,
                  EstadoDeNacimientoRecibe,
                  NacionalidadRecibe,
                  CURPRecibe,
                  RFCRecibe,
                  EstadoCivilRecibe,
                  NivelAcademicoRecibe);
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
            //print(CorreoRecibe + ' ' + ContrasenaRecibe);
            // si usas pushReplacementNamed la ruta nueva reemplaza la ruta actual.
            // Navigator.pushReplacementNamed(context, '/home');
            //Correo.text = "";
            //Contrasena.text = "";
          },
          child: const Text('Entrar')),
    );
  }
}
