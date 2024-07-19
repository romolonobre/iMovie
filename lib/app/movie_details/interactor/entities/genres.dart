// ignore_for_file: public_member_api_docs, sort_constructors_first

class Genre {
  final String id;
  final String name;
  Genre({
    required this.id,
    required this.name,
  });

  @override
  String toString() => 'Genre(id: $id, name: $name)';
}
