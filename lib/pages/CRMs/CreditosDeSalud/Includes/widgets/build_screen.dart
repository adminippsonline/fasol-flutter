import 'package:flutter/material.dart';
import '../..../../colors/colors.dart';
import '../../../../../pages/CRMs/CreditosDeSalud/menu_footer.dart';

import '../../../../../pages/CRMs/CreditosDeSalud/headers.dart';
import '../../../../../pages/CRMs/CreditosDeSalud/menu_lateral.dart';

class BuildScreens extends StatelessWidget {
  String NombreCompletoSession = "";
  String $id_recibe = "";
  String $id_info = "";
  String nombreHeader = "";

  String subtitle = "";
  Widget myWidget;

  BuildScreens(this.NombreCompletoSession, this.$id_recibe, this.$id_info,
      this.nombreHeader, this.subtitle, this.myWidget);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_FONDO,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: COLOR_PRINCIPAL,
        title:
            Text("${NombreCompletoSession}" + " ${$id_recibe}" + "${$id_info}",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
      ),
      drawer: MenuLateralPage(""),
      bottomNavigationBar: MenuFooterPage(),
      body: Container(
          padding: EdgeInsets.all(5),
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight),
                      child: Container(
                        child: IntrinsicHeight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                color: COLOR_FONDO,
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      headerTop(
                                          '${nombreHeader}', '${subtitle}'),

                                      // SubtitleTop('${subtitleHeader}')
                                      // Text('Acerca de ti',
                                      //     style: GoogleFonts.calligraffitti(
                                      //       color: Colors.white,
                                      //       fontSize: 25,
                                      //     )),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      padding: EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50),
                                        ),
                                      ),
                                      child: Column(
                                        children: [Formulario(myWidget)],
                                      )))
                            ],
                          ),
                        ),
                      )));
            },
          )),
    );
  }
}

class Formulario extends StatelessWidget {
  final Widget myWidget;
  Formulario(this.myWidget);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [myWidget],
    );
  }
}
