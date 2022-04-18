import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SerachBarState createState() => _SerachBarState();
}

class _SerachBarState extends State<SearchBar> {
  late FocusNode searchFocus;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    searchFocus = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    searchFocus.dispose();
    super.dispose();
  }

  void clear() {
    _controller.clear();
    searchFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: TextField(
          focusNode: searchFocus,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: clear,
            ),
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          controller: _controller,
        ),
      ),
    );
  }
}
