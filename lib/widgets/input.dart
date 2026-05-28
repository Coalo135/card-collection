import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  String rotulo;
  String label;
  TextEditingController controller;
  bool esconder;

  InputText(
    this.rotulo,
    this.label, {
    this.esconder = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: esconder,
      style: TextStyle(color: Color (0xFF7C3AED), backgroundColor: Colors.transparent),
      decoration: InputDecoration(
        labelText: rotulo,
        hintText: label,

        border: OutlineInputBorder(),
      ),
    );
  }
}
