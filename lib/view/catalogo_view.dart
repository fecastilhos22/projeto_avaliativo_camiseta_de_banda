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

  final TextEditingController _pesquisaController =
      TextEditingController();

  final TextEditingController _precoMinimoController =
      TextEditingController();

  final TextEditingController _precoMaximoController =
      TextEditingController();

  List<Camiseta> _camisetas = [];
  List<Camiseta> _camisetasFiltradas = [];

  bool _exibirEmGrade = false;

  String _textoPesquisa = '';
  double? _precoMinimo;
  double? _precoMaximo;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  @override
  void dispose() {
    _pesquisaController.dispose();
    _precoMinimoController.dispose();
    _precoMaximoController.dispose();
    super.dispose();
  }

  void _carregarDados() {
    final camisetasCarregadas = _viewModel.buscarCamisetas();

    setState(() {
      _camisetas = camisetasCarregadas;
      _camisetasFiltradas = camisetasCarregadas;
    });
  }

  void _aplicarFiltros() {
    final resultado = _camisetas.where((camiseta) {
      final correspondeAoTitulo = camiseta.titulo
          .toLowerCase()
          .contains(_textoPesquisa.toLowerCase());

      final correspondeAoPrecoMinimo =
          _precoMinimo == null ||
          camiseta.preco >= _precoMinimo!;

      final correspondeAoPrecoMaximo =
          _precoMaximo == null ||
          camiseta.preco <= _precoMaximo!;

      return correspondeAoTitulo &&
          correspondeAoPrecoMinimo &&
          correspondeAoPrecoMaximo;
    }).toList();

    setState(() {
      _camisetasFiltradas = resultado;
    });
  }

  double? _converterPreco(String valor) {
    final textoFormatado = valor.trim().replaceAll(',', '.');

    if (textoFormatado.isEmpty) {
      return null;
    }

    return double.tryParse(textoFormatado);
  }

  void _limparFiltros() {
    _pesquisaController.clear();
    _precoMinimoController.clear();
    _precoMaximoController.clear();

    setState(() {
      _textoPesquisa = '';
      _precoMinimo = null;
      _precoMaximo = null;
      _camisetasFiltradas = List<Camiseta>.from(_camisetas);
    });
  }

  Widget _construirFiltros() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _pesquisaController,
            decoration: const InputDecoration(
              labelText: 'Pesquisar por título',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (valor) {
              _textoPesquisa = valor;
              _aplicarFiltros();
            },
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _precoMinimoController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Preço mínimo',
                    prefixText: 'R\$ ',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (valor) {
                    _precoMinimo = _converterPreco(valor);
                    _aplicarFiltros();
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _precoMaximoController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Preço máximo',
                    prefixText: 'R\$ ',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (valor) {
                    _precoMaximo = _converterPreco(valor);
                    _aplicarFiltros();
                  },
                ),
              ),
              IconButton(
                tooltip: 'Limpar filtros',
                onPressed: _limparFiltros,
                icon: const Icon(Icons.clear),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _construirCatalogo() {
    if (_camisetasFiltradas.isEmpty) {
      return const Center(
        child: Text('Nenhuma camiseta encontrada'),
      );
    }

    if (_exibirEmGrade) {
      return GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _camisetasFiltradas.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          return CamisetaCard(
            camiseta: _camisetasFiltradas[index],
          );
        },
      );
    }

    return ListView.builder(
      itemCount: _camisetasFiltradas.length,
      itemBuilder: (context, index) {
        return CamisetaCard(
          camiseta: _camisetasFiltradas[index],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo'),
        actions: [
          IconButton(
            tooltip: _exibirEmGrade
                ? 'Exibir como lista'
                : 'Exibir como grade',
            icon: Icon(
              _exibirEmGrade
                  ? Icons.view_list
                  : Icons.grid_view,
            ),
            onPressed: () {
              setState(() {
                _exibirEmGrade = !_exibirEmGrade;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _construirFiltros(),
          Expanded(
            child: _construirCatalogo(),
          ),
        ],
      ),
    );
  }
}