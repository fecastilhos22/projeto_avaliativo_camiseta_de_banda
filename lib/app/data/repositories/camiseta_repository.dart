import 'dart:convert';
import '../datasources/product_remote_datasource.dart';
import '../models/camiseta.dart';

class CamisetaRepository {
  final ProductRemoteDatasource _datasource = ProductRemoteDatasource();

  List<Camiseta> buscarCamisetas() {
    // 1. Pega a String JSON da datasource
    final String jsonString = _datasource.getProducts();

    // 2. Transforma a String em uma List<dynamic> (lista de Maps)
    final List<dynamic> listaDecodificada = jsonDecode(jsonString);

    // 3. Transforma cada Map em um objeto Camiseta usando .map()
    final List<Camiseta> camisetas = listaDecodificada
        .map((item) => Camiseta.fromJson(item as Map<String, dynamic>))
        .toList();

    return camisetas;
  }
}