import 'package:cardcollection/widgets/button.dart';
import 'package:flutter/material.dart';
import 'edit_collection.dart';
import 'add_card.dart';

class Collection extends StatelessWidget {
  final String nome;

  Collection({required this.nome});

  final List<String> cartas = ['Carta 1', 'Carta 2', 'Carta 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0D1A),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D0D1A),
        title: Text(nome, style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Color(0xFF7C3AED)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditCollection(nome: nome)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [

            SizedBox(height: 16),

            Icon(Icons.style, size: 64, color: Color(0xFF7C3AED)),
            SizedBox(height: 8),
            Text(nome, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            Text('${cartas.length} cartas', style: TextStyle(color: Colors.white54)),

            SizedBox(height: 24),

            Expanded(
              child: ListView.builder(
                itemCount: cartas.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFF1A1A2E),
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Icon(Icons.style, color: Color(0xFF7C3AED)),
                      title: Text(cartas[index], style: TextStyle(color: Colors.white)),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: MyButton(
                'Adicionar Carta',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddCard(nomeColecao: nome)),
                  );
                },
              ),
            ),

            SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
