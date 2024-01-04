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
        primarySwatch: Colors.blue,
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

  //Identificacion
  Future<void> initId() async {
    String fadResponse;
    const config =
        '{ "module": "id", "config": { "isAcuantFlowEnabled": true, "acUserName": "acuantEUUser@naat.com", "acPassword": "Q^59zWJzZ^jZrw^q", "acSubscription": "c681321c-2728-4e8a-a3df-a85ba8a11748", "acFrmEndpoint": "", "acPassiveLivenessEndpoint": "", "acHealthInsuranceEndpoint": "", "acIdEndpoint": "", "acAcasEndpoint": "", "acOzoneEndpoint": "" } }';

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

  //Biometricos
  Future<void> initFace() async {
    String fadResponse;
    String config =
        '{ "module": "face", "config": { "appId": "*", "appVersion": "", "facetecMiddleware": "", "isShowPreview": true, "url": "https://devapiframe.firmaautografa.com/fad-iframe-facetec", "token": "RkJKa1RwampBMHJ6MWtwZlJ4SEEwV0VhRGsrM3VwU3h5UklFQWdFdFZtck1NbzVTaHFCUDhCRUdwR3FrQkpSZlR1dll5MVRUQm82U2QrNm1tR3orN2xRdHdjbEwrU1NLbk1XdVVGN090S1kwQ2FVM1h2NUYyazRYWUFTV2p6czE", "zoomPublicKey": "", "zoomLicenceKey": "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5PxZ3DLj+zP6T6HFgzzkM77LdzP3fojBoLasw7EfzvLMnJNUlyRb5m8e5QyyJxI+wRjsALHvFgLzGwxM8ehzDqqBZed+f4w33GgQXFZOS4AOvyPbALgCYoLehigLAbbCNTkeY5RDcmmSI/sbp+s6mAiAKKvCdIqe17bltZ/rfEoL3gPKEfLXeN549LTj3XBp0hvG4loQ6eC1E1tRzSkfGJD4GIVvR+j12gXAaftj3ahfYxioBH7F7HQxzmWkwDyn3bqU54eaiB7f0ftsPpWMceUaqkL2DZUvgN0efEJjnWy5y1/Gkq5GGWCROI9XG/SwXJ30BbVUehTbVcD70+ZF8QIDAQAB", "zoomServerBaseURL": "https://facetec-preprod.firmaautografa.com", "zoomProductionKeyText": "003045022100c7c57e004adf03ba8ba2337543897d895ab2dada91fca39d3b5c4fbff68acab8022076b2ae1ca61f4bba85b340de2269fd7ed80bd502203b3539bd986865a9bed7f7", "zoomExpirationDate": "2023-05-10"} }';

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
  //Videotaping
  Future<void> initVideoAgreement() async {
    String fadResponse;
    String config =
        '{ "module": "videoagreement",  "config": {"textToDisplay": "aqui el texto que se va a poner", "idCapture": false, "maximumTimeForRecording": 15, "minimumTimeForRecording": 7, "msWordSpeech": 50, "forceIdCrop": false}}';

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

  //Firma
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
            //Identificacion

            ElevatedButton(
              onPressed: () {
                initId();
              },
              child: const Text('Iniciar Id: identificación: acuant'),
            ),
            //Biometricos
            ElevatedButton(
              onPressed: () {
                initFace();
              },
              child: const Text('Iniciar Face: biometricos: facetec'),
            ),
            //Video
            ElevatedButton(
              onPressed: () {
                initVideoAgreement();
              },
              child: const Text('Iniciar Video acuerdo; videotaping'),
            ),
            //Firma
            ElevatedButton(
              onPressed: () {
                initMultiSign();
              },
              child: const Text('Iniciar Muiltifirma'),
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
