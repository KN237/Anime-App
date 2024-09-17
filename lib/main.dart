import 'package:anime_app/config/theme.dart';
import 'package:anime_app/providers/animes_provider.dart';
import 'package:anime_app/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
        create: (context) => AnimesProvider(),
        builder: (context, child) {
          return MaterialApp(
            title: 'Anime World',
            debugShowCheckedModeBanner: false,
            theme: darkTheme,
            themeMode: ThemeMode.dark,
            home: const Homepage(),
          );
        }),
  );
}
