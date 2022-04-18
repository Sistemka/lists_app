import 'package:lists_app/api/models/response/tags.dart';

import 'users.dart';

enum ListType { simple_list, numeric_list, wish_list, todo_list }

class ListPreview {
  final String id;
  final ListType type;
  final String header;
  final int views;
  final int rating;
  final DateTime publishedAt;

  ListPreview({
    required this.id,
    required this.type,
    required this.header,
    required this.views,
    required this.publishedAt,
    required this.rating,
  });

  factory ListPreview.fromJson(Map<String, dynamic> json) {
    return ListPreview(
      id: json['id'],
      type: ListType.values.firstWhere((e) => e.name == json['type']),
      header: json['header'],
      views: json['views'] ?? 0,
      publishedAt: DateTime.parse(json['published_at']),
      rating: json['rating'] ?? 0,
    );
  }
}

class Preview {
  final UserPreview user;
  final ListPreview list;
  final List<TagPreview> tags;
  Preview({
    required this.user,
    required this.list,
    required this.tags,
  });

  factory Preview.fromJson(Map<String, dynamic> json) {
    return Preview(
      user: UserPreview.fromJson(json['user']),
      list: ListPreview.fromJson(json['list']),
      tags: json['tags']
          .map<TagPreview>((tag) => TagPreview.fromJson(tag))
          .toList(),
    );
  }
}
