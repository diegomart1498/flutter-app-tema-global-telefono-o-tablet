import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:my_app/models/layout_model.dart';
import 'package:my_app/pages/pages.dart';
import 'package:my_app/theme/theme_changer.dart';

void main() => runApp(
      MultiProvider(
        // create: (BuildContext context) => ThemeChanger(2),
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeChanger(2),
          ),
          ChangeNotifierProvider(
            create: (context) => LayoutModel(),
          ),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky); //? Hide Status Bar
    final appTheme = Provider.of<ThemeChanger>(context);
    final layout = Provider.of<LayoutModel>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Designs App',
      theme: appTheme.currentTheme,
      home: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          // print('Orientación: $orientation');
          // final screenSize = MediaQuery.of(context).size;
          if (orientation == Orientation.landscape) {
            layout.landscape = true;
            return const LauncherTabletPage();
          } else {
            layout.landscape = false;
            return const LauncherPage();
          }
        },
      ),
    );
  }
}
