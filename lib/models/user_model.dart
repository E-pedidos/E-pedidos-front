class UserModel {
  String? name;
  String? telWpp;
  String? address;
  String? nameEstabelecimento;
  String? cpfCnpj;
  String? categoryId;
  String? email;
  String? password;

  UserModel(
      {this.name,
      this.telWpp,
      this.address,
      this.nameEstabelecimento,
      this.cpfCnpj,
      this.categoryId,
      this.email,
      this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    telWpp = json['tel_wpp'];
    address = json['address'];
    nameEstabelecimento = json['name_estabelecimento'];
    cpfCnpj = json['cpf_cnpj'];
    categoryId = json['categoryId'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['tel_wpp'] = telWpp;
    data['address'] = address;
    data['name_estabelecimento'] = nameEstabelecimento;
    data['cpf_cnpj'] = cpfCnpj;
    data['categoryId'] = categoryId;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
