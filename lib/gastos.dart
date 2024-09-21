class Gastos{
  int? id;
  String? despesas;
  String? data;
  String? valor;
  
  Gastos({this.id,  this.despesas,  this.data,  this.valor});

  Gastos.fromMap(Map<String, dynamic>res)
        : id = res["id"],
          despesas = res["despesas"],
          data = res["data"],
          valor = res["valor"];

      Map<String, dynamic> toMap(){
        return {'id': id, "despesas": despesas,'data':data, 'valor': valor};
      }
}