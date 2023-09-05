import 'package:kukerja_web/core/data/models/responses/bank_response.dart';
import 'package:kukerja_web/core/domain/repositories/bank_repository.dart';

class BankUseCase {
  final BankRepository _bankRepository;

  BankUseCase(this._bankRepository);

  Future<BankResponse> fetchBanks() {
    return _bankRepository.fetchBanks();
  }

}