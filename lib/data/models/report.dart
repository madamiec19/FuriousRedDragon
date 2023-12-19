class Report {
  int id;
  String createdAt;
  String room;
  String author;

  Report(
      {required this.id,
      required this.createdAt,
      required this.room,
      required this.author});

  @override
  String toString() {
    return '$room $author';
  }
}
