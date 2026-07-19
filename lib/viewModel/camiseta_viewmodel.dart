import '../app/data/repositories/camiseta_repository.dart';
import '../app/data/models/camiseta.dart';

class CamisetaViewModel {
  final CamisetaRepository _repository = CamisetaRepository();

  List<Camiseta> buscarCamisetas() {
    return _repository.buscarCamisetas();
  }
}