import 'package:cardcollection/widgets/button.dart';
import 'package:cardcollection/widgets/input.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();

  bool _carregando = false;
  String _erro = '';

  void _cadastrar() async {
    if (senhaController.text != confirmarSenhaController.text) {
      setState(() { _erro = 'As senhas não coincidem!'; });
      return;
    }

    setState(() { _carregando = true; _erro = ''; });

    try {
      final resposta = await ApiService.cadastrar(
        nomeController.text,
        emailController.text,
        senhaController.text,
      );

      if (resposta['token'] != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        setState(() { _erro = resposta['message'] ?? 'Erro ao cadastrar'; });
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
        title: Text('Cadastro', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(Icons.person_add, size: 72, color: Color(0xFF7C3AED)),
              SizedBox(height: 8),
              Text('Criar conta', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),

              SizedBox(height: 32),

              InputText('Nome', 'Nome', controller: nomeController),
              SizedBox(height: 16),
              InputText('Email', 'Email', controller: emailController),
              SizedBox(height: 16),
              InputText('Senha', 'Senha', esconder: true, controller: senhaController),
              SizedBox(height: 16),
              InputText('Confirmar Senha', 'Confirmar Senha', esconder: true, controller: confirmarSenhaController),

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
                  : MyButton('Cadastrar', onPressed: _cadastrar),
              ),

              SizedBox(height: 12),

              MyButton('Já tem conta? Faça login', onPressed: () => Navigator.pop(context)),

            ],
          ),
        ),
      ),
    );
  }
}
