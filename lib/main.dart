import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Static Resources App',
      theme: ThemeData(
        fontFamily: 'CustomFont', // глобальный шрифт
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Заголовок',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            const Text(
              'Текст с кастомным шрифтом',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // изображения
            Expanded(
              child: ListView(
                children: const [
                  Image(
                    image: AssetImage('assets/images/v1.jpg'),
                  ),
                  SizedBox(height: 10),
                  Image(
                    image: AssetImage('assets/images/v2.jpg'),
                  ),
                  SizedBox(height: 10),
                  Image(
                    image: AssetImage('assets/images/v3.jpg'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}