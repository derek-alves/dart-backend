import '../../models/models.dart';
import '../../repositories/publication_repository.dart';
import '../services.dart';

class PublicationService implements GenericService<Publication> {
  final PublicationRepository _publicationRepository;

  PublicationService(this._publicationRepository);
  @override
  Future<bool> delete(int id) {
    return _publicationRepository.delete(id);
  }

  @override
  Future<List<Publication>> findAll() {
    return _publicationRepository.findAll();
  }

  @override
  Future<Publication?> findOne(int id) {
    return _publicationRepository.findOne(id);
  }

  @override
  Future<bool> save(Publication value) async {
    if (value.id != null) {
      return await _publicationRepository.update(value);
    } else {
      return await _publicationRepository.create(value);
    }
  }
}
