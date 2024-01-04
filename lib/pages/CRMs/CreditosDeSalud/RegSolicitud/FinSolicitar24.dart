import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FinSolicitar24 extends StatefulWidget {
  const FinSolicitar24({super.key});

  @override
  State<FinSolicitar24> createState() => _FinSolicitar24State();
}

class _FinSolicitar24State extends State<FinSolicitar24> {
  final _keyForm = GlobalKey<_FinSolicitar24State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinSolicitar24'),
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
