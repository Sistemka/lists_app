import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/widgets/bottom_bar.dart';
import 'view/widgets/page_widget.dart';
import 'view/pages/main_page.dart';
import 'view/constants/theme.dart';
import "managers/theme_manager.dart";
import 'view/constants/vocab.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, themeMode, _) => MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode.getMode(),
              home: MainWrapper(
                showLabels: true,
                pages: [
                  PageWidget(
                    body: MainPage(),
                    label: EN.home,
                    icon: const Icon(Icons.home_filled),
                  ),
                  PageWidget(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Choose your theme:',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /// //////////////////////////////////////////////////////
                              /// Change theme & rebuild to show it using these buttons
                              ElevatedButton(
                                  onPressed: () => themeMode.setLightMode(),
                                  child: const Text('Light')),
                              ElevatedButton(
                                  onPressed: () => themeMode.setDarkMode(),
                                  child: const Text('Dark')),
                              ElevatedButton(
                                  onPressed: () => themeMode.setSystemMode(),
                                  child: const Text('System')),

                              /// //////////////////////////////////////////////////////
                            ],
                          ),
                        ],
                      ),
                    ),
                    label: EN.public,
                    icon: Icon(Icons.public),
                  ),
                  PageWidget(
                    body: Center(),
                    label: "",
                    icon: RawMaterialButton(
                      onPressed: () {},
                      elevation: 2.0,
                      fillColor: Colors.blue,
                      child: Icon(
                        Icons.add,
                      ),
                      padding: EdgeInsets.all(10.0),
                      shape: CircleBorder(),
                    ),
                  ),
                  PageWidget(
                    body: Center(),
                    label: EN.saved,
                    icon: const Icon(Icons.save),
                  ),
                  PageWidget(
                    body: Center(),
                    label: EN.account,
                    icon: Icon(Icons.account_circle_outlined),
                  ),
                ],
              ),
            ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
