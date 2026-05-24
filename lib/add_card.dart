import 'dart:convert';

import 'package:cardcollection/widgets/button.dart';
import 'package:cardcollection/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class AddCard extends StatefulWidget {
  final String colecaoId;
  final String nomeColecao;

  AddCard({required this.colecaoId, required this.nomeColecao});

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController qtdController = TextEditingController(text: '1');

  bool _buscando = false;
  bool _adicionando = false;
  String _erro = '';
  String? _imagemAtual;

  // resultado da busca
  Map<String, dynamic>? _cartaEncontrada;
  List<dynamic> _setsDisponiveis = [];
  String? _setSelecionado;

  void _buscarCarta() async {
    if (nomeController.text.isEmpty) return;

    setState(() {
      _buscando = true;
      _erro = '';
      _cartaEncontrada = null;
      _setsDisponiveis = [];
      _setSelecionado = null;
    });

    try {
      final res = await ApiService.buscarCarta(nomeController.text);

      if (res['name'] != null) {
        setState(() {
          _cartaEncontrada = res;
          _setsDisponiveis = res['sets'] ?? [];
          if (_setsDisponiveis.isNotEmpty) {
            _setSelecionado = _setsDisponiveis[0]['set'];
          }
          _imagemAtual = res['image'];
        });
      } else {
        setState(() {
          _erro = res['message'] ?? 'Carta não encontrada';
        });
      }
    } catch (e) {
      setState(() {
        _erro = 'Erro de conexão';
      });
    }

    setState(() {
      _buscando = false;
    });
  }

  void _adicionarCarta() async {
    if (_cartaEncontrada == null || _setSelecionado == null) return;

    setState(() {
      _adicionando = true;
    });

    final qtd = int.tryParse(qtdController.text) ?? 1;

    try {
      final res = await ApiService.adicionarCarta(
        _cartaEncontrada!['name'],
        widget.colecaoId,
        _setSelecionado!,
        qtd,
      );

      if (res['message'] == 'Carta adicionada com sucesso!') {
        Navigator.pop(context, {
          'name': _cartaEncontrada!['name'],
          'image': _cartaEncontrada!['image'],
          'set': _setSelecionado,
          'qtd': qtd,
        });
      } else {
        setState(() {
          _erro = res['message'] ?? 'Erro ao adicionar';
        });
      }
    } catch (e) {
      setState(() {
        _erro = 'Erro de conexão';
      });
    }

    setState(() {
      _adicionando = false;
    });
  }

  void _trocarSet(String? novoSet) async {
    if (novoSet == null) return;

    setState(() {
      _setSelecionado = novoSet;
      _imagemAtual = null;
    });

    try {
      final nomeEncoded = Uri.encodeComponent(_cartaEncontrada!['name']);
      final res = await http.get(
        Uri.parse(
          'https://api.scryfall.com/cards/named?exact=$nomeEncoded&set=$novoSet',
        ),
      );
      final dados = jsonDecode(res.body);

      final imagem = dados['image_uris'] != null
          ? dados['image_uris']['normal']
          : dados['card_faces'][0]['image_uris']['normal'];

      setState(() {
        _imagemAtual = imagem;
      });
    } catch (e) {}
  }

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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
              child: Column(
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
                ],
              ),
            ),

            SizedBox(height: 32),

            Row(
              children: [
                Expanded(
                  child: InputText(
                    'Nome da carta',
                    'Nome da carta',
                    controller: nomeController,
                  ),
                ),
                SizedBox(width: 10),
                _buscando
                    ? SizedBox(
                        width: 48,
                        height: 48,
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 182, 151, 13),
                        ),
                      )
                    : IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Color(0xFF7C3AED),
                        ),
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: _buscarCarta,
                      ),
              ],
            ),

            if (_erro.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  _erro,
                  style: TextStyle(color: Colors.redAccent, fontSize: 13),
                ),
              ),

            if (_cartaEncontrada != null) ...[
              SizedBox(height: 24),

              Row(
                children: [
                  if (_imagemAtual != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        _imagemAtual!,
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    SizedBox(
                      width: 70,
                      height: 95,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 182, 151, 13),
                        ),
                      ),
                    ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      _cartaEncontrada!['name'] ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Text(
                'Escolha o Set:',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF7C3AED)),
                ),
                child: DropdownButton<String>(
                  value: _setSelecionado,
                  isExpanded: true,
                  dropdownColor: Color(0xFF1A1A2E),
                  underline: SizedBox(),
                  style: TextStyle(color: Colors.white),
                  items: _setsDisponiveis.map((s) {
                    return DropdownMenuItem<String>(
                      value: s['set'],
                      child: Text('${s['set_name']} (${s['set']})'),
                    );
                  }).toList(),
                  onChanged: _trocarSet,
                ),
              ),

              SizedBox(height: 16),
              InputText('Quantidade', 'Quantidade', controller: qtdController),

              SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: _adicionando
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF7C3AED),
                        ),
                      )
                    : MyButton('Adicionar', onPressed: _adicionarCarta),
              ),
            ],

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
