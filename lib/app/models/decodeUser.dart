class DecodeUser {
  String email;
  String unique_name;
  String role;
  int nbf;
  int exp;
  int iat;

  DecodeUser(
      this.email, this.unique_name, this.role, this.nbf, this.exp, this.iat);

  static fromJson(Map<String, dynamic> object) {
    return DecodeUser(object["email"], object["unique_name"], object["role"],
        object["nbf"], object["exp"], object["iat"]);
  }
}
