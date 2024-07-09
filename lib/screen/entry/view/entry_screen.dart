import 'package:budget_app/screen/entry/controller/entry_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtAmount = TextEditingController();
  EntryController controller = Get.put(EntryController());

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
        title: const Text("Income / Expanse"),
      ),
      body: Column(
        children: [
          TextField(
            controller: txtTitle,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "title",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: txtAmount,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "amount",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => DropdownButton(
              hint: const Text("select category"),
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
          Obx(
            () => Row(
              children: [
                TextButton(
                  onPressed: () async {
                    DateTime? d1 = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2300),);
                    if(d1 != null)
                    {
                          controller.changeDate(d1);
                    }
                  },

                  child: Text("${controller.date.value.hour}/${controller.date.value.minute}/${controller.date.value.second}"),
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
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.insertDetail(txtTitle.text, txtAmount.text, 0);
                },
                child: const Text("Income"),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.insertDetail(txtTitle.text, txtAmount.text, 1);
                },
                child: const Text("Expense"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
