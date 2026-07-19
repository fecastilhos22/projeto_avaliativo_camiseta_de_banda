import 'package:flutter/material.dart';
import '../viewModel/camiseta_viewmodel.dart';
import '../app/data/models/camiseta.dart';
import 'camiseta_card.dart';

class CatalogoView extends StatefulWidget {
  const CatalogoView({super.key});

  @override
  State<CatalogoView> createState() => _CatalogoViewState();
}

class _CatalogoViewState extends State<CatalogoView> {
  final CamisetaViewModel _viewModel = CamisetaViewModel();
  List<Camiseta> _camisetas = [];
  bool _exibirEmGrade = false;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() {
    setState(() {
      _camisetas = _viewModel.buscarCamisetas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo'),
        actions: [
          IconButton(
            tooltip: _exibirEmGrade ? 'Exibir como lista' : 'Exibir como grade',
            icon: Icon(_exibirEmGrade ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _exibirEmGrade = !_exibirEmGrade;
              });
            },
          ),
        ],
      ),
      body: _exibirEmGrade
          ? GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _camisetas.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return CamisetaCard(camiseta: _camisetas[index]);
              },
            )
          : ListView.builder(
              itemCount: _camisetas.length,
              itemBuilder: (context, index) {
                return CamisetaCard(camiseta: _camisetas[index]);
              },
            ),
    );
  }
}
