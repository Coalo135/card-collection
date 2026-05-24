import 'package:cardcollection/widgets/button.dart';
import 'package:cardcollection/widgets/input.dart';
import 'package:flutter/material.dart';

class EditCollection extends StatefulWidget {
  final String nome;

  EditCollection({required this.nome});

  @override
  _EditCollectionState createState() => _EditCollectionState();
}

class _EditCollectionState extends State<EditCollection> {
  late TextEditingController nomeController;
  late TextEditingController descricaoController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.nome);
    descricaoController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0D1A),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D0D1A),
        title: Text('Editar Coleção', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.edit, size: 72, color: Color(0xFF7C3AED)),
              SizedBox(height: 8),
              Text(
                'Editar Coleção',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 32),

              InputText(
                'Nome da coleção',
                'Nome da coleção',
                controller: nomeController,
              ),
              SizedBox(height: 16),
              InputText(
                'Descrição',
                'Descrição',
                controller: descricaoController,
              ),

              SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: MyButton(
                  'Salvar',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              SizedBox(height: 8),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Excluir coleção',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
