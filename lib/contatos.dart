class Contato{
  int? id;
  String nome;
  String fone;
  String email;
  
  Contato({this.id, required this.nome, required this.fone, required this.email});

  Contato.fromMap(Map<String, dynamic>res)
        : id = res["id"],
          nome = res["nome"],
          fone = res["fone"],
          email = res["email"];

      Map<String, dynamic> toMap(){
        return {'id': id,'nome':nome, 'fone': fone, 'email':email};
      }
}