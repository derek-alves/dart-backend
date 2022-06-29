class New {
  final int id;
  final String title;
  final String body;
  final String image;
  final DateTime publicationDate;
  final DateTime? updateDate;

  New({
    required this.id,
    required this.title,
    required this.body,
    required this.image,
    required this.publicationDate,
    this.updateDate,
  });
}
