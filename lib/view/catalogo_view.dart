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
      appBar: AppBar(title: const Text('Catálogo')),
      body: ListView.builder(
        itemCount: _camisetas.length,
        itemBuilder: (context, index) {
          return CamisetaCard(camiseta: _camisetas[index]);
        },
      ),
    );
  }
}
