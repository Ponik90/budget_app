import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("budget "),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'addCate');
            },
            icon: const Icon(Icons.category_rounded),
          ),
        ],
      ),

    );
  }
}
