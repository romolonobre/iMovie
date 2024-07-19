// ignore_for_file: public_member_api_docs, sort_constructors_first
class Cast {
  final String name;
  final String character;
  final String image;

  Cast({
    required this.name,
    required this.character,
    required this.image,
  });

  @override
  String toString() => 'Cast(name: $name, character: $character, image: $image)';
}
