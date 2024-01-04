import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:developer' as dev;


//estas dos creo son para las apis que se consumen
import 'package:http/http.dart' as http;
import 'dart:async';
//Me parece que es para convertir el json
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
//Paqueteria para sesiones tipo cookies
import 'package:shared_preferences/shared_preferences.dart';


class ElementosItems {
  final String Descripcio; 
  final String Valores;
  ElementosItems (this.Descripcio, this.Valores);
}

final List<ElementosItems> _listaElementos =[
  ElementosItems("Monto solicitado", "ñññ"),
  ElementosItems("a pagar", "2,000"),
  ElementosItems("Cuota", "5,600"),
  ElementosItems("Total a pagar", "40,000"),
  ElementosItems("Tasa promedio", "10"),
  ElementosItems("Cat promedio", "10"),
  ElementosItems("Comisión por apertura", "100"),
  ElementosItems("Comisión pago tardío ", "200"),
  
    
];


Widget builElementos(MontoSolicitadoSession) {

  /*var responseString = Respuesta;
  final datos = json.decode(responseString);
  //var Montosolicitado = datos['Montosolicitado'].toString();
  var Montosolicitado =datos['MontoSolicitado'];*/
  return DataTable(
    sortColumnIndex: 0,
    /*onSelectAll: (bool value){

    },*/
    columns: <DataColumn>[
      DataColumn(
        label: Text(MontoSolicitadoSession),
        tooltip: ''
      ),
      DataColumn(
          label: Text(""),
          tooltip: '', 
        )
    ], 
    rows: _listaElementos.map<DataRow>((ElementosItems ElementosItems){
      return DataRow(
        
        cells: <DataCell>[
          DataCell(
            Text(ElementosItems.Descripcio)
          ),
          DataCell(
            Text(ElementosItems.Valores),
          )
        ]
      );
    }).toList(),
  );
}

class ResultadosItems {
  final String Descripcio; 
  final String Valores;
  ResultadosItems (this.Descripcio, this.Valores);
}

final List<ResultadosItems> _listaResultados =[
  ResultadosItems("Monto solicitado", "aaa"),
  ResultadosItems("a pagar", "aaa"),
  ResultadosItems("Cuota", "aaa"),
  ResultadosItems("Total a pagar", "aaa"),
  ResultadosItems("Tasa promedio", "aaa"),
  ResultadosItems("Cat promedio", "aaa"),
  ResultadosItems("Comisión por apertura", "aaa"),
  ResultadosItems("Comisión pago tardío ", "aaa"),
  
    
];

Widget builResultados() {
  return DataTable(
    sortColumnIndex: 0,
    /*onSelectAll: (bool value){

    },*/
    columns: <DataColumn>[
      DataColumn(
        label: Text(''),
        tooltip: ''
      ),
      DataColumn(
          label: const Text(''),
          tooltip: '', 
        )
    ], 
    rows: _listaResultados.map<DataRow>((ResultadosItems ResultadosItems){
      return DataRow(
        
        cells: <DataCell>[
          DataCell(
            Text(ResultadosItems.Descripcio)
          ),
          DataCell(
            Text(ResultadosItems.Valores),
          )
        ]
      );
    }).toList(),
  );
}