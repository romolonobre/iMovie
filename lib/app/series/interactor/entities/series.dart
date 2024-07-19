// ignore_for_file: public_member_api_docs, sort_constructors_first
class Serie {
  final String id;
  final String name;
  final String description;
  final String releaseDate;
  final String backgroundImage;
  final String postImage;

  Serie({
    required this.name,
    required this.description,
    required this.releaseDate,
    required this.backgroundImage,
    required this.postImage,
    required this.id,
  });

  @override
  String toString() {
    return 'Series(name: $name, description: $description, releaseDate: $releaseDate, backgroundImage: $backgroundImage, postImage: $postImage)';
  }
}
