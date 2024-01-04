String? ObligatorioCP(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio [0-9]";
  }
  String pattern = r'(^[0-9]*$)';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return '*El campo sólo acepta números';
  }
  if (value.length != 5) {
    return "*El número debe tener 5 digitos";
  }
  return null;
}

String? ObligatorioCorreo(String? value) {
  if (value != null && value.isEmpty) {
    return "*El correo es obligatorio";
  }

  if (!RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value!)) {
    return "*El correo no es valido";
  }
  return null;
}

String? ObligatorioContrasena(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio";
  }

  /*String pattern =
      r'(^(?=(?:.*\d){2})(?=(?:.*[A-Z]){2})(?=(?:.*[a-z]){2})\S{8,}$)';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return 'Ingresa como mínimo una mayúscula, una minúscula y un numero';
  }
  if (value.length > 8) {
    return "Mínimo 8 caracteres";
  }*/
  return null;
}

String? ObligatorioContrasenaConfirmar(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio";
  }
  return null;
}

String? ObligatorioRadio(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio";
  }
  return null;
}

String? ObligatorioCelular(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio [0-9]";
  }
  String pattern = r'(^[0-9 ]*$)';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return '*El campo sólo acepta números';
  }
  if (value.length != 12) {
    return "*El número debe tener 10 digitos";
  }
  return null;
}

String? ObligatorioCURP(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio [a-z,A-Z,0-9]";
  }
  String pattern = r'(^[a-zA-Z0-9]*$)';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return '*El campo sólo acepta números y texto';
  }
  if (value.length != 18) {
    return "*La CURP debe tener 18 digitos";
  }
  return null;
}

String? ObligatorioRFC(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio [a-z,A-Z,0-9]";
  }
  String pattern = r'(^[a-zA-Z0-9]*$)';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return '*El campo sólo acepta números y texto';
  }
  if (value.length != 13) {
    return "*El RFC debe tener 13 digitos";
  }
  return null;
}

String? ObligatorioRFCEmpresa(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio [a-z,A-Z,0-9]";
  }
  String pattern = r'(^[a-zA-Z0-9]*$)';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return '*El campo sólo acepta números y texto';
  }
  if (value.length != 12) {
    return "*El RFC debe tener 12 digitos";
  }
  return null;
}

String? ObligatorioSoloTextoYNumeros(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio [a-z,A-Z,0-9]";
  }
  String pattern = r'(^[a-z,A-Z,0-9 ]*$)';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return '*El campo sólo acepta números y texto';
  }
  return null;
}

String? ObligatorioSelect(String? value) {
  if (value == null) {
    return '*Campo obligatorio';
  }
  return null;
}

String? ObligatorioInput(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio";
  }
  return null;
}

String? SoloNumeros(String? value) {
  String pattern = r'(^[0-9]*$)';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return '*El campo sólo acepta números';
  }
  /*if (value.length != 5) {
      return "El número debe tener 5 digitos";
    }*/
  return null;
}

String? ObligatorioSoloNumeros(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio [0-9]";
  }
  String pattern = r'(^[0-9 ]*$)';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return '*El campo sólo acepta números';
  }
  /*if (value.length != 5) {
      return "El número debe tener 5 digitos";
    }*/
  return null;
}

String? ObligatorioPeriodo(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio [0-9]";
  }
  String pattern = r'(^[0-9 -]*$)';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return '*El campo sólo acepta números';
  }
  if (value.length != 9) {
    return "*El periodo debe tener 8 digitos";
  }
  return null;
}

String? ObligatorioClaveInterbancaria(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio [0-9]";
  }
  String pattern = r'(^[0-9]*$)';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return '*El campo sólo acepta números';
  }
  if (value.length != 18) {
    return "*Debe tener 18 digitos";
  }
  return null;
}

String? ObligatorioSoloTexto(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio [a-z, A-Z]";
  }
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return '*El campo debe de ser a-z o A-Z';
  }
  return null;
}

String? validarCampo(String? valor) {
  if (valor!.isEmpty) {
    return 'Este campo no puede estar vacío';
  }
  return null;
}

// String? ObligatorioSoloTexto(String? value) {
//   if (value!.isEmpty) {
//     return "*Campo obligatorio [a-z, A-Z]";
//   }
//   String pattern = r'(^[a-zA-Z ]*$)';
//   RegExp regex = new RegExp(pattern);
//   if (!regex.hasMatch(value!)) {
//     return '*El campo debe de ser a-z o A-Z';
//   }
//   return null;
// }

String? SoloTexto(String? value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return '*El campo debe de ser a-z o A-Z';
  }
  return null;
}

String? ObligatorioFechaDeNacimiento(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio";
  }
  return null;
}

String? ObligatorioFecha(String? value) {
  if (value != null && value.isEmpty) {
    return "*Campo obligatorio";
  }
  return null;
}
