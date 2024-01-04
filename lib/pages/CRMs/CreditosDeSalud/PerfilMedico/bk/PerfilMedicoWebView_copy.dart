import 'dart:async'; 
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(home: PerfilMedicoWebView()));




class PerfilMedicoWebView extends StatefulWidget {
  const PerfilMedicoWebView({super.key});

  @override
  State<PerfilMedicoWebView> createState() => _PerfilMedicoWebViewState();
}

class _PerfilMedicoWebViewState extends State<PerfilMedicoWebView> {
  late final WebViewController _controller;



  //int page=0;
  int id_medico = 0;
  int id_info = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String ContrasenaSession = "";
  String TelefonoSession = ""; 
  //String _url="";

  void mostrar_datos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      
      id_medico = prefs.getInt('id_medico') ?? 0;
      id_info = prefs.getInt('id_info') ?? 0;
      NombreCompletoSession =
          prefs.getString('NombreCompletoSession') ?? 'vacio';
      CorreoSession =
          prefs.getString('CorreoSession') ?? 'vacio';
      ContrasenaSession =
          prefs.getString('ContrasenaSession') ?? 'vacio';
    });    
  }

  /*setTextValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int page = prefs.getInt('currPage') ?? 33;

    print("**");
    print(page);
    print("**");
    
  }*/

  @override
  void initState() {
    super.initState();
    mostrar_datos();
    /*setTextValue();
    print("--");
    print(page);
    print("--");*/
    


    
  

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    //_url="http://fasoluciones.mx/ApiApp/Medico/LoginPerfil.php?Correo=$CorreoSession&Contrasena=$ContrasenaSession&Telefono=55555555";
    //print(_url);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        }, 
      )
      ..loadRequest(
          Uri.parse("http://fasoluciones.mx/ApiApp/Medico/Sesion.php")); 


    _controller = controller; 
  }
 
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text("Perfil médico $id_medico $id_info  $NombreCompletoSession "),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          //NavigationControls(webViewController: _controller),
          //SampleMenu(webViewController: _controller),
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }

  
}


