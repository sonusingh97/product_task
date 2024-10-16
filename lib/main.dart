import 'package:flutter/material.dart';
import 'package:product_task/provider/productProvider.dart';
import 'package:product_task/view/home_screen.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProductProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(),
      home: const HomeScreen(),
    );
  }
}
