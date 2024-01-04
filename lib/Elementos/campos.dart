import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  String nombreCampoLabel = "Navigate";
  String nombreCampo = "Correo";

  String obligatorio = "1";
  String validacion = "SoloTexto";
  int maxCaracteres = 6;

  InputText(this.nombreCampoLabel, this.nombreCampo, this.obligatorio,
      this.validacion, this.maxCaracteres);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      ///width: 400,
      width: MediaQuery.of(context).size.width,

      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        maxLength: this.maxCaracteres,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: this.nombreCampo,
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: '',
            counterText: ''),
      ),
    );
  }
}

class InputDate extends StatelessWidget {
  String nombreCampo = "Correo";
  String nombreCampoLabel = "Navigate";
  String obligatorio = "1";
  String validacion = "SoloTexto";

  InputDate(this.nombreCampo, this.nombreCampoLabel, this.obligatorio,
      this.validacion);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: this.nombreCampo,
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
    );
  }
}

class RadioButon extends StatelessWidget {
  String nombreCampo = "Correo";
  String obligatorio = "1";

  RadioButon(this.nombreCampo, this.obligatorio);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(10),
      child: RadioListTile(
          title: Text(this.nombreCampo),
          value: this.nombreCampo,
          groupValue: "group value",
          onChanged: (value) {
            print(value); //selected value
          }),
    );
  }
}
