import 'package:flutter/material.dart';
import '../app/data/models/camiseta.dart';
import '../app/data/models/compra.dart';
import '../viewModel/camiseta_viewmodel.dart';

class CompraView extends StatefulWidget {
  final Camiseta camiseta;

  const CompraView({super.key, required this.camiseta});

  @override
  State<CompraView> createState() => _CompraViewState();
}

class _CompraViewState extends State<CompraView> {
  final _formKey = GlobalKey<FormState>();
  final CamisetaViewModel _viewModel = CamisetaViewModel();

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

  double calcularTotalComJuros(double preco) {
    final subtotal = preco * _quantidade;
    final percentualJuros = (_parcelas - 1) * 0.005;

    return subtotal + (subtotal * percentualJuros);
  }

  @override
  Widget build(BuildContext context) {
    final camiseta = widget.camiseta;
    final totalComJuros = calcularTotalComJuros(camiseta.preco);

    return Scaffold(
      appBar: AppBar(title: const Text('Finalizar Compra')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            
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

             
              Text(
                'R\$ ${camiseta.preco.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              
              DropdownButtonFormField<String>(
                initialValue: _tamanhoSelecionado,
                decoration: const InputDecoration(labelText: 'Tamanho'),
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Selecione um tamanho';
                  }

                  return null;
                },
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

              
              DropdownButtonFormField<int>(
                initialValue: _parcelas,
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

              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do comprador',
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o nome do comprador';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _enderecoController,
                decoration: const InputDecoration(
                  labelText: 'Endereço de entrega',
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o endereço de entrega';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Total: R\$ ${totalComJuros.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              
              ElevatedButton(
                onPressed: () async {
                  final formularioValido =
                      _formKey.currentState?.validate() ?? false;

                  if (!formularioValido) {
                    return;
                  }

                  final compra = Compra(
                    produtoTitulo: camiseta.titulo,
                    tamanho: _tamanhoSelecionado!,
                    quantidade: _quantidade,
                    valorTotal: totalComJuros,
                    parcelas: _parcelas,
                    responsavel: _nomeController.text.trim(),
                    endereco: _enderecoController.text.trim(),
                  );

                  _viewModel.finalizarCompra(compra);

                  final snackBarController = ScaffoldMessenger.of(context)
                      .showSnackBar(
                        const SnackBar(
                          content: Text('Compra realizada com sucesso'),
                        ),
                      );

                  await snackBarController.closed;

                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Finalizar Compra'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
