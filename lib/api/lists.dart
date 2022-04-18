import 'package:http/http.dart' as http;
import 'constants/urls.dart';
import 'models/response/lists.dart';
import 'dart:convert';

Future<List<Preview>> getListsHandler(
    int offset, int size, DateTime timestamp) async {
  final response = await http.get(Uri(
      scheme: 'http',
      host: host,
      port: port,
      path: api + listsUrl,
      queryParameters: {
        'offset': offset.toString(),
        'size': size.toString(),
        'timestamp': timestamp.toString()
      }));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body)
        .map<Preview>((listItem) => Preview.fromJson(listItem))
        .toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
