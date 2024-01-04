import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class NombreApellido {
  String nombre;
  String apellido;

  NombreApellido(this.nombre, this.apellido);
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController _controller = TextEditingController();
  int n = 0; // Cantidad de campos a generar
  List<NombreApellido> camposData = [];
  List<Widget> campos = [];
  int selectedOption = 0; // Opción seleccionada del radio button

  void generarCampos() {
    camposData.clear();
    campos.clear();

    for (int i = 0; i < n; i++) {
      NombreApellido nuevoCampo = NombreApellido('', '');
      camposData.add(nuevoCampo);

      campos.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                  ),
                  onChanged: (value) {
                    setState(() {
                      nuevoCampo.nombre = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Apellido',
                  ),
                  onChanged: (value) {
                    setState(() {
                      nuevoCampo.apellido = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void guardarDatos() {
    for (var campoData in camposData) {
      dev.log('Nombre: ${campoData.nombre}, Apellido: ${campoData.apellido}');
      // Puedes hacer lo que desees con los datos ingresados, como almacenarlos en una base de datos o enviarlos a través de una API.
    }
  }

  void mostrarModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Generar campos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Número de campos',
                  ),
                  onChanged: (value) {
                    setState(() {
                      n = int.tryParse(value) ?? 0;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Generar formulario'),
                  onPressed: () {
                    generarCampos();
                    Navigator.of(context).pop();
                    mostrarFormulario(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void mostrarFormulario(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Formulario',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 16.0),
                SingleChildScrollView(
                  child: Column(
                    children: campos,
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Guardar'),
                  onPressed: () {
                    guardarDatos();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generar campos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioListTile(
              title: Text('Opción 1'),
              value: 1,
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('Opción 2'),
              value: 2,
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            if (selectedOption == 1)
              ElevatedButton(
                child: Text('Generar campos'),
                onPressed: () {
                  mostrarModal(context);
                },
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyForm(),
  ));
}
