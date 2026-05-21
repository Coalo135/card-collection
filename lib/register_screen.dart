import 'package:cardcollection/widgets/button.dart';
import 'package:cardcollection/widgets/input.dart';
import 'package:flutter/material.dart';
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

  // TODO: adicionar validação Acho que fica no BACK
  bool _senhasIguais = true;

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
              Text(
                'Criar conta',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 32),

              InputText('Nome', 'Nome', controller: nomeController),
              SizedBox(height: 16),
              InputText('Email', 'Email', controller: emailController),
              SizedBox(height: 16),
              InputText(
                'Senha',
                'Senha',
                esconder: true,
                controller: senhaController,
              ),
              SizedBox(height: 16),
              InputText(
                'Confirmar Senha',
                'Confirmar Senha',
                esconder: true,
                controller: confirmarSenhaController,
              ),

              if (!_senhasIguais)
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'As senhas não coincidem!',
                    style: TextStyle(color: Colors.redAccent, fontSize: 12),
                  ),
                ),

              SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: MyButton(
                  'Cadastrar',
                  onPressed: () {
                    if (senhaController.text != confirmarSenhaController.text) {
                      setState(() {
                        _senhasIguais = false;
                      });
                      return;
                    }
                    setState(() {
                      _senhasIguais = true;
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ),

              SizedBox(height: 12),

              MyButton(
                'Já tem conta? Faça login',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
