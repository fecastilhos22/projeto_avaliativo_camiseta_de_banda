import 'package:flutter/material.dart';
import '../app/data/models/camiseta.dart';

class CompraView extends StatefulWidget {
  final Camiseta camiseta;

  const CompraView({super.key, required this.camiseta});

  @override
  State<CompraView> createState() => _CompraViewState();
}

class _CompraViewState extends State<CompraView> {
  final _formKey = GlobalKey<FormState>();

  String? _tamanhoSelecionado;
  int _quantidade = 1;
  int _parcelas = 1;
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _enderecoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final camiseta = widget.camiseta;

    return Scaffold(
      appBar: AppBar(title: const Text('Finalizar Compra')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Imagem
              Image.asset(
                camiseta.imagem,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 40),
                  );
                },
              ),
              const SizedBox(height: 8),

              // Preço unitário
              Text(
                'R\$ ${camiseta.preco.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Tamanho (Dropdown)
              DropdownButtonFormField<String>(
                value: _tamanhoSelecionado,
                decoration: const InputDecoration(labelText: 'Tamanho'),
                items: camiseta.tamanhosDisponiveis
                    .map(
                      (tamanho) => DropdownMenuItem(
                        value: tamanho,
                        child: Text(tamanho),
                      ),
                    )
                    .toList(),
                onChanged: (novoValor) {
                  setState(() {
                    _tamanhoSelecionado = novoValor;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Quantidade
              Row(
                children: [
                  const Text('Quantidade:'),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (_quantidade > 1) {
                        setState(() {
                          _quantidade--;
                        });
                      }
                    },
                  ),

                  Text('$_quantidade'),

                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (_quantidade < 5) {
                        setState(() {
                          _quantidade++;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Parcelas (Dropdown)
              DropdownButtonFormField<int>(
                value: _parcelas,
                decoration: const InputDecoration(labelText: 'Parcelas'),
                items: List.generate(6, (index) => index + 1)
                    .map(
                      (n) => DropdownMenuItem(value: n, child: Text('${n}x')),
                    )
                    .toList(),
                onChanged: (novoValor) {
                  setState(() {
                    _parcelas = novoValor!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Nome do comprador
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do comprador',
                ),
              ),
              const SizedBox(height: 16),

              // Endereço de entrega
              TextFormField(
                controller: _enderecoController,
                decoration: const InputDecoration(
                  labelText: 'Endereço de entrega',
                ),
              ),
              const SizedBox(height: 16),

              // Card de total (fixo por enquanto)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Total: R\$ ${(camiseta.preco * _quantidade).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Botão finalizar
              ElevatedButton(
                onPressed: () {},
                child: const Text('Finalizar Compra'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
