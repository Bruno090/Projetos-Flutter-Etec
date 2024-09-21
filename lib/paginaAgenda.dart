import 'package:flutter/material.dart';
import 'dataBaseHelper.dart';
import 'agenda.dart';

    String data = "";
   TextEditingController txtAssunto = TextEditingController();

  late dataBaseHelper dbHelper;
  List<Agenda>Agendas = [];

class PaginaAgenda extends StatefulWidget {
  const PaginaAgenda({super.key});

  @override
  State<PaginaAgenda> createState() => _PaginaAgendaState();
}

class _PaginaAgendaState extends State<PaginaAgenda> {
  @override
  Widget build(BuildContext context) {
    dbHelper = dataBaseHelper();
    dbHelper.conectaDB().whenComplete(() async {
      Agendas = await dbHelper.consultaAgenda();
      setState(() {});
    });
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter')), 
        body:   Column(  children: [
           caixaAssunto(),
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
 
  caixaAssunto(){
    return TextField(
      controller: txtAssunto,
      decoration: const InputDecoration(labelText: 'Informe o Assunto do compromisso'),
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
      itemCount: Agendas.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () => carregaDados(Agendas[index].data.toString(),Agendas[index].assunto.toString()),
            leading: CircleAvatar(child: Text(Agendas[index].id.toString())),
            title: Text(Agendas[index].assunto.toString()),
            trailing: Row(mainAxisSize: MainAxisSize.min,
              children: [ IconButton(onPressed: () => alterar(int.parse(Agendas[index].id.toString())),
                                     icon: const Icon(Icons.edit)),
                          IconButton(onPressed: () => excluir(int.parse(Agendas[index].id.toString())),
                                    icon: const Icon(Icons.delete))
                
              ])
        ));
        });
  }
}
 carregaDados(String assunto, String data){
    txtAssunto.text = assunto;
    data = data;
  }

  limpar(){
    txtAssunto.clear();
  }

  inclur() async {
    Agenda a = Agenda(data: data, assunto: txtAssunto.text); 
    dbHelper.insertAgeda(a);
    limpar();
  }
  alterar(int id) async{
    Agenda a = Agenda(id: id ,data: data, assunto: txtAssunto.text);
    dbHelper.updateAgenda(a);
    limpar();
  }
  excluir(int id) async{
    dbHelper.deleteAgenda(id);
    limpar();
  }