class UserModel {
  String? name;
  String? telWpp;
  String? keyPix;
  String? nameEstabelecimento;
  String? cpfCnpj;
  String? categoryId;
  String? email;
  String? password;

  UserModel(
      {this.name,
      this.telWpp,
      this.keyPix,
      this.nameEstabelecimento,
      this.cpfCnpj,
      this.categoryId,
      this.email,
      this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    telWpp = json['tel_wpp'];
    keyPix = json['pix_key'];
    nameEstabelecimento = json['name_estabelecimento'];
    cpfCnpj = json['cpf_cnpj'];
    categoryId = json['categoryId'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['tel_wpp'] = telWpp;
    data['pix_key'] = keyPix;
    data['name_estabelecimento'] = nameEstabelecimento;
    data['cpf_cnpj'] = cpfCnpj;
    data['categoryId'] = categoryId;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
