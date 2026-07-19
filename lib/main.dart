import 'package:flutter/material.dart';
import 'view/catalogo_view.dart';
import 'view/compra_view.dart';
import 'app/data/models/camiseta.dart';

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
      onGenerateRoute: (settings) {
        if (settings.name == '/compra') {
          final camiseta = settings.arguments as Camiseta;
          return MaterialPageRoute(
            builder: (context) => CompraView(camiseta: camiseta),
          );
        }
        return null;
      },
    );
  }
}