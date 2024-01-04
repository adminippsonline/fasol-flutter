import 'package:flutter/material.dart';

import 'includes/menu_lateral.dart';
import '../menu_footer.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PerfilSol extends StatefulWidget {
  const PerfilSol({super.key});

  @override
  State<PerfilSol> createState() => _PerfilSolState();
}

class _PerfilSolState extends State<PerfilSol> {
  final _keyForm = GlobalKey<_PerfilSolState>();

  //se usa para mostrar los datos del estado
  String id_LR = "";
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
            child: Text("Bienvenido $id_LR  $NombreCompletoSession"),
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
      id_LR = prefs.getString('id_LR') ?? 'vacio';
    });
  }
}
