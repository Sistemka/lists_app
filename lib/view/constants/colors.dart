import 'package:flutter/material.dart';

const List<Color> color = [
  Colors.red,
  Colors.orange,
  Colors.green,
  Colors.blue,
  Colors.deepOrange,
  Colors.blueGrey,
  Colors.deepPurple,
  Colors.indigo,
  Colors.teal,
];

Color getAvatarColor(int hashCode) {
  return color[hashCode % color.length];
}

const Map<String, Color> tagColor = {
  'geo_tag': Colors.green,
};

Color getTagColor(String tagType, String tagName) {
  if (tagColor.containsKey(tagType)) {
    return tagColor[tagType]!;
  }
  return getAvatarColor(tagName.hashCode);
}
