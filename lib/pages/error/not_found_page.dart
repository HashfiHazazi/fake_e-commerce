import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GradientText(
          'Not Found Page',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          colors: const <Color>[Colors.purple, Colors.lightBlue],
        ),
      ),
    );
  }
}
