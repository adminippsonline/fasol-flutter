import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../menu_lateral.dart';
import '../menu_footer.dart';

class RegistroSolOlvidaste extends StatefulWidget {
  const RegistroSolOlvidaste({super.key});

  @override
  State<RegistroSolOlvidaste> createState() => _RegistroSolOlvidasteState();
}

class _RegistroSolOlvidasteState extends State<RegistroSolOlvidaste> {
  final _keyForm = GlobalKey<_RegistroSolOlvidasteState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegistroSolOlvidaste'),
      ),
      drawer: MenuLateralPage(""),
      bottomNavigationBar: MenuFooterPage(),
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              // Navegamos a Home
              Navigator.pushNamed(context, "/RegMedico/FinRegMedico30_1");

              // si usas pushReplacementNamed la ruta nueva reemplaza la ruta actual.
              // Navigator.pushReplacementNamed(context, '/home');
            },
            child: const Text('Entrar')),
      ),
    );
  }
}
