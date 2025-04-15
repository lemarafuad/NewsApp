import 'package:flutter/material.dart';
import 'package:news_app/colors.dart';
import 'package:news_app/screens/main_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.myseedsColor),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
