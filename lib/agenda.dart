class Agenda{
  int? id;
  String? data;
   String? assunto;
  
  Agenda({this.id, this.data,  this.assunto});

  Agenda.fromMap(Map<String, dynamic>res)
        : id = res["id"],
          data = res["Data"],
          assunto = res["assunto"];

      Map<String, dynamic> toMap(){
        return {'id': id,'data':data, 'assunto': assunto};
      }
}