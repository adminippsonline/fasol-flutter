import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../home_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'PerfilMedico/PerfilMedVerificar.dart';
import 'PerfilClinica/PerfilCliVerificar.dart';
import 'PerfilSolicitud/PerfilSolVerificar.dart';

void main() => runApp(MaterialApp(
    builder: (context, child) {
      return Directionality(textDirection: TextDirection.ltr, child: child!);
    },
    title: 'GNav',
    theme: ThemeData(
      primaryColor: Colors.grey[800],
    ),
    home: HomePage()));

class MenuFooterPage extends StatefulWidget {
  const MenuFooterPage({super.key});

  @override
  State<MenuFooterPage> createState() => _MenuFooterPageState();
}

class _MenuFooterPageState extends State<MenuFooterPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Usuarios',
      style: optionStyle,
    ),
    Text(
      'Médicos',
      style: optionStyle,
    ),
    Text(
      'Clínicas',
      style: optionStyle,
    ),
  ];
  @override


  int id_medico = 0;
  int id_clinica = 0;
  int id_LR = 0;
  int id_info = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String TelefonoSession = "";

  @override
  void initState() {
    super.initState();
    mostrar_datos();
  }

  void mostrar_datos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      NombreCompletoSession =prefs.getString('NombreCompletoSession') ?? 'vacio';
      id_medico = prefs.getInt('id_medico') ?? 0;
      id_clinica = prefs.getInt('id_clinica') ?? 0;
      id_LR = prefs.getInt('id_LR') ?? 0;
      id_info = prefs.getInt('id_info') ?? 0;
    });
  }
  Widget build(BuildContext context) {
    
    if (id_medico>=1) {
      return _FooterMedico();
    }
    else if (id_clinica>=1) {
      return _FooterClinica();
    }
    else if (id_LR>=1) {
      return _FooterLR();
    }
    else{
      return _FooterGeneral();
    }
  }

  Widget _FooterGeneral() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                    icon: Icons.home,
                    text: 'Home',
                    onPressed: () {
                      Navigator.pushNamed(context, '/CreditosDeSalud');
                    }),
                GButton(
                  icon: Icons.person,
                  text: 'Solicitantes',
                  onPressed: () {
                    Navigator.pushNamed(context, '/RegSolicitud');
                  },
                ),
                GButton(
                  icon: Icons.medical_information_outlined,
                  text: 'Médicos',
                  onPressed: () {
                    Navigator.pushNamed(context, '/RegMedico');
                  },
                ),
                GButton(
                  icon: Icons.local_hospital_outlined,
                  text: 'Clínicas',
                  onPressed: () {
                    Navigator.pushNamed(context, '/RegClinica');
                  },
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ));
  }
  Widget _FooterMedico() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                    icon: Icons.home,
                    text: 'Home',
                    onPressed: () {
                      Navigator.pushNamed(context, '/CreditosDeSalud');
                    }),
                
                GButton(
                  icon: Icons.medical_information_outlined,
                  text: 'Médicos',
                  onPressed: () {
                    Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PerfilMedVerificar()));
                  },
                ),
                 GButton(
                  icon: Icons.notifications_active,
                  text: 'Notificaciones',
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => PerfilMedVerificar()));
                  },
                ),
                GButton(
                  icon: Icons.policy_rounded,
                  text: 'Ayuda',
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => PerfilMedVerificar()));
                  },
                )
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ));
  }
  Widget _FooterClinica() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                    icon: Icons.home,
                    text: 'Home',
                    onPressed: () {
                      Navigator.pushNamed(context, '/CreditosDeSalud');
                    }),
                
                GButton(
                  icon: Icons.local_hospital_outlined,
                  text: 'Clínicas',
                  onPressed: () {
                    Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PerfilCliVerificar()));
                  },
                ),
                 GButton(
                  icon: Icons.notifications_active,
                  text: 'Notificaciones',
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => PerfilCliVerificar()));
                  },
                ),
                GButton(
                  icon: Icons.policy_rounded,
                  text: 'Ayuda',
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => PerfilCliVerificar()));
                  },
                )
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ));
  }
  Widget _FooterLR() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                    icon: Icons.home,
                    text: 'Home',
                    onPressed: () {
                      Navigator.pushNamed(context, '/CreditosDeSalud');
                    }),
                GButton(
                  icon: Icons.person,
                  text: 'Solicitantes',
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => PerfilSolVerificar()));
                  },
                ),
                GButton(
                  icon: Icons.notifications_active,
                  text: 'Notificaciones',
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => PerfilSolVerificar()));
                  },
                ),
                GButton(
                  icon: Icons.policy_rounded,
                  text: 'Ayuda',
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => PerfilSolVerificar()));
                  },
                ),
                
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ));
  }
}
