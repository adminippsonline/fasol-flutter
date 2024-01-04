import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../RegMedico/RegMedico.dart';
import '../../RegClinica/RegClinica.dart';
import '../../RegSolicitud/RegSolicitud.dart';

class MenuLateralPage extends StatefulWidget {
  const MenuLateralPage({super.key});

  @override
  State<MenuLateralPage> createState() => _MenuLateralPageState();
}

class _MenuLateralPageState extends State<MenuLateralPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.all(0),
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Colors.amber,
          ),
          accountName: Text('enriuqe aviles'),
          accountEmail: Text('jose@preiba.com'),
          currentAccountPicture: Image.asset('assets/Logo.png'),
        ),
        ListTile(
          title: Text('Solicitud de crédito'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/RegSolicitud');
          },
        ),
        ListTile(
          title: Text('Médicos'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/RegMedico');
          },
        ),
        ListTile(
          title: Text('Médicos pantalla 36'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/RegMedico/FinRegMedico36');
          },
        ),
        ListTile(
          title: Text('Clinica'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/RegClinica');

            /*Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: RegMedico()));*/
          },
        ),

        

        ElevatedButton(
          child: Text('Fade Second Page - Default'),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: RegMedico(),
                isIos: true,
                duration: Duration(milliseconds: 400),
              ),
            );
          },
        ),
        ElevatedButton(
          child: Text('Left To Right Transition Second Page'),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: RegMedico(),
              ),
            );
          },
        ),
        ElevatedButton(
          child: Text('Right To Left Transition Second Page Ios SwipeBack'),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                isIos: true,
                child: RegMedico(),
              ),
            );
          },
        ),
        ElevatedButton(
          child: Text('Left To Right with Fade Transition Second Page'),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRightWithFade,
                alignment: Alignment.topCenter,
                child: RegMedico(),
              ),
            );
          },
        ),
        ElevatedButton(
          child: Text('Right To Left Transition Second Page'),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: RegMedico(),
              ),
            );
          },
        ),
        ElevatedButton(
          child: Text('Right To Left with Fade Transition Second Page'),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: RegMedico(),
              ),
            );
          },
        ),
        ElevatedButton(
          child: Text('Top to Bottom Second Page'),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                curve: Curves.linear,
                type: PageTransitionType.topToBottom,
                child: RegMedico(),
              ),
            );
          },
        ),
        ElevatedButton(
          child: Text('Bottom to Top Second Page'),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                curve: Curves.linear,
                type: PageTransitionType.bottomToTop,
                child: RegMedico(),
              ),
            );
          },
        ),
        ElevatedButton(
          child: Text('Scale Transition Second Page'),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.scale,
                alignment: Alignment.topCenter,
                duration: Duration(milliseconds: 400),
                isIos: true,
                child: RegMedico(),
              ),
            );
          },
        ),
        ElevatedButton(
          child: Text('Rotate Transition Second Page'),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                curve: Curves.bounceOut,
                type: PageTransitionType.rotate,
                alignment: Alignment.topCenter,
                child: RegMedico(),
              ),
            );
          },
        ),
        ElevatedButton(
          child: Text('Size Transition Second Page'),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                alignment: Alignment.bottomCenter,
                curve: Curves.bounceOut,
                type: PageTransitionType.size,
                child: RegMedico(),
              ),
            );
          },
        ),
      ],
    ));
  }
}
