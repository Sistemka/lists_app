import 'package:flutter/material.dart';
import "package:flutter/services.dart";
import 'package:provider/provider.dart';
import 'app.dart';
import 'managers/theme_manager.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: Color.fromARGB(0, 161, 158, 158),
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
      ],
      child: const App(),
    ),
  );
}
