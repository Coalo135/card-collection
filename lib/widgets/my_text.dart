import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  String s;
  Color cor;
  MyText(this.s, this.cor);

  @override
  Widget build(BuildContext context) {
    return Text(s, style: TextStyle(color: cor, fontSize: 26));
  }
}
