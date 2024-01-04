import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../menu_lateral.dart';
import '../menu_footer.dart';
import '../Includes/colors/colors.dart';

class RegSolicitud extends StatefulWidget {
  const RegSolicitud({super.key});

  @override
  State<RegSolicitud> createState() => _RegSolicitudState();
}

class _RegSolicitudState extends State<RegSolicitud> {
  //TextStyle EstiloBotones = TextStyle(color: Colors.amber);

  final _keyForm = GlobalKey<_RegSolicitudState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_PRINCIPAL,
        title: const Text('Registro solicitud '),
      ),
      drawer: MenuLateralPage(),
      bottomNavigationBar: MenuFooterPage(),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(50),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 1,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/PerfilSolicitud/LoginSol");
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 248, 247, 247),
                foregroundColor: Color.fromARGB(255, 231, 231, 231),
                elevation: 0,
                side: const BorderSide(
                  width: 1.0,
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
            child: Container(
              height: 250.0,
              width: 250.0,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/images/CRMs/CreditosDeSalud/LoginSolicitud.png'),
                  ),
                  /*borderRadius: BorderRadius.all(Radius.circular(50.0)),*/
                  shape: BoxShape.rectangle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color.fromARGB(96, 221, 220, 220),
                      blurRadius: 15.0,
                      //offset: Offset(0.0, 7.0)
                    )
                  ]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/RegSolicitud/RegistroSol");
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 248, 247, 247),
                foregroundColor: Color.fromARGB(255, 231, 231, 231),
                elevation: 0,
                side: const BorderSide(
                  width: 1.0,
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
            child: Container(
              height: 250.0,
              width: 250.0,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/images/CRMs/CreditosDeSalud/RegistroSolicitud.png')),
                  /*borderRadius: BorderRadius.all(Radius.circular(50.0)),*/
                  shape: BoxShape.rectangle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color.fromARGB(96, 221, 220, 220),
                      blurRadius: 15.0,
                      //offset: Offset(0.0, 7.0)
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
