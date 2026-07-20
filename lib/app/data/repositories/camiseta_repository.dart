import 'dart:convert';
import '../datasources/product_remote_datasource.dart';
import '../models/camiseta.dart';
import '../models/compra.dart';

class CamisetaRepository {
  final ProductRemoteDatasource _datasource = ProductRemoteDatasource();

  List<Camiseta> buscarCamisetas() {
    
    final String jsonString = _datasource.getProducts();

    
    final List<dynamic> listaDecodificada = jsonDecode(jsonString);

   
    final List<Camiseta> camisetas = listaDecodificada
        .map((item) => Camiseta.fromJson(item as Map<String, dynamic>))
        .toList();

    return camisetas;
  }

  void finalizarCompra(Compra compra) {
    print(jsonEncode(compra.toJson()));
  }
}
