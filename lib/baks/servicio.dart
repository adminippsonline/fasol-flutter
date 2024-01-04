import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  final String dominio = "fasoluciones.mx/";
  postDataImagen(_data, _url) async {
    return await http
        .post(Uri.http(dominio, _url), body: jsonEncode(_data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Charset': 'utf-8'
    });
  }
}
