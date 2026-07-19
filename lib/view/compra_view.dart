import 'package:flutter/material.dart';
import '../app/data/models/camiseta.dart';

class CompraView extends StatelessWidget {
  final Camiseta camiseta;

  const CompraView({super.key, required this.camiseta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finalizar Compra')),
      body: Center(
        child: Text('Comprando: ${camiseta.titulo}'),
      ),
    );
  }
}