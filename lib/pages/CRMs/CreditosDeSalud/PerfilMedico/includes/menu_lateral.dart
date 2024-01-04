import 'package:flutter/material.dart';

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
            color: Color.fromARGB(255, 12, 187, 6),
          ),
          accountName: Text('enriuqe aviles'),
          accountEmail: Text('jose@preiba.com'),
          currentAccountPicture: Image.asset('assets/images/logo.png'),
        ),
        ListTile(
          title: Text('perfile ssssssss'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/Ejemplos/Listado');
          },
        ),
        ListTile(
          title: Text('Medicos ssssss'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/Ejemplos/Listado');
          },
        )
      ],
    ));
  }
}
