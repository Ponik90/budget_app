import 'package:budget_app/utils/helper/db_helper.dart';
import 'package:flutter/material.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController txtCategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("category"),
            ),
            controller: txtCategory,
          ),
          ElevatedButton(
            onPressed: () {
              DbHelper db = DbHelper();
              db.insertCategory(txtCategory.text);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
