import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String texto;
  final void Function() onPressed;

  MyButton(this.texto, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(this.texto));
  }
}
