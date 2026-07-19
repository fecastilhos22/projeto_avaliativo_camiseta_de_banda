import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja Camiseta de Banda',
      home: Scaffold(
        appBar: AppBar(title: const Text('Catálogo')),
        body: const Center(
          child: Text('Em construção...'),
        ),
      ),
    );
  }
}