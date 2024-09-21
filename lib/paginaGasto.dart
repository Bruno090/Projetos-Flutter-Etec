import 'package:avaliacao/gastos.dart';
import 'package:flutter/material.dart';
import 'dataBaseHelper.dart';

    String data = "";
   TextEditingController txtDespesas = TextEditingController();
   TextEditingController txtvalor = TextEditingController();

  late dataBaseHelper dbHelper;
  List<Gastos>gastos = [];

class paginaGasto extends StatefulWidget {
  const paginaGasto({super.key});

  @override
  State<paginaGasto> createState() => _PaginaAgendaState();
}

class _PaginaAgendaState extends State<paginaGasto> {
  @override
  Widget build(BuildContext context) {
    dbHelper = dataBaseHelper();
    dbHelper.conectaDB().whenComplete(() async {
      gastos = await dbHelper.consultaGasto();
      setState(() {});
    });
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter')), 
        body:   Column(  children: [
           caixaDespesas(),
           caixaValor(),
           botaoExibeCalendario(),
           botaoIncluir(),
           Expanded(child: lista())],
           
    ));

    
  }
 exibeData(){
     showDatePicker(context: context,
                  initialDate: DateTime.now(), 
                  firstDate: DateTime(DateTime.now().year), 
                  lastDate: DateTime.now(),
                  initialDatePickerMode: DatePickerMode.day,
                  builder: (context, child) =>
                    SizedBox(height: 555, width: 500, child: child)
                    ).then((selectDate){
                      if(selectDate!=null){
                        setState(() => data = selectDate.toString());
                      }
                    });
  }
 
  caixaDespesas(){
    return TextField(
      controller: txtDespesas,
      decoration: const InputDecoration(labelText: 'Informe a despesa'),
    );
  }
  caixaValor(){
    return TextField(
      controller: txtvalor,
      decoration: const InputDecoration(labelText: 'Informe o valor'),
    );
  }
  
  botaoIncluir(){
    return ElevatedButton(
    child : const Text('incluir'), onPressed: () => inclur());
    
  }

  botaoExibeCalendario(){
    return ElevatedButton(onPressed: () => exibeData(), child: const Text("Data"));
  }


  lista(){
    return ListView.builder(
      itemCount: gastos.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () => carregaDados(gastos[index].despesas.toString(),gastos[index].data.toString(), gastos[index].valor.toString()),
            leading: CircleAvatar(child: Text(gastos[index].id.toString())),
            title: Text(gastos[index].despesas.toString()),
            trailing: Row(mainAxisSize: MainAxisSize.min,
              children: [ IconButton(onPressed: () => alterar(int.parse(gastos[index].id.toString())),
                                     icon: const Icon(Icons.edit)),
                          IconButton(onPressed: () => excluir(int.parse(gastos[index].id.toString())),
                                    icon: const Icon(Icons.delete))
                
              ])
        ));
        });
  }
}
 carregaDados(String despesas, String data, String valor){
    txtDespesas.text = despesas;
    data = data;
    txtvalor.text = valor;
  }

  limpar(){
    txtDespesas.clear();
    txtvalor.clear();
  }

  inclur() async {
    Gastos g = Gastos(data: data, despesas: txtDespesas.text, valor: txtvalor.text); 
    dbHelper.insertGasto(g);
    limpar();
  }
  alterar(int id) async{
    Gastos g = Gastos(id: id ,data: data, despesas: txtDespesas.text, valor : txtvalor.text);
    dbHelper.updateGasto(g);
    limpar();
  }
  excluir(int id) async{
    dbHelper.deleteGasto(id);
    limpar();
  }