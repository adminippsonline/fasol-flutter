import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FinSolicitar25 extends StatefulWidget {
  const FinSolicitar25({super.key});

  @override
  State<FinSolicitar25> createState() => _FinSolicitar25State();
}

class _FinSolicitar25State extends State<FinSolicitar25> {
  final _keyForm = GlobalKey<_FinSolicitar25State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinSolicitar25'),
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
