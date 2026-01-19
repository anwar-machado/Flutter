import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int count = 0;

  void increment () {
    setState(() {
        count++;
    });
  }

  void decrement() {
    setState(() {
        count--;
    });
  }

  bool get isEmpty => count == 0;
  bool get isFull => count == 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contador de Pessoas')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(isFull ? 'Lotado!' : 'Pode entrar : ) ', style: TextStyle(fontSize: 30)),
          Text('$count', style: TextStyle(fontSize: 100)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 30,
            children: [
              TextButton(
                onPressed: isFull ? null : increment,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey,
                  fixedSize: Size(100, 100),
                ),
                child: Text('Entrar', style: TextStyle(fontSize: 30)),
              ),
              TextButton(
                onPressed: isEmpty ? null : decrement,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey,
                  fixedSize: Size(100, 100),
                ),
                child: Text('Sair', style: TextStyle(fontSize: 30)),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white70,
      // bottomNavigationBar:,
    );
  }
}
