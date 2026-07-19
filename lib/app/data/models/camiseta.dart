class Camiseta {
  final String _titulo;
  final double _preco;
  final List<String> _tamanhosDisponiveis;
  final String _imagem;
  final bool _disponivel;

  Camiseta({
    required String titulo,
    required double preco,
    required List<String> tamanhosDisponiveis,
    required String imagem,
    required bool disponivel,
  })  : _titulo = titulo,
        _preco = preco,
        _tamanhosDisponiveis = tamanhosDisponiveis,
        _imagem = imagem,
        _disponivel = disponivel;

  // Getters (encapsulamento: atributos privados, acesso controlado)
  String get titulo => _titulo;
  double get preco => _preco;
  List<String> get tamanhosDisponiveis => _tamanhosDisponiveis;
  String get imagem => _imagem;
  bool get disponivel => _disponivel;

  // Transforma um Map (vindo do JSON) em um objeto Camiseta
  factory Camiseta.fromJson(Map<String, dynamic> json) {
    return Camiseta(
      titulo: json['titulo'],
      preco: (json['preco'] as num).toDouble(),
      tamanhosDisponiveis: List<String>.from(json['tamanhosDisponiveis']),
      imagem: json['imagem'],
      disponivel: json['disponivel'],
    );
  }
}