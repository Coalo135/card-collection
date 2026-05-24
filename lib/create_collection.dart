import 'package:cardcollection/widgets/button.dart';
import 'package:cardcollection/widgets/input.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';

class CreateCollection extends StatefulWidget {
  @override
  _CreateCollectionState createState() => _CreateCollectionState();
}

class _CreateCollectionState extends State<CreateCollection> {
  TextEditingController nomeController = TextEditingController();

  bool _carregando = false;
  String _erro = '';

  void _criarColecao() async {
    if (nomeController.text.isEmpty) {
      setState(() { _erro = 'Digite um nome para a coleção'; });
      return;
    }

    setState(() { _carregando = true; _erro = ''; });

    try {
      final res = await ApiService.criarColecao(nomeController.text);

      if (res['message'] == 'Coleção criada com sucesso!') {
        Navigator.pop(context);
      } else {
        setState(() { _erro = res['message'] ?? 'Erro ao criar coleção'; });
      }
    } catch (e) {
      setState(() { _erro = 'Erro de conexão'; });
    }

    setState(() { _carregando = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0D1A),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D0D1A),
        title: Text('Nova Coleção', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(Icons.create_new_folder, size: 72, color: Color(0xFF7C3AED)),
              SizedBox(height: 8),
              Text('Criar Coleção', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),

              SizedBox(height: 32),

              InputText('Nome da coleção', 'Nome da coleção', controller: nomeController),

              if (_erro.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(_erro, style: TextStyle(color: Colors.redAccent, fontSize: 13)),
                ),

              SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: _carregando
                  ? Center(child: CircularProgressIndicator(color: Color(0xFF7C3AED)))
                  : MyButton('Criar', onPressed: _criarColecao),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
