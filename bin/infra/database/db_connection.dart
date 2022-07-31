abstract class DBConnection<T> {
  Future<T> createConnection();

  Future<T> get connection;

  execQuery(String sql, [List? params]);
}
