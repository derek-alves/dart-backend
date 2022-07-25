abstract class DBConnection<T> {
  Future<T> createConnection();

  Future<T> get connection;
}
