import 'package:cardcollection/widgets/button.dart';
import 'package:cardcollection/widgets/input.dart';
import 'package:flutter/material.dart';

class CreateCollection extends StatefulWidget {
  @override
  _CreateCollectionState createState() => _CreateCollectionState();
}

class _CreateCollectionState extends State<CreateCollection> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();

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
              Text(
                'Criar Coleção',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),

              SizedBox(height: 32),

              InputText('Nome da coleção', 'Nome da coleção', controller: nomeController),
              SizedBox(height: 16),
              InputText('Descrição', 'Descrição', controller: descricaoController),

              SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: MyButton(
                  'Criar',
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
