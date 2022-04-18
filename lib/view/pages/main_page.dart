import 'package:flutter/material.dart';
import 'package:lists_app/view/widgets/lists.dart';
import '../widgets/search_bar.dart';
import '../constants/vocab.dart';

class MainPage extends StatelessWidget {
  MainPage({
    Key? key,
  }) : super(key: key);
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // The search area here
          title: const SearchBar(),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: EN.subs,
              ),
              Tab(text: EN.hot),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[ListsPreview(), ListOfLists()],
        ),
      ),
    );
  }
}
