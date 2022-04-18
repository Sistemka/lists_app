import 'package:flutter/material.dart';
import 'page_widget.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({
    Key? key,
    required this.pages,
    final this.showLabels = false,
  }) : super(key: key);

  final String topBarImage = '';
  final List<PageWidget> pages;
  final bool showLabels;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.pages[_selectedIndex].body,
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: widget.showLabels,
        showUnselectedLabels: widget.showLabels,
        items: <BottomNavigationBarItem>[
          for (PageWidget page in widget.pages)
            BottomNavigationBarItem(
              icon: page.icon,
              label: page.label,
            )
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        // elevation: 0,
      ),
    );
  }
}
