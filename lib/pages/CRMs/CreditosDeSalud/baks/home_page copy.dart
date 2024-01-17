import 'package:flutter/material.dart';
import '../menu_lateral.dart';
import '../menu_footer.dart';

class HomePageCreditosDeSalud extends StatefulWidget {
  const HomePageCreditosDeSalud({super.key});

  @override
  State<HomePageCreditosDeSalud> createState() =>
      _HomePageCreditosDeSaludState();
}

class _HomePageCreditosDeSaludState extends State<HomePageCreditosDeSalud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fasol: Te lleva hasta donde quieres crecer'),
        ),
        drawer: MenuLateralPage(""),
        bottomNavigationBar: MenuFooterPage(),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            /*width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'images/CRMs/CreditosDeSalud/Tabulador.jpg',
                fit: BoxFit.cover,
              ),*/
            child: Image(
              image: AssetImage('images/CRMs/CreditosDeSalud/Tabulador.jpg'),
              alignment: Alignment.center,
              //height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
        )));
  }
}
