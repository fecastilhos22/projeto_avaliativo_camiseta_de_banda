class Compra {
  final String produtoTitulo;
  final String tamanho;
  final int quantidade;
  final double valorTotal;
  final int parcelas;
  final String responsavel;
  final String endereco;

  Compra({
    required this.produtoTitulo,
    required this.tamanho,
    required this.quantidade,
    required this.valorTotal,
    required this.parcelas,
    required this.responsavel,
    required this.endereco,
  });

  Map<String, dynamic> toJson() {
    return {
      'produtoTitulo': produtoTitulo,
      'tamanho': tamanho,
      'quantidade': quantidade,
      'valorTotal': valorTotal,
      'parcelas': parcelas,
      'responsavel': responsavel,
      'endereco': endereco,
    };
  }
}