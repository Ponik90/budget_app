import 'dart:convert';
import 'package:budget_app/screen/category/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController txtCategory = TextEditingController();
  TextEditingController txtUpdate = TextEditingController();
  TextEditingController txtSearch = TextEditingController();
  CategoryController controller = Get.put(CategoryController());
  String path = "";

  @override
  void initState() {
    super.initState();

    controller.getReadData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Category"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SearchBar(
                hintText: "Search category",
                controller: txtSearch,
                elevation: const MaterialStatePropertyAll(
                  3,
                ),
                backgroundColor: const MaterialStatePropertyAll(Colors.white60),
                trailing: const [
                  Icon(Icons.search),
                  SizedBox(
                    width: 10,
                  ),
                ],
                onChanged: (value) {
                  controller.filterBySearch(value);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => controller.imagePath.value != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: MemoryImage(
                          base64Decode(controller.imagePath.value!),
                        ),
                      )
                    : const CircleAvatar(
                        radius: 50,
                        child: Icon(
                          Icons.person_2_outlined,
                          size: 50,
                        ),
                      ),
              ),
              ElevatedButton(
                onPressed: () async {
                  ImagePicker picker = ImagePicker();
                  XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  controller.imagePath.value = image!.path;
                },
                child: const Text('Add'),
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "category",
                ),
                controller: txtCategory,
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  if (txtCategory.text.isNotEmpty) {
                    controller.insertCategory(txtCategory.text);
                    FocusManager.instance.primaryFocus!.unfocus();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter the category"),
                      ),
                    );
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
        ),
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
