import 'package:flutter/material.dart';
import 'view/catalogo_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja Camiseta de Banda',
      home: const CatalogoView(),
    );
  }
}