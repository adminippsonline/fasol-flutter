import 'dart:async';
import 'dart:convert'; 
import 'dart:io';
import 'dart:typed_data';
import '../Includes/colors/colors.dart';
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

import '../menu_lateral.dart';
import '../menu_footer.dart';

//void main() => runApp(const MaterialApp(home: PerfilMedicoWebView()));

class PerfilMedicoWebView extends StatefulWidget {
  //const PerfilMedicoWebView({super.key});

  String CorreoGET = "";
  String ContrasenaGET = "";
  int id_medicoGET = 0;

  PerfilMedicoWebView(this.CorreoGET, this.ContrasenaGET, this.id_medicoGET);

  @override
  State<PerfilMedicoWebView> createState() => _PerfilMedicoWebViewState();
}

class _PerfilMedicoWebViewState extends State<PerfilMedicoWebView> {
  late final WebViewController _controller;

  String _url = "";
  int id_medico = 0;
  int id_info = 0;
  String NombreCompletoSession = "";
  String CorreoSession = "";
  String ContrasenaSession = "";
  String TelefonoSession = "";

  @override
  void initState() {
    super.initState();

    //_url = "https://pideagua.com.mx/app/CRM-1041-Pide+Agua";
    var CorreoDato = widget.CorreoGET;
    var ContrasenaDato = widget.ContrasenaGET;
    var id_medicoDato = widget.id_medicoGET;
    _url =
        "https://fasoluciones.mx/PerfilMedico/LoguearWebView?Correo=$CorreoDato&Contrasena=$ContrasenaDato&id_medico=$id_medicoDato";
    print("***");
    print(_url);
    print("***");
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
      ..loadRequest(Uri.parse(_url));
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      /*appBar: AppBar(
        //widget.CorreoGET
        title: Text(""),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          //NavigationControls(webViewController: _controller),
          //SampleMenu(webViewController: _controller),
        ],
      ),*/
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(4.0), // here the desired height
        child: AppBar(
          // ...
          backgroundColor: COLOR_PRINCIPAL,
        )
      ),
      bottomNavigationBar: MenuFooterPage(),
      body: WebViewWidget(controller: _controller),
    );
  }
}
