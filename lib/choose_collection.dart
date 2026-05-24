import 'package:cardcollection/widgets/button.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'collection.dart';
import 'create_collection.dart';

class ChooseCollection extends StatefulWidget {
  @override
  _ChooseCollectionState createState() => _ChooseCollectionState();
}

class _ChooseCollectionState extends State<ChooseCollection> {
  List<dynamic> colecoes = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarColecoes();
  }

  void _carregarColecoes() async {
    setState(() {
      _carregando = true;
    });
    final lista = await ApiService.getColecoes();
    setState(() {
      colecoes = lista;
      _carregando = false;
    });
  }

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
              child: _carregando
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 182, 151, 13),
                      ),
                    )
                  : colecoes.isEmpty
                  ? Center(
                      child: Text(
                        'Nenhuma coleção ainda',
                        style: TextStyle(color: Colors.white54),
                      ),
                    )
                  : ListView.builder(
                      itemCount: colecoes.length,
                      itemBuilder: (context, index) {
                        final colecao = colecoes[index];
                        return Card(
                          color: Color(0xFF1A1A2E),
                          margin: EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: Icon(
                              Icons.style,
                              color: Color(0xFF7C3AED),
                            ),
                            title: Text(
                              colecao['nameCollection'] ?? '',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              '${(colecao['cards'] as List).length} cartas',
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 12,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white38,
                              size: 16,
                            ),
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Collection(colecao: colecao),
                                ),
                              );
                              _carregarColecoes();
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
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateCollection()),
                  );
                  _carregarColecoes();
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
