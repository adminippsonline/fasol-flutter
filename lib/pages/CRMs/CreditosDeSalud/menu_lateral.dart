import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:page_transition/page_transition.dart';
import 'RegMedico/RegMedico.dart';
import 'RegClinica/RegClinica.dart';
import 'RegSolicitud/RegSolicitud.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'PerfilMedico/PerfilMedVerificar.dart';
import 'PerfilClinica/PerfilCliVerificar.dart';
import 'PerfilSolicitud/PerfilSolVerificar.dart';

import '../../CRMs/CreditosDeSalud/includes/colors/colors.dart';

import 'CerrarSesion.dart';

class MenuLateralPage extends StatefulWidget {
  String idCredito = "";
  MenuLateralPage(this.idCredito);

  @override
  State<MenuLateralPage> createState() => _MenuLateralPageState();
}

class _MenuLateralPageState extends State<MenuLateralPage> {
  int id_medico = 0;
  int id_clinica = 0;
  int id_solicitud = 0;
  int id_credito = 0;
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
      id_clinica = prefs.getInt('id_clinica') ?? 0;
      id_solicitud = prefs.getInt('id_solicitud') ?? 0;
      id_credito = prefs.getInt('id_credito') ?? 0;
    });
  }

  Widget build(BuildContext context) {
    if (id_medico >= 1) {
      return _DrawerMedico();
    } else if (id_clinica >= 1) {
      return _DrawerClinica();
    } else if (id_solicitud >= 1) {
      return _DrawerLR();
    } else {
      return _DrawerGeneral();
    }
  }

  Widget _DrawerGeneral() {
    return Container(
        child: Drawer(
            child: ListView(
      padding: EdgeInsets.all(0),
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 224, 224, 224),
          ),
          //accountName: Text("Fasol $id_credito medic $id_medico clinica $id_clinica LR $id_solicitud"),
          currentAccountPicture:
              Image.asset('assets/images/CRMs/CreditosDeSalud/LOGO_FASOL.png'),
          //Crédito y Préstamos Personales
          accountName: Text(
            "$id_credito medic $id_medico clinica $id_clinica LR $id_solicitud",
            style: TextStyle(
              fontSize: 12,
              color: const Color.fromARGB(255, 96, 96, 96),
            ),
          ),
          accountEmail: Text(''),
        ),
        ListTile(
          title: Text('Simulador de credito'),
          leading: Icon(Icons.calculate_outlined),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/CreditosDeSalud');
          },
        ),
        ListTile(
          title: Text('Usuarios'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/PerfilSolicitud/LoginSol');
          },
        ),
        ListTile(
          title: Text('Médicos'),
          leading: Icon(Icons.medical_information_outlined),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/PerfilMedico/LoginMed');
          },
        ),
        ListTile(
          title: Text('Clínicas'),
          leading: Icon(Icons.local_hospital_outlined),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/PerfilClinica/LoginCli');
          },
        ),
      ],
    )));
  }

  Widget _DrawerMedico() {
    return Container(
        child: Drawer(
            child: ListView(
      padding: EdgeInsets.all(0),
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Colors.amber,
          ),
          accountName: Text(
              "Fasol  $id_credito medic $id_medico clinica $id_clinica LR $id_solicitud"),
          accountEmail: Text('admin@fasol.com *****'),
          currentAccountPicture: Image.asset(
              'assets/images/CRMs/CreditosDeSalud/FasolFavicon.png'),
        ),
        ListTile(
          title: new Center(
              child: new Text(
            "Entrar a mi perfil de médico",
            style: new TextStyle(fontSize: 12.0),
          )),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PerfilMedVerificar()));
          },
        ),
        _BotonCerrarSesion(),
      ],
    )));
  }

  Widget _DrawerClinica() {
    return Container(
        child: Drawer(
            child: ListView(
      padding: EdgeInsets.all(0),
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Colors.amber,
          ),
          accountName: Text(
              "Fasol $id_credito medic $id_medico clinica $id_clinica LR $id_solicitud"),
          accountEmail: Text('admin@fasol.com *****'),
          currentAccountPicture: Image.asset(
              'assets/images/CRMs/CreditosDeSalud/FasolFavicon.png'),
        ),
        ListTile(
          title: new Center(
              child: new Text(
            "Entrar a mi perfil de clínica",
            style: new TextStyle(fontSize: 12.0),
          )),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PerfilCliVerificar()));
          },
        ),
        _BotonCerrarSesion(),
      ],
    )));
  }

  Widget _DrawerLR() {
    return Container(
        child: Drawer(
            child: ListView(
      padding: EdgeInsets.all(0),
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Colors.amber,
          ),
          accountName: Text(
              "Fasol $id_credito medic $id_medico clinica $id_clinica LR $id_solicitud"),
          accountEmail: Text('admin@fasol.com *****'),
          currentAccountPicture: Image.asset(
              'assets/images/CRMs/CreditosDeSalud/FasolFavicon.png'),
        ),
        ListTile(
          title: new Center(
              child: new Text(
            "Entrar a mi perfil de solicitante",
            style: new TextStyle(fontSize: 12.0),
          )),
          onTap: () {
            dev.log("aqui entro menu lateral");
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PerfilSolVerificar(widget.idCredito)));
          },
        ),
        _BotonCerrarSesion(),
      ],
    )));
  }

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
