import '../infra/database/database.dart';
import '../models/user.dart';
import 'repository.dart';

class UserRepository implements Repository<User> {
  final DBConnection _dbConnection;
  UserRepository(this._dbConnection);

  @override
  Future<bool> create(User value) async {
    var findeUser = await _dbConnection.execQuery(
      "SELECT * FROM usuarios WHERE email = ?",
      [value.email],
    );

    if (findeUser.isNotEmpty) {
      throw Exception(
          "[ERROR/UserRepository] -> Email alreay exists: ${value.email}");
    }

    var result = await _dbConnection.execQuery(
        "INSERT INTO usuarios (nome,email,password) VALUES (?,?,?)", [
      value.name,
      value.email,
      value.password,
    ]);

    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConnection.execQuery(
      "DELETE from usuarios where id = ?",
      [id],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<List<User>> findAll() async {
    var result = await _dbConnection.execQuery("SELECT * FROM usuarios");
    return result
        .map(
          (r) => User.fromMap(r.fields),
        )
        .toList()
        .cast<User>();
  }

  @override
  Future<User?> findOne(int id) async {
    var result = await _dbConnection.execQuery(
      "SELECT * FROM usuarios WHERE id = ?",
      [id],
    );

    return result.affectedRows == 0 ? null : User.fromMap(result.first.fields);
  }

  Future<User?> findByEmail(String email) async {
    var result = await _dbConnection.execQuery(
      "SELECT * FROM usuarios WHERE email = ?",
      [email],
    );

    return result.affectedRows == 0
        ? null
        : User.fromEmail(result.first.fields);
  }

  @override
  Future<bool> update(User value) async {
    var result = await _dbConnection.execQuery(
      "UPDATE usuarios set nome = ?, password = ? where id = ?",
      [value.name, value.password, value.id],
    );
    return result.affectedRows > 0;
  }
}
