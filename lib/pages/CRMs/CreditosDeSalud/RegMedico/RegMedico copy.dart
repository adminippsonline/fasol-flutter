import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../menu_lateral.dart';
import '../menu_footer.dart';

class RegMedico extends StatefulWidget {
  const RegMedico({super.key});

  @override
  State<RegMedico> createState() => _RegMedicoState();
}

class _RegMedicoState extends State<RegMedico> {
  //TextStyle EstiloBotones = TextStyle(color: Colors.amber);

  final _keyForm = GlobalKey<_RegMedicoState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reg medico '),
      ),
      drawer: MenuLateralPage(""),
      bottomNavigationBar: MenuFooterPage(),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/PerfilMedico/LoginMed");
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
                        'assets/images/CRMs/CreditosDeSalud/LoginMedico.png'),
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
              Navigator.pushNamed(context, "/RegMedico/RegistroMed");
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
                          'assets/images/CRMs/CreditosDeSalud/RegistroMedico.png')),
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
