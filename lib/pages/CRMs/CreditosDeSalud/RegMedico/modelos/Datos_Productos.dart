class Datos_Productos {
  String id_form_campos = "";

  String titulo_campo = "";

  String nombre_campo = "";

  Datos_Productos(this.id_form_campos, this.titulo_campo, this.nombre_campo);

  Datos_Productos.fromJson(Map<String, dynamic> json) {
    id_form_campos = json['id_form_campos'];
    titulo_campo = json['titulo_campo'];
    nombre_campo = json['nombre_campo'];
  }
}
