import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FinSolicitar13 extends StatefulWidget {
  const FinSolicitar13({super.key});

  @override
  State<FinSolicitar13> createState() => _FinSolicitar13State();
}

class _FinSolicitar13State extends State<FinSolicitar13> {
  final _keyForm = GlobalKey<_FinSolicitar13State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinSolicitar13'),
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
