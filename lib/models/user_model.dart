class UserModel {
  String? name;
  String? nameEstabelecimento;
  String? cpfCnpj;
  String? email;
  int? telWpp;
  String? address;
  String? category;
  String? password;

  UserModel(
      {this.name,
      this.nameEstabelecimento,
      this.cpfCnpj,
      this.email,
      this.telWpp,
      this.address,
      this.category,
      this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameEstabelecimento = json['name_estabelecimento'];
    cpfCnpj = json['cpf_cnpj'];
    email = json['email'];
    telWpp = json['tel_wpp'];
    address = json['address'];
    category = json['category'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['name_estabelecimento'] = this.nameEstabelecimento;
    data['cpf_cnpj'] = this.cpfCnpj;
    data['email'] = this.email;
    data['tel_wpp'] = this.telWpp;
    data['address'] = this.address;
    data['category'] = this.category;
    data['password'] = this.password;
    return data;
  }
}
