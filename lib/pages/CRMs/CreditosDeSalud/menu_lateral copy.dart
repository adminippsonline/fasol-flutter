import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'RegMedico/RegMedico.dart';
import 'RegClinica/RegClinica.dart';
import 'RegSolicitud/RegSolicitud.dart';
import 'package:url_launcher/url_launcher.dart';


import 'package:shared_preferences/shared_preferences.dart';


import 'CerrarSesion.dart';

class MenuLateralPage extends StatefulWidget {
  const MenuLateralPage({super.key});

  @override
  State<MenuLateralPage> createState() => _MenuLateralPageState();
}

class _MenuLateralPageState extends State<MenuLateralPage> {
  @override
  //final Uri _url = Uri.parse("http://fasoluciones.mx/PerfilMedico/");


  int id_medico = 0;
  int id_clinica = 0;
  int id_LR = 0;
  int id_info = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String TelefonoSession = "";

  void mostrar_datos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      NombreCompletoSession = prefs.getString('NombreCompletoSession') ?? 'vacio';
      id_medico = prefs.getInt('id_medico') ?? 0;
      id_clinica = prefs.getInt('id_clinica') ?? 0;
      id_LR = prefs.getInt('id_LR') ?? 0;
      id_info = prefs.getInt('id_info') ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    mostrar_datos();
  }

  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.all(0),
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Colors.amber,
          ),
          accountName: Text("Fasol"),
          accountEmail: Text('admin@fasol.com'),
          currentAccountPicture: Image.asset(
              'assets/images/CRMs/CreditosDeSalud/FasolFavicon.png'),

          /*currentAccountPicture: new Container(
            margin: const EdgeInsets.only(bottom: 40.0),
            width: 10.0,
            height: 10.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(
                  "assets/images/CRMs/CreditosDeSalud/LogoPerfilFasol.png",
                ),
              ),
            ),
          ),*/
        ),
        ListTile(
          title: Text('Solicitud de crédito'),
          leading: Icon(Icons.start),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/CreditosDeSalud');
          },
        ),
        ListTile(
          title: Text('Perfil de solicitante'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/RegSolicitud');
          },
        ),
        ListTile(
          title: Text('Perfil de Médicos'),
          leading: Icon(Icons.heart_broken_sharp),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/RegMedico');
          },
        ),

        

        /*ListTile(
          title: Text('Médicos pantalla 36'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/RegMedico/FinRegMedico36');
          },
        ),
        ListTile(
          title: Text('Médicos pantalla 35'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/RegMedico/FinRegMedico35');
          },
        ),*/
        ListTile(
          title: Text('Perfil de Clínicas'),
          leading: Icon(Icons.home),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/RegClinica');

            /*Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: RegMedico()));*/
          },
        ),

        ListTile( 
          title: Text('Salir'),
          leading: Icon(Icons.heart_broken_sharp),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/CerrarSesion');
          },
        ),

        _BotonCerrarSesion(),

        ////////////////////////
        //ElevatedButton(onPressed: _launcUrl, child: Text("mostrar link")),
        ////////////////////////

        /*ListTile(
          title: Text('Perfil medico ***ººº ññññ'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/PerfilMedico/PerfilMedWebView');

            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: RegMedico()));
          },
        ),*/
      ],
    ));
  }

  /*Future<void> _launcUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('coul no lan $_url');
    }
  }*/

  Widget _BotonCerrarSesion() {
    return Container(
      width: double.infinity,
      //padding: EdgeInsets.all(10),
      child: ListTile(
        title: new Center(
            child: new Text(
          "Salir",
          style: new TextStyle(fontSize: 12.0),
        )),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CerrarSesion()));
        },
      ),
    );
  }
}
