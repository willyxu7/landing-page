import '../repositories/religion_repository.dart';

class ReligionUseCase {

  late ReligionRepository _religionRepository;

  ReligionUseCase(ReligionRepository religionRepository) {
    _religionRepository = religionRepository;
  }

  List<String> getReligions() {
    return _religionRepository.getReligions();
  }
}