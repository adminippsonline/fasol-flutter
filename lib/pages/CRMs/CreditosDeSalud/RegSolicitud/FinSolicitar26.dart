import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FinSolicitar26 extends StatefulWidget {
  const FinSolicitar26({super.key});

  @override
  State<FinSolicitar26> createState() => _FinSolicitar26State();
}

class _FinSolicitar26State extends State<FinSolicitar26> {
  final _keyForm = GlobalKey<_FinSolicitar26State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinSolicitar26'),
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
