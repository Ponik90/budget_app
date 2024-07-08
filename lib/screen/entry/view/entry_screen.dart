import 'package:flutter/material.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Income / Expanse"),
      ),
      body: Column(
        children: [
          TextField(
            controller: txtTitle,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "title"),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: txtTitle,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "title"),
          ),
          const SizedBox(
            height: 10,
          ),

        ],
      ),
    );
  }
}
