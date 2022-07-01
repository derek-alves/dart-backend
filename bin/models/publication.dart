class Publication {
  final int? id;
  final String title;
  final String body;
  final String image;
  final DateTime publicationDate;
  final DateTime? updateDate;

  Publication({
    required this.id,
    required this.title,
    required this.body,
    required this.image,
    required this.publicationDate,
    this.updateDate,
  });

  factory Publication.fromJson(Map map) {
    return Publication(
      id: map['id'] ?? '',
      title: map['title'],
      body: map['body'],
      image: map['image'],
      publicationDate: DateTime.fromMillisecondsSinceEpoch(
        map['publicationDate'],
      ),
      updateDate: map['updateDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['updateDate'],
            )
          : null,
    );
  }
  Map toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "image": image,
        "publicationDate": publicationDate.toString()
      };
}
