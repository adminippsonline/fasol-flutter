import 'package:flutter/material.dart';
import 'pages/rutas.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // rutas disponibles en la app.
  // cada widget es una página diferente.
  final _routes = {
    '/': (context) => const HomePage(),

    '/CreditosDeSalud': (context) => const HomePageCreditosDeSalud(),
    '/CerrarSesion': (context) => const CerrarSesion(),
    '/VerificarCuenta': (context) => const VerificarCuenta(),

    '/RegMedico': (context) => const RegMedico(),
    '/RegMedico/RegistroMed': (context) => const RegistroMed(),
    '/RegMedico/RegistroMedOlvidaste': (context) => const RegistroMedOlvidaste(),

    '/RegMedico/FinRegMedico30': (context) => const FinRegMedico30(),
    '/RegMedico/FinRegMedico30_1': (context) => const FinRegMedico30_1(),
    '/RegMedico/FinRegMedico31': (context) => const FinRegMedico31(),
    '/RegMedico/FinRegMedico32': (context) => const FinRegMedico32(),
    '/RegMedico/FinRegMedico33': (context) => const FinRegMedico33(),
    '/RegMedico/FinRegMedico33_1': (context) => const FinRegMedico33_1(),
    '/RegMedico/FinRegMedico34': (context) => const FinRegMedico34(),
    '/RegMedico/FinRegMedico36': (context) => const FinRegMedico36(),
    '/RegMedico/FinRegMedico38': (context) => const FinRegMedico38(),

    '/RegMedico/FirmarMedico': (context) => const FirmarMedico(),

    '/PerfilMedico/LoginMed': (context) => const LoginMed(),
    '/PerfilMedico/PerfilMed': (context) => const PerfilMed(),
    '/PerfilMedico/PerfilMedVerificar': (context) => const PerfilMedVerificar(),
    '/PerfilMedico/PerfilMedWebView': (context) => PerfilMedicoWebView("", "", 0),
    

    '/RegClinica': (context) => const RegClinica(),
    '/RegClinica/RegistroCli': (context) => const RegistroCli(),
    '/RegClinica/RegistroCliOlvidaste': (context) => const RegistroCliOlvidaste(),

    '/RegClinica/FinClinicas3': (context) => const FinClinicas3(),
    '/RegClinica/FinClinicas4_1': (context) => const FinClinicas4_1(),
    '/RegClinica/FinClinicas4': (context) => const FinClinicas4(),
    '/RegClinica/FinClinicas5_0': (context) => const FinClinicas5_0(),
    '/RegClinica/FinClinicas5': (context) => const FinClinicas5(),
    '/RegClinica/FinClinicas6': (context) => const FinClinicas6(),
    '/RegClinica/FinClinicas7': (context) => const FinClinicas7(),
    '/RegClinica/FinClinicas8': (context) => const FinClinicas8(),
    '/RegClinica/FinClinicas9': (context) => const FinClinicas9(),
    '/RegClinica/FinClinicas10': (context) => const FinClinicas10(),
    '/RegClinica/FinClinicas11': (context) => const FinClinicas11(),
    '/RegClinica/FinClinicas12': (context) => const FinClinicas12(),
    '/RegClinica/FinClinicas13': (context) => const FinClinicas13(),
    '/RegClinica/FinClinicas14_1': (context) => const FinClinicas14_1(),
    '/RegClinica/FinClinicas14': (context) => const FinClinicas14(),
    '/RegClinica/FinClinicas15': (context) => const FinClinicas15(),
    '/RegClinica/FinClinicas16': (context) => const FinClinicas16(),
    '/RegClinica/FinClinicas17_adicional': (context) =>
        const FinClinicas17_adicional(),
    '/RegClinica/FinClinicas17': (context) => const FinClinicas17(),
    '/RegClinica/FinClinicas17_0': (context) => const FinClinicas17_0(),
    '/RegClinica/FinClinicas17_1': (context) => const FinClinicas17_1(),
    '/RegClinica/FinClinicas18': (context) => const FinClinicas18(),
    '/RegClinica/FinClinicas19': (context) => const FinClinicas19(),

     '/RegClinica/FirmarClinica': (context) => const FirmarClinica(),

    '/PerfilClinica/LoginCli': (context) => const LoginCli(),
    '/PerfilClinica/PerfilCli': (context) => const PerfilCli(),
    '/PerfilClinica/PerfilCliVerificar': (context) =>
        const PerfilCliVerificar(),
    '/PerfilClinica/PerfilCliWebView': (context) =>  PerfilClinicaWebView("", "", 0), 

    '/RegSolicitud': (context) => const RegSolicitud(),
    '/RegSolicitud/Desgloce': (context) =>  Desgloce("","","",""),
    '/RegSolicitud/RegistroSol': (context) => const RegistroSol(),
   
    '/RegSolicitud/RegistroSolOlvidaste': (context) =>
        const RegistroSolOlvidaste(),
    '/RegSolicitud/FinSolicitar10': (context) => const FinSolicitar10(),
    '/RegSolicitud/FinSolicitar11': (context) => const FinSolicitar11(),
    '/RegSolicitud/FinSolicitar12': (context) => const FinSolicitar12(),
    '/RegSolicitud/FinSolicitar13_0': (context) => const FinSolicitar13_0(),
    '/RegSolicitud/FinSolicitar13_1': (context) => const FinSolicitar13_1(),
    '/RegSolicitud/FinSolicitar14': (context) => const FinSolicitar14(),
    '/RegSolicitud/FinSolicitar15': (context) => const FinSolicitar15(),
    '/RegSolicitud/FinSolicitar15_negativa': (context) => const FinSolicitar15_negativa(),
    '/RegSolicitud/FinSolicitar16': (context) => const FinSolicitar16(),
    '/RegSolicitud/FinSolicitar17_1': (context) => const FinSolicitar17_1(),
    '/RegSolicitud/FinSolicitar17_2': (context) => const FinSolicitar17_2(),
    '/RegSolicitud/FinSolicitar18': (context) => const FinSolicitar18(),
    '/RegSolicitud/FinSolicitar19': (context) => const FinSolicitar19(),
    '/RegSolicitud/FinSolicitar19_noAprobada': (context) => const FinSolicitar19_noAprobada(),
    '/RegSolicitud/FinSolicitar20': (context) => const FinSolicitar20(),
    '/RegSolicitud/FinSolicitar21': (context) => const FinSolicitar21(),
    '/RegSolicitud/FinSolicitar22': (context) => const FinSolicitar22(),
    '/RegSolicitud/FinSolicitar22_1': (context) => const FinSolicitar22_1(),
    '/RegSolicitud/FinSolicitar23': (context) => const FinSolicitar23(),
    '/RegSolicitud/FinSolicitar23_0': (context) => const FinSolicitar23_0(),
    '/RegSolicitud/FinSolicitar23_1': (context) => const FinSolicitar23_1(),
    '/RegSolicitud/FinSolicitar23_2': (context) => const FinSolicitar23_2(),
    '/RegSolicitud/FinSolicitar23_4': (context) => const FinSolicitar23_4(),
    '/RegSolicitud/FinSolicitar24': (context) => const FinSolicitar24(),
    '/RegSolicitud/FinSolicitar25_1': (context) => const FinSolicitar25_1(),
    '/RegSolicitud/FinSolicitar25': (context) => const FinSolicitar25(),
    '/RegSolicitud/FinSolicitar26': (context) => const FinSolicitar26(),
    '/RegSolicitud/FinSolicitar27': (context) => const FinSolicitar27(),

    '/RegSolicitud/FirmarSolicitud': (context) => const FirmarSolicitud(),

    '/PerfilSolicitud/LoginSol': (context) => const LoginSol(),
    '/PerfilSolicitud/PerfilSol': (context) => const PerfilSol(),
    '/PerfilSolicitud/PerfilSolVerificar': (context) =>
        const PerfilSolVerificar(),
    '/PerfilSolicitud/PerfilSolWebView': (context) => PerfilSolicitudWebView("", "", 0),

//////////////////
    ///
    /*'/Ejemplos/Listado': (context) => const ListadoPage(),
    '/Ejemplos/Formulario': (context) => const FormularioPage(),
    '/Ejemplos/MenuLateral': (context) => const MenuLateralPage(),*/
    //'/otra': (context) => const OtraPage(),
    //'/servicios': (context) => const ServiciosPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',

      initialRoute: '/CreditosDeSalud',
      // aquí se asigna el objeto a la propiedad de routes
      routes: _routes,
      onGenerateRoute: (settings) {
        // esta opción se ejecuta cuando se llama una ruta que no existe
        return MaterialPageRoute(
          builder: (context) => const Page404(),
        );
      },
    );
  }
}
