import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FinClinicas13 extends StatefulWidget {
  const FinClinicas13({super.key});

  @override
  State<FinClinicas13> createState() => _FinClinicas13State();
}

class _FinClinicas13State extends State<FinClinicas13> {
  final _keyForm = GlobalKey<_FinClinicas13State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('/RegClinica/FinClinicas13'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              // Navegamos a Home
              Navigator.pushNamed(context, "/RegClinica/FinClinicas13");

              // si usas pushReplacementNamed la ruta nueva reemplaza la ruta actual.
              // Navigator.pushReplacementNamed(context, '/home');
            },
            child: const Text('Entrar')),
      ),
    );
  }
  /*Widget _Avanzar() {
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
              MaterialPageRoute(builder: (context) => FinRegMedico31()));
        },
      ),
    );
  }*/
}
