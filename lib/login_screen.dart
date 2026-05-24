import 'package:cardcollection/widgets/button.dart';
import 'package:cardcollection/widgets/input.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'choose_collection.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  bool _carregando = false;
  String _erro = '';

  void _login() async {
    setState(() {
      _carregando = true;
      _erro = '';
    });

    try {
      final resposta = await ApiService.login(
        emailController.text,
        senhaController.text,
      );

      if (resposta['token'] != null) {
        tokenUsuario = resposta['token'];
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChooseCollection()),
        );
      } else {
        setState(() {
          _erro = resposta['message'] ?? 'Erro ao fazer login';
        });
      }
    } catch (e) {
      setState(() {
        _erro = 'Erro de conexão';
      });
    }

    setState(() {
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0D1A),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.style, size: 72, color: Color(0xFF7C3AED)),
              SizedBox(height: 12),
              Text(
                'CARD COLLECTION',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              Text(
                'Gerencie suas cartas',
                style: TextStyle(color: Colors.white54, fontSize: 13),
              ),

              SizedBox(height: 40),

              InputText('Email', 'Email', controller: emailController),
              SizedBox(height: 16),
              InputText(
                'Senha',
                'Senha',
                esconder: true,
                controller: senhaController,
              ),

              if (_erro.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    _erro,
                    style: TextStyle(color: Colors.redAccent, fontSize: 13),
                  ),
                ),

              SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: _carregando
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF7C3AED),
                        ),
                      )
                    : MyButton('ENTRAR', onPressed: _login),
              ),

              SizedBox(height: 12),

              MyButton(
                'Não tem conta? Cadastre-se',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
