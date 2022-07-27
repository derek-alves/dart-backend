class User {
  int? id;
  String? name;
  String? email;
  String? password;
  bool? isActived;
  DateTime? createdAt;
  DateTime? updatedAt;

  User();

  User.create(
    this.id,
    this.name,
    this.email,
    this.isActived,
    this.createdAt,
    this.updatedAt,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'isActived': isActived,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User.create(
      map['id'] ?? 0,
      map['nome'] ?? "",
      map['email'] ?? "",
      map['is_ativo'] == 1,
      map['dt_criacao'],
      map['dt_autalizacao'],
    );
  }

  factory User.fromRequest(Map<String, dynamic> map) {
    return User()
      ..name = map['nome']
      ..email = map['email']
      ..password = map['password'];
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email isActived: $isActived, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
