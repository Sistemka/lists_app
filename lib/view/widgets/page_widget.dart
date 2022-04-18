import 'package:flutter/widgets.dart';

class PageWidget extends StatelessWidget {
  const PageWidget(
      {Key? key, required this.body, required this.label, required this.icon})
      : super(key: key);

  final Widget body;
  final String label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return body;
  }
}
