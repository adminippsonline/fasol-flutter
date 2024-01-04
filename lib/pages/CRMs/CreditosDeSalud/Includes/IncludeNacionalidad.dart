import 'package:flutter/material.dart';
import '../../../../../Elementos/validaciones_formularios.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class IncludeNacionalidad extends StatelessWidget {
 
  final List<String> ListaNacionalidad = [
    'Mexicana',
  ];

  String? SelectedListaNacionalidad;

  final Nacionalidad = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _Nacionalidad();
  }

  Widget _Nacionalidad() {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: DecoratedBox(
          decoration: BoxDecoration(),
          child: DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            isExpanded: true,
            hint: const Text(
              'Nacionalidad',
              style: TextStyle(fontSize: 14),
            ),
            items: ListaNacionalidad.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )).toList(),
            validator: ObligatorioSelect,
            onChanged: (value) {
              //Do something when changing the item if you want.
              SelectedListaNacionalidad = value;
            },
            onSaved: (value) {
              SelectedListaNacionalidad = value.toString();
            },
            buttonStyleData: const ButtonStyleData(
              height: 55,
              padding: EdgeInsets.only(left: 0, right: 10),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          )),
    );
  }  
}
