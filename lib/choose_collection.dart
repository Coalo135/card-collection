import 'package:cardcollection/widgets/button.dart';
import 'package:flutter/material.dart';
import 'collection.dart';
import 'create_collection.dart';

class ChooseCollection extends StatelessWidget {
  final List<String> colecoes = ['Coleção Teste'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0D1A),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D0D1A),
        title: Text('Minhas Coleções', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 16),

            Icon(
              Icons.collections_bookmark,
              size: 64,
              color: Color(0xFF7C3AED),
            ),
            SizedBox(height: 8),
            Text(
              'Suas Coleções',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 24),

            Expanded(
              child: ListView.builder(
                itemCount: colecoes.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFF1A1A2E),
                    margin: EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Icon(Icons.style, color: Color(0xFF7C3AED)),
                      title: Text(
                        colecoes[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white38,
                        size: 16,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Collection(nome: colecoes[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: MyButton(
                'Nova Coleção',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateCollection()),
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
