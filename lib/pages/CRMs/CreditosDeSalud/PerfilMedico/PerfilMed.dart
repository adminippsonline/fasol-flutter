import 'package:flutter/material.dart';

import 'includes/menu_lateral.dart';
import '../menu_footer.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PerfilMed extends StatefulWidget {
  const PerfilMed({super.key});

  @override
  State<PerfilMed> createState() => _PerfilMedState();
}

class _PerfilMedState extends State<PerfilMed> {
  final _keyForm = GlobalKey<_PerfilMedState>();

  //se usa para mostrar los datos del estado
  int id_medico = 0;
  int id_info = 0;
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
            child:
                Text("Bienvenido $id_medico $id_info  $NombreCompletoSession"),
          )
        ],
      ),
    );
  }

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
}
