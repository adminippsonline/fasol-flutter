import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FinClinicas11 extends StatefulWidget {
  const FinClinicas11({super.key});

  @override
  State<FinClinicas11> createState() => _FinClinicas11State();
}

class _FinClinicas11State extends State<FinClinicas11> {
  final _keyForm = GlobalKey<_FinClinicas11State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('/RegClinica/FinClinicas11'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              // Navegamos a Home
              Navigator.pushNamed(context, "/RegClinica/FinClinicas11");

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
