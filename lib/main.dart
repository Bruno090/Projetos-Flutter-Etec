import 'package:flutter/material.dart';
import 'paginaGasto.dart';
import 'paginaAgenda.dart';
import 'paginaContatos.dart';
void main() {
  runApp(const MaterialApp(title: 'Flutter', home: MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int paginaAtual = 0;
  final List paginas = [  const  paginaGasto(), const PaginaAgenda(), const PaginaContato() ];

  atualizarPagina(int value){
    setState(() => paginaAtual = value);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter')),
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children:  [
            const UserAccountsDrawerHeader(
              accountName: Text("Everton 7"), accountEmail: Text("EvertonSemArCondicionado@etec.sp.gov.br"),
              currentAccountPicture: CircleAvatar(child: Text("E7"))),
              ListTile(
                 leading: const Icon(Icons.home),
                title: const Text("Gastos"),
                onTap:() {
                  Navigator.pop(context);
                  atualizarPagina(0);
                }),
                 ListTile(
                 leading: const Icon(Icons.home),
                title: const Text("Agenda"),
                onTap:() {
                  Navigator.pop(context);
                  atualizarPagina(1);
                }),
                 ListTile(
                 leading: const Icon(Icons.home),
                title: const Text("Contato"),
                onTap:() {
                  Navigator.pop(context);
                  atualizarPagina(2);
                }),
    ])), 
        body: paginas[paginaAtual]);
  }
}


