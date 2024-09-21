import 'package:flutter/material.dart';
import 'dataBaseHelper.dart';
import 'contatos.dart';

   TextEditingController txtNome = TextEditingController();
   TextEditingController txtFone = TextEditingController();
   TextEditingController txtEmail = TextEditingController();

  late dataBaseHelper dbHelper;
  List<Contato>contato = [];

class PaginaContato extends StatefulWidget {
  const PaginaContato({super.key});

  @override
  State<PaginaContato> createState() => _PaginaContatoState();
}

class _PaginaContatoState extends State<PaginaContato> {
  @override
  Widget build(BuildContext context) {
    dbHelper = dataBaseHelper();
    dbHelper.conectaDB().whenComplete(() async {
      contato = await dbHelper.consultaContato();
      setState(() {});
    });
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter')), 
        body:   Column(  children: [
           caixaNome(),
           caixaFone(),
           caixaEmail(),
           botaoIncluir(),
           Expanded(child: lista())],
           
    ));

    
  }
 
  caixaNome(){
    return TextField(
      controller: txtNome,
      decoration: const InputDecoration(labelText: 'Informe o Nome do Contato'),
    );
  }
    caixaFone(){
    return TextField(
      controller: txtFone,
      decoration: const InputDecoration(labelText: 'Informe o Numero do Contato'),
    );
  }
    caixaEmail(){
    return TextField(
      controller: txtEmail,
      decoration: const InputDecoration(labelText: 'Informe o Email do Contato'),
    );
  }
  
  botaoIncluir(){
    return ElevatedButton(
    child : const Text('incluir'), onPressed: () => inclur());
    
  }

  lista(){
    return ListView.builder(
      itemCount: contato.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () => carregaDados(contato[index].nome.toString(),contato[index].email.toString(), contato[index].email.toString()),
            leading: CircleAvatar(child: Text(contato[index].id.toString())),
            title: Text(contato[index].nome.toString()),
            trailing: Row(mainAxisSize: MainAxisSize.min,
              children: [ IconButton(onPressed: () => alterar(int.parse(contato[index].id.toString())),
                                     icon: const Icon(Icons.edit)),
                          IconButton(onPressed: () => excluir(int.parse(contato[index].id.toString())),
                                    icon: const Icon(Icons.delete))
                
              ])
        ));
        });
  }
}
 carregaDados(String nome, String fone, String email){
    
    txtNome.text = nome;
    txtFone.text = fone;
    txtEmail.text = email;
    
  }

  limpar(){
    txtNome.clear();
    txtFone.clear();
    txtEmail.clear();
  }

  inclur() async {
    Contato c = Contato(nome: txtNome.text, fone: txtFone.text, email: txtEmail.text); 
    dbHelper.insertContato(c);
    limpar();
  }
  alterar(int id) async{
    Contato c = Contato(id: id ,nome: txtNome.text, fone: txtFone.text, email: txtEmail.text);
    dbHelper.updateContato(c);
    limpar();
  }
  excluir(int id) async{
    dbHelper.deleteContato(id);
    limpar();
  }