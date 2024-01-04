import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FinSolicitar25_1 extends StatefulWidget {
  const FinSolicitar25_1({super.key});

  @override
  State<FinSolicitar25_1> createState() => _FinSolicitar25_1State();
}

class _FinSolicitar25_1State extends State<FinSolicitar25_1> {
  final _keyForm = GlobalKey<_FinSolicitar25_1State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinSolicitar25_1'),
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
