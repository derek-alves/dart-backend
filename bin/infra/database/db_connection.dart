abstract class DBConnection {
  Future<dynamic> createConnection();

  Future<dynamic> get connection;
}
