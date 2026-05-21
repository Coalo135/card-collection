import 'package:cardcollection/widgets/button.dart';
import 'package:cardcollection/widgets/input.dart';
import 'package:flutter/material.dart';
import 'choose_collection.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

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
              SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: MyButton(
                  'ENTRAR',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChooseCollection(),
                      ),
                    );
                  },
                ),
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
