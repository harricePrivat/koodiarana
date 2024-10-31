class ModelUser {
  String nom;
  String prenom;
  String dateDeNaissance;
  String email;
  String num;
  String password;
  ModelUser(
      {required this.nom,
      required this.prenom,
      required this.dateDeNaissance,
      required this.email,
      required this.num,
      required this.password});

  Map<String, dynamic> toJson() {
    return {
      "nom": nom,
      "prenom": prenom,
      "dateDeNaissance": dateDeNaissance,
      "email": email,
      "num": num,
      "password": password,
      "emailVerified": false
    };
  }
}
