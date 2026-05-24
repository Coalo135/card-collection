import 'package:cardcollection/widgets/button.dart';
import 'package:cardcollection/widgets/input.dart';
import 'package:flutter/material.dart';

class AddCard extends StatefulWidget {
  final String nomeColecao;

  AddCard({required this.nomeColecao});

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController edicaoController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();

  String raridade = 'Comum';
  List<String> raridades = ['Comum', 'Incomum', 'Rara', 'Mítica'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0D1A),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D0D1A),
        title: Text('Adicionar Carta', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_card, size: 64, color: Color(0xFF7C3AED)),
              SizedBox(height: 8),
              Text(
                'Nova Carta',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Coleção: ${widget.nomeColecao}',
                style: TextStyle(color: Colors.white54, fontSize: 13),
              ),

              SizedBox(height: 32),

              InputText(
                'Nome da carta',
                'Nome da carta',
                controller: nomeController,
              ),
              SizedBox(height: 16),
              InputText('Edição', 'Edição', controller: edicaoController),
              SizedBox(height: 16),
              InputText(
                'Quantidade',
                'Quantidade',
                controller: quantidadeController,
              ),

              SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: MyButton(
                  'Adicionar',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
