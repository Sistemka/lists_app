enum TagType { tag, geo_tag }

class TagPreview {
  final String id;
  final TagType type;
  final String name;

  TagPreview({
    required this.id,
    required this.type,
    required this.name,
  });

  factory TagPreview.fromJson(Map<String, dynamic> json) {
    return TagPreview(
      id: json['id'],
      type: TagType.values.firstWhere((e) => e.name == json['tag_type']),
      name: json['name'],
    );
  }
}
