class GetMarcacoesModel {
  String? nsr;
  String? cpf;
  String? data;
  String? hora;
  String? cnpj;
  String? inpi_codigo;

  GetMarcacoesModel({
    this.nsr,
    this.cpf,
    this.data,
    this.hora,
    this.cnpj,
    this.inpi_codigo,
  });

  GetMarcacoesModel.fromJson(Map<String, dynamic> json) {
    nsr = json['nsr'];
    cpf = json['cpf'];
    data = json['data'];
    hora = json['hora'];
    cnpj = json['cnpj'];
    inpi_codigo = json['inpi_codigo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nsr'] = this.nsr;
    data['cpf'] = this.cpf;
    data['data'] = this.data;
    data['hora'] = this.hora;
    data['cnpj'] = this.cnpj;
    data['inpi_codigo'] = this.inpi_codigo;
    return data;
  }
}
