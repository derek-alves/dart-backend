import '../../models/models.dart';
import '../../utils/utils.dart';
import '../services.dart';

class PublicationService implements GenericService<Publication> {
  final List<Publication> _fakeDB = [];
  @override
  bool delete(int id) {
    _fakeDB.removeWhere((publication) => publication.id == id);
    return true;
  }

  @override
  List<Publication> findAll() {
    return _fakeDB;
  }

  @override
  Publication findOne(int id) {
    return _fakeDB.firstWhere((publication) => publication.id == id);
  }

  @override
  bool save(Publication value) {
    Publication? model =
        _fakeDB.firstWhereOrNull((publication) => publication.id == value.id);
    if (model == null) {
      _fakeDB.add(value);
    } else {
      var index = _fakeDB.indexOf(model);
      _fakeDB[index] = value;
    }
    return true;
  }
}
