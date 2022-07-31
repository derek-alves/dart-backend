class Publication {
  int? id;
  String? title;
  String? description;
  DateTime? createdDate;
  DateTime? updateDate;
  int? userID;

  Publication();

  factory Publication.fromMap(Map<String, dynamic> map) {
    return Publication()
      ..id = map['id']?.toInt()
      ..title = map['titulo']
      ..description = map['descricao']?.toString()
      ..createdDate = map['dt_criacao']
      ..updateDate = map['dt_autalizacao']
      ..userID = map['id_usuario']?.toInt();
  }

  factory Publication.fromRequest(Map<String, dynamic> map) {
    return Publication()
      ..title = map['title']
      ..description = map['description']
      ..userID = map['userID']?.toInt();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };
}
