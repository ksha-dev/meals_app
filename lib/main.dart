import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/screens/tabs_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.red,
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.notoSansAdlamTextTheme(),
);

void main(List<String> args) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: const TabsScreen());
  }
}
