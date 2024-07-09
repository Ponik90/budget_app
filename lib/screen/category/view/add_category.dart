  import 'package:budget_app/screen/category/controller/category_controller.dart';
import 'package:budget_app/utils/helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController txtCategory = TextEditingController();
  TextEditingController txtUpdate = TextEditingController();
  CategoryController controller = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();

    controller.getReadData();
  }

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
              if (txtCategory.text.isNotEmpty) {
                controller.insertCategory(txtCategory.text);
              }
            },
            child: const Text("Add"),
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: controller.readData.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text("${controller.readData[index]['name']}"),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              updateDialog(index);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.deleteCategory(
                                controller.readData[index]['id'],
                              );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateDialog(int index) {
    txtUpdate.text = controller.readData[index]['name'];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update"),
          actions: [
            TextField(
              controller: txtUpdate,
            ),
            TextButton(
              onPressed: () {
                controller.updateCategory(
                  txtUpdate.text,
                  controller.readData[index]['id'],
                );
                Navigator.pop(context);
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}
