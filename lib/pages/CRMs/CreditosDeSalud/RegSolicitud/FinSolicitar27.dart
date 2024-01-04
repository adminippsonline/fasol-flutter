import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FinSolicitar27 extends StatefulWidget {
  const FinSolicitar27({super.key});

  @override
  State<FinSolicitar27> createState() => _FinSolicitar27State();
}

class _FinSolicitar27State extends State<FinSolicitar27> {
  final _keyForm = GlobalKey<_FinSolicitar27State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinSolicitar27'),
      ),
      backgroundColor: Colors.white,
      body: Center(),
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
