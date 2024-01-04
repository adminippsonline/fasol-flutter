import 'package:flutter/material.dart';

import 'includes/menu_lateral.dart';
import '../menu_footer.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PerfilCli extends StatefulWidget {
  const PerfilCli({super.key});

  @override
  State<PerfilCli> createState() => _PerfilCliState();
}

class _PerfilCliState extends State<PerfilCli> {
  final _keyForm = GlobalKey<_PerfilCliState>();

  //se usa para mostrar los datos del estado
  String id_clinica = "";
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String TelefonoSession = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$NombreCompletoSession"),
        backgroundColor: Color.fromARGB(255, 241, 152, 17),
      ),
      drawer: MenuLateralPage(),
      bottomNavigationBar: MenuFooterPage(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text("Bienvenido $id_clinica  $NombreCompletoSession"),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  void getName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      NombreCompletoSession =
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      id_clinica = prefs.getString('id_clinica') ?? 'vacio';
    });
  }
}
