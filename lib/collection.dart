import 'package:cardcollection/widgets/button.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'edit_collection.dart';
import 'add_card.dart';

class Collection extends StatefulWidget {
  final Map<String, dynamic> colecao;

  Collection({required this.colecao});

  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  late List<dynamic> cartas;
  late String nome;
  late String colecaoId;

  @override
  void initState() {
    super.initState();
    nome = widget.colecao['nameCollection'] ?? '';
    colecaoId = widget.colecao['_id'] ?? '';
    cartas = List.from(widget.colecao['cards'] ?? []);
  }

  void _deletarCarta(Map<String, dynamic> carta) async {
    final res = await ApiService.deletarCarta(
      colecaoId,
      carta['set'],
      carta['_id'],
    );

    if (res['message'] != null) {
      setState(() {
        cartas.removeWhere((c) => c['_id'] == carta['_id']);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 300),
          content: Text(
            'Carta removida!',
            style: TextStyle(color: Colors.amber),
          ),
          backgroundColor: const Color.fromARGB(255, 85, 16, 7),
        ),
      );
    }
  }

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
            onPressed: () async {
              final resultado = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditCollection(colecaoId: colecaoId, nomeAtual: nome),
                ),
              );
              if (resultado != null && resultado is String) {
                setState(() {
                  nome = resultado;
                });
              }
              if (resultado == 'deletado') {
                Navigator.pop(context);
              }
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
            Text(
              nome,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              '${cartas.length} cartas',
              style: TextStyle(color: Colors.white54),
            ),
            SizedBox(height: 24),

            Expanded(
              child: cartas.isEmpty
                  ? Center(
                      child: Text(
                        'Nenhuma carta ainda',
                        style: TextStyle(color: Colors.white54),
                      ),
                    )
                  : ListView.builder(
                      itemCount: cartas.length,
                      itemBuilder: (context, index) {
                        final carta = cartas[index];
                        return Card(
                          color: Color(0xFF1A1A2E),
                          margin: EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: carta['image'] != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      carta['image'],
                                      width: 36,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(Icons.style, color: Color(0xFF7C3AED)),
                            title: Text(
                              carta['name'] ?? '',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              '${carta['setName'] ?? ''} • qtd: ${carta['qtd'] ?? 1}',
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 12,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                                size: 20,
                              ),
                              onPressed: () => _deletarCarta(carta),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            SizedBox(
              width: double.infinity,
              child: MyButton(
                'Adicionar Carta',
                onPressed: () async {
                  final novaCarta = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddCard(colecaoId: colecaoId, nomeColecao: nome),
                    ),
                  );
                  if (novaCarta != null) {
                    setState(() {
                      cartas.add(novaCarta);
                    });
                  }
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
