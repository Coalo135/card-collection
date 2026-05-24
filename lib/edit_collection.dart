import 'package:cardcollection/widgets/button.dart';
import 'package:cardcollection/widgets/input.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';

class EditCollection extends StatefulWidget {
  final String colecaoId;
  final String nomeAtual;

  EditCollection({required this.colecaoId, required this.nomeAtual});

  @override
  _EditCollectionState createState() => _EditCollectionState();
}

class _EditCollectionState extends State<EditCollection> {
  late TextEditingController nomeController;

  bool _carregando = false;
  String _erro = '';

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.nomeAtual);
  }

  void _salvar() async {
    setState(() { _carregando = true; _erro = ''; });

    try {
      final res = await ApiService.editarColecao(widget.colecaoId, nomeController.text);

      if (res['message'] == 'Coleção atualizada com sucesso!') {
        Navigator.pop(context, nomeController.text); // retorna o novo nome
      } else {
        setState(() { _erro = res['message'] ?? 'Erro ao salvar'; });
      }
    } catch (e) {
      setState(() { _erro = 'Erro de conexão'; });
    }

    setState(() { _carregando = false; });
  }

  void _excluir() async {
    // confirmacao antes de deletar
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1A1A2E),
        title: Text('Excluir?', style: TextStyle(color: Colors.white)),
        content: Text('Tem certeza? Isso não tem como desfazer.', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancelar', style: TextStyle(color: Colors.white54)),
          ),
          MyButton('Excluir', onPressed: () => Navigator.pop(context, true)),
        ],
      ),
    );

    if (confirmar != true) return;

    setState(() { _carregando = true; });

    try {
      final res = await ApiService.deletarColecao(widget.colecaoId);

      if (res['message'] == 'Coleção deletada com sucesso!') {
        Navigator.pop(context, 'deletado');
      } else {
        setState(() { _erro = res['message'] ?? 'Erro ao excluir'; });
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
              Text('Editar Coleção', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),

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
                  : MyButton('Salvar', onPressed: _salvar),
              ),

              SizedBox(height: 8),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: _carregando ? null : _excluir,
                  child: Text('Excluir coleção', style: TextStyle(color: Colors.redAccent)),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
