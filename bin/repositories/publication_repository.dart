import '../infra/infra.dart';
import '../models/models.dart';
import 'repository.dart';

class PublicationRepository implements Repository<Publication> {
  final DBConnection _dbConnection;

  PublicationRepository(this._dbConnection);
  @override
  Future<bool> create(Publication value) async {
    var result = await _dbConnection.execQuery(
        "insert into noticias (titulo, descricao, id_usuario) values (?, ?, ?)",
        [
          value.title,
          value.description,
          value.userID,
        ]);

    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConnection.execQuery(
      "DELETE from noticias where id = ?",
      [id],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<List<Publication>> findAll() async {
    var result = await _dbConnection.execQuery("SELECT * FROM noticias");
    return result
        .map(
          (r) => Publication.fromMap(r.fields),
        )
        .toList()
        .cast<Publication>();
  }

  @override
  Future<Publication?> findOne(int id) async {
    var result = await _dbConnection.execQuery(
      "SELECT * FROM noticias WHERE id = ?",
      [id],
    );

    return result.affectedRows == 0
        ? null
        : Publication.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(Publication value) async {
    var result = await _dbConnection.execQuery(
      "UPDATE usuarios set titulo = ?, descricao = ? where id = ?",
      [value.title, value.description, value.id],
    );
    return result.affectedRows > 0;
  }
}
