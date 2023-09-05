import 'package:kukerja_web/core/data/models/responses/bank_response.dart';

abstract class BankRepository {
  Future<BankResponse> fetchBanks();
}