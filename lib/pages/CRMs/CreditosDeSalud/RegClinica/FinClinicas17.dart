import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FinClinicas17 extends StatefulWidget {
  const FinClinicas17({super.key});

  @override
  State<FinClinicas17> createState() => _FinClinicas17State();
}

class _FinClinicas17State extends State<FinClinicas17> {
  final _keyForm = GlobalKey<_FinClinicas17State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('/RegClinica/FinClinicas17'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              // Navegamos a Home
              Navigator.pushNamed(
                  context, "/RegClinica/FinClinicas17adicional");

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
