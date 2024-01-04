import 'package:flutter/material.dart';
import '../../../../../Elementos/validaciones_formularios.dart';

class IncludeRFC extends StatelessWidget {
 
  final RFC = TextEditingController();
 


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _RFC();
  }

  Widget _RFC() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioRFC,
        keyboardType: TextInputType.text,
        controller: RFC,
        maxLength: 13,
        decoration: InputDecoration(
            labelText: 'RFC',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
      
    );
  }  
}
