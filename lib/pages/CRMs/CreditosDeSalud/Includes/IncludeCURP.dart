import 'package:flutter/material.dart';
import '../../../../../Elementos/validaciones_formularios.dart';

class IncludeCURP extends StatelessWidget {
 
  final CURP = TextEditingController();
 


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _CURP();
  }

  Widget _CURP() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: ObligatorioCURP,
        keyboardType: TextInputType.text,
        controller: CURP,
        maxLength: 18,
        decoration: InputDecoration(
            labelText: 'CURP',
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.all(10),
            hintText: ''),
      ),
      
    );
  }  
}
