import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../menu_lateral.dart';
import '../menu_footer.dart';
import '../Includes/colors/colors.dart';

class RegClinica extends StatefulWidget {
  const RegClinica({super.key});

  @override
  State<RegClinica> createState() => _RegClinicaState();
}

class _RegClinicaState extends State<RegClinica> {
  //TextStyle EstiloBotones = TextStyle(color: Colors.amber);

  final _keyForm = GlobalKey<_RegClinicaState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_PRINCIPAL,
        title: const Text('Área de Clínica '),
      ),
      drawer: MenuLateralPage(""),
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
              Navigator.pushNamed(context, "/PerfilClinica/LoginCli");
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
                        'assets/images/CRMs/CreditosDeSalud/LoginClinica.png'),
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
              Navigator.pushNamed(context, "/RegClinica/RegistroCli");
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
                          'assets/images/CRMs/CreditosDeSalud/RegistroClinica.png')),
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
