import 'dart:async';

import 'package:fad_bio/fad_bio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plugin/plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customColor,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _fadResponse = "No iniciado";
  final _plugin = FadMultisignPlugin();
  final _fadBioPlugin = FadBio();

  Future<void> initMultiSign() async {
    String fadResponse;
    String config =
        '{"endpoint": "https://uat.firmaautografa.com","preventScreenCapture": false, "ticket": "90be37f66ffbce5203c999e84ffc7782d0bda1ae5dab468a43a27ed99d971b294a1e6f458a80e1ffd38a66b72554e37d","timeVideoAgreement":28}';

    try {
      fadResponse =
          await _plugin.initFAD(config) ?? 'Sin configuracion inicial';
      print(fadResponse);
    } on PlatformException {
      fadResponse = 'No se inicio FAD';
    }

    if (!mounted) return;

    setState(() {
      _fadResponse = fadResponse;
    });
  }

  String getPublicKey() {
    return "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5PxZ3DLj+zP6T6HFgzzk\nM77LdzP3fojBoLasw7EfzvLMnJNUlyRb5m8e5QyyJxI+wRjsALHvFgLzGwxM8ehz\nDqqBZed+f4w33GgQXFZOS4AOvyPbALgCYoLehigLAbbCNTkeY5RDcmmSI/sbp+s6\nmAiAKKvCdIqe17bltZ/rfEoL3gPKEfLXeN549LTj3XBp0hvG4loQ6eC1E1tRzSkf\nGJD4GIVvR+j12gXAaftj3ahfYxioBH7F7HQxzmWkwDyn3bqU54eaiB7f0ftsPpWM\nceUaqkL2DZUvgN0efEJjnWy5y1/Gkq5GGWCROI9XG/SwXJ30BbVUehTbVcD70+ZF\n8QIDAQAB\n-----END PUBLIC KEY-----";
  }

  Future<void> initFace() async {
    String fadResponse;
    String config =
        '{ "module": "face", "config": { "appId": "*", "appVersion": "", "facetecMiddleware": "", "isShowPreview": true, "url": "", "token": "", "zoomPublicKey": "dAaa7DjCJH7f4zuLwJFFlSjgAXL6k8q2", "zoomLicenceKey": "003046022100b69551ffe9049a530c7a03302c5f03cacec92a13aea3983b94994e650e664706022100b25ba3124181adb41c15aa1fb076fe9708f0f2279f87fde88825a53528068baa", "zoomServerBaseURL": "https://facetec-preprod.firmaautografa.com", "zoomProductionKeyText": "${getPublicKey()}", "zoomExpirationDate": "2023-05-10"} }';

    try {
      fadResponse =
          await _fadBioPlugin.initFADBio(config) ?? 'Sin configuracion inicial';
      print(fadResponse);
    } on PlatformException {
      fadResponse = 'No se inicio FAD';
    }

    if (!mounted) return;

    setState(() {
      _fadResponse = fadResponse;
    });
  }

  Future<void> initId() async {
    String fadResponse;
    const config =
        '{ "module": "id", "config": { "isAcuantFlowEnabled": true, "acUserName": "acuantEUUser@naat.com", "acPassword": "Q^59zWJzZ^jZrw^q", "acSubscription": "c681321c-2728-4e8a-a3df-a85ba8a11748", "acFrmEndpoint": "https://eu.frm.acuant.net", "acPassiveLivenessEndpoint": "https://eu.passlive.acuant.net", "acHealthInsuranceEndpoint": "https://medicscan.acuant.net", "acIdEndpoint": "https://eu.assureid.acuant.net", "acAcasEndpoint": "https://eu.acas.acuant.net", "acOzoneEndpoint": "https://eu.ozone.acuant.net" } }';

    try {
      fadResponse =
          await _fadBioPlugin.initFADBio(config) ?? 'Sin configuracion inicial';
      print(fadResponse);
    } on PlatformException {
      fadResponse = 'No se inicio FAD';
    }

    if (!mounted) return;

    setState(() {
      _fadResponse = fadResponse;
    });
  }

  // initFadConfig result are asynchronous, so we initialize in an async method.
  Future<void> initVideoAgreement() async {
    String fadResponse;
    String config =
        '{ "module": "videoagreement",  "config": {"textToDisplay": "Texto enviado desde Dart", "idCapture": false, "maximumTimeForRecording": 15, "minimumTimeForRecording": 7, "msWordSpeech": 50, "forceIdCrop": false}}';

    try {
      fadResponse =
          await _fadBioPlugin.initFADBio(config) ?? 'Sin configuracion inicial';
    } on PlatformException {
      fadResponse = 'No se inicio FadBio';
    }

    if (!mounted) return;

    setState(() {
      _fadResponse = fadResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                initMultiSign();
              },
              child: const Text('Iniciar Muiltifirma'),
            ),
            ElevatedButton(
              onPressed: () {
                initFace();
              },
              child: const Text('Iniciar Face'),
            ),
            ElevatedButton(
              onPressed: () {
                initId();
              },
              child: const Text('Iniciar Id'),
            ),
            ElevatedButton(
              onPressed: () {
                initVideoAgreement();
              },
              child: const Text('Iniciar Video acuerdo'),
            ),
            const Text(
              'Resultado',
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Text(
                  _fadResponse,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

MaterialColor customColor = const MaterialColor(
  0xFF540012,
  <int, Color>{
    50: Color(0xFFFCE4EC),
    100: Color(0xFFF8BBD0),
    200: Color(0xFFF48FB1),
    300: Color(0xFFF06292),
    400: Color(0xFFEC407A),
    500: Color(0xFFE91E63),
    600: Color(0xFFD81B60),
    700: Color(0xFFC2185B),
    800: Color(0xFFAD1457),
    900: Color(0xFF880E4F),
  },
);
