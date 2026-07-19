import '../app/data/repositories/camiseta_repository.dart';
import '../app/data/models/camiseta.dart';
import '../app/data/models/compra.dart';

class CamisetaViewModel {
  final CamisetaRepository _repository = CamisetaRepository();

  List<Camiseta> buscarCamisetas() {
    return _repository.buscarCamisetas();
  }

  void finalizarCompra(Compra compra) {
    _repository.finalizarCompra(compra);
  }
}
