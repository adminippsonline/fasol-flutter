class CP {
  String? status;
  int? code;
  int? total;
  String? msg;
  List<Data>? data;

  CP({this.status, this.code, this.total, this.msg, this.data});

  CP.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    total = json['total'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['total'] = this.total;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? idCP;
  String? cP;
  String? colonia;
  String? dTipoAsenta;
  String? munDel;
  String? estado;
  String? ciudad;
  String? dCP;
  String? cEstado;
  String? cOficina;
  String? cCP;
  String? cTipoAsenta;
  String? cMnpio;
  String? idAsentaCpcons;
  String? dZona;
  String? cCveCiudad;

  Data(
      {this.idCP,
      this.cP,
      this.colonia,
      this.dTipoAsenta,
      this.munDel,
      this.estado,
      this.ciudad,
      this.dCP,
      this.cEstado,
      this.cOficina,
      this.cCP,
      this.cTipoAsenta,
      this.cMnpio,
      this.idAsentaCpcons,
      this.dZona,
      this.cCveCiudad});

  Data.fromJson(Map<String, dynamic> json) {
    idCP = json['id_CP'];
    cP = json['CP'];
    colonia = json['Colonia'];
    dTipoAsenta = json['d_tipo_asenta'];
    munDel = json['MunDel'];
    estado = json['Estado'];
    ciudad = json['Ciudad'];
    dCP = json['d_CP'];
    cEstado = json['c_estado'];
    cOficina = json['c_oficina'];
    cCP = json['c_CP'];
    cTipoAsenta = json['c_tipo_asenta'];
    cMnpio = json['c_mnpio'];
    idAsentaCpcons = json['id_asenta_cpcons'];
    dZona = json['d_zona'];
    cCveCiudad = json['c_cve_ciudad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_CP'] = this.idCP;
    data['CP'] = this.cP;
    data['Colonia'] = this.colonia;
    data['d_tipo_asenta'] = this.dTipoAsenta;
    data['MunDel'] = this.munDel;
    data['Estado'] = this.estado;
    data['Ciudad'] = this.ciudad;
    data['d_CP'] = this.dCP;
    data['c_estado'] = this.cEstado;
    data['c_oficina'] = this.cOficina;
    data['c_CP'] = this.cCP;
    data['c_tipo_asenta'] = this.cTipoAsenta;
    data['c_mnpio'] = this.cMnpio;
    data['id_asenta_cpcons'] = this.idAsentaCpcons;
    data['d_zona'] = this.dZona;
    data['c_cve_ciudad'] = this.cCveCiudad;
    return data;
  }
}
