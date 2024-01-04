import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Includes/widgets/build_screen.dart';
import '../home_page.dart';

class FinClinicas18 extends StatefulWidget {
  const FinClinicas18({super.key});

  @override
  State<FinClinicas18> createState() => _FinClinicas18State();
}

class _FinClinicas18State extends State<FinClinicas18> {
  final _keyForm = GlobalKey<_FinClinicas18State>();

  @override
  Widget build(BuildContext context) { 
    return BuildScreens(
        '/RegClinica/FinClinicas18', '', '', 'Clinicas', '', _formulario());
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('/RegClinica/FinClinicas18'),
    //   ),
    //   backgroundColor: Colors.white,
    //   body:
    // );
  }

  Widget _formulario() {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            // Navegamos a Home
            //Navigator.pushNamed(context, "/RegClinica/FinClinicas18");

            // si usas pushReplacementNamed la ruta nueva reemplaza la ruta actual.
            // Navigator.pushReplacementNamed(context, '/home');

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePageCreditosDeSalud()));
          },
          child: const Text('Entrar')),
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
