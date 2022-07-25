import '../infra/database/database.dart';
import '../models/user.dart';
import 'repository.dart';

class UserRepository implements Repository<User> {
  final DBConnection _dbConnection;
  UserRepository(this._dbConnection);

  @override
  Future create(User value) async {
    var connection = await _dbConnection.connection;

    final queryDb = "INSERT INTO usuarios (nome,email,password) VALUES (?,?,?)";
    var result = await connection.query(
      "SELECT * FROM usuarios WHERE email = ?",
      [value.email],
    );

    if (result.isNotEmpty) {
      throw Exception(
          "[ERROR/UserRepository] -> Email alreay exists: ${value.email}");
    }

    await connection.query(queryDb, [
      value.name,
      value.email,
      value.password,
    ]);

    print(value.toString());
  }

  @override
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<User>> findAll() async {
    var connection = await _dbConnection.connection;
    final List<User> userList = [];
    final String querySql = "SELECT * FROM usuarios";
    var result = await connection.query(querySql);
    for (var userMap in result) {
      userList.add(User.fromMap(userMap.fields));
    }
    return userList;
  }

  @override
  Future<User> findOne(int id) async {
    var connection = await _dbConnection.connection;
    var result = await connection.query(
      "SELECT * FROM usuarios WHERE id = ?",
      [id],
    );
    if (result.isEmpty) {
      throw Exception(
          "[ERROR/UserRepository] -> findOne for id: $id, Not Found.");
    }
    return User.fromMap(result.first.fields);
  }

  @override
  Future update(User value) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
