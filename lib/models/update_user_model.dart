class UserUpdateModel {
  String? name;
  String? telWpp;
  String? nameEstabelecimento;
  String? cpfCnpj;
  String? email;
  

  UserUpdateModel(
      {this.name,
      this.telWpp,
      this.nameEstabelecimento,
      this.cpfCnpj,
      this.email,
});

  UserUpdateModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    telWpp = json['tel_wpp'];
    nameEstabelecimento = json['name_estabelecimento'];
    cpfCnpj = json['cpf_cnpj'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['tel_wpp'] = telWpp;
    data['name_estabelecimento'] = nameEstabelecimento;
    data['cpf_cnpj'] = cpfCnpj;
    data['email'] = email;
    return data;
  }
}