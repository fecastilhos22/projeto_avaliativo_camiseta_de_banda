import 'package:flutter/material.dart';
import '../app/data/models/camiseta.dart';

class CamisetaCard extends StatelessWidget {
  final Camiseta camiseta;

  const CamisetaCard({super.key, required this.camiseta});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            Image.asset(
              camiseta.imagem,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 120,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported, size: 40),
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              camiseta.titulo,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('R\$ ${camiseta.preco.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            camiseta.disponivel
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/compra',
                        arguments: camiseta,
                      );
                    },
                    child: const Text('Comprar'),
                  )
                : const Text(
                    'Indisponível',
                    style: TextStyle(color: Colors.red),
                  ),
          ],
        ),
      ),
    );
  }
}
