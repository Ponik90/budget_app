import 'package:budget_app/screen/entry/controller/entry_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EntryController controller = Get.put(EntryController());
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtAmount = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.categoryData();
    controller.transactionData();
  }

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
      body: Obx(
        () => ListView.builder(
          itemCount: controller.transactionList.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text("${controller.transactionList[index]['title']}"),
              subtitle:
                  Text("${controller.transactionList[index]['category']}"),
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
                        controller.deleteDetail(
                            controller.transactionList[index]['id']);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'cate');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void updateDialog(int index) {
    txtTitle.text = controller.transactionList[index]['title'];
    txtAmount.text = controller.transactionList[index]['amount'];
    showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKey,
          child: AlertDialog(
            title: const Text("Update detail"),
            actions: [
              TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: txtTitle.text,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter the title";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: txtAmount.text,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter the amount";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => DropdownButton(
                  isExpanded: true,
                  value: controller.select.value,
                  items: controller.categoryList
                      .map(
                        (element) => DropdownMenuItem(
                          value: element['name'],
                          child: Text("${element['name']}"),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    controller.select.value = value as String;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => Row(
                  children: [
                    TextButton(
                      onPressed: () async {
                        DateTime? d1 = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2300),
                        );
                        if (d1 != null) {
                          controller.changeDate(d1);
                        }
                      },
                      child: Text(
                          "${controller.date.value.day}/${controller.date.value.month}/${controller.date.value.year}"),
                    ),
                    TextButton(
                      onPressed: () async {
                        TimeOfDay? t1 = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (t1 != null) {
                          controller.changeTime(t1);
                        }
                      },
                      child: Text(
                          "${controller.time.value.hour} : ${controller.time.value.minute}"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Row(
              //   children: [
              //     ElevatedButton(
              //       onPressed: () {
              //         controller.transactionList[index]['status'];
              //       },

              //       child: const Text("Income"),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         controller.transactionList[index]['status'] ;
              //       },
              //       child: const Text("Expense"),
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("cansel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.updateDetail(
                        controller.transactionList[index]['id'],
                        txtTitle.text,
                        txtAmount.text,
                      );
                    },
                    child: const Text("update"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
