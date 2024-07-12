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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.categoryData();
    controller.transactionData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Funds"),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xffFFF6E9),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Title",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: txtTitle,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(left: 16),
                      hintText: "title",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the title";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Amount",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: txtAmount,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          style: BorderStyle.solid,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(left: 16),
                      hintText: "amount",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the amount";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Category",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Obx(
                    () => DropdownButton(
                      hint: const Text(
                        "select category",
                      ),
                      isExpanded: true,
                      underline: const Divider(),
                      value: controller.select.value,
                      items: controller.categoryList
                          .map(
                            (element) => DropdownMenuItem(
                              value: element['name'],
                              child: Text(
                                "${element['name']}",
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        controller.select.value = value as String;
                      },
                    ),
                  ),
                  const Text(
                    "Date/Time",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
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
                          icon: const Icon(
                            Icons.calendar_month,
                            color: Colors.black54,
                          ),
                          label: Text(
                            "${controller.date.value.day}/${controller.date.value.month}/${controller.date.value.year}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            TimeOfDay? t1 = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            if (t1 != null) {
                              controller.changeTime(t1);
                            }
                          },
                          icon: const Icon(
                            Icons.watch_later,
                            color: Colors.black54,
                          ),
                          label: Text(
                            "${controller.time.value.hour} : ${controller.time.value.minute}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (controller.select.value != null) {
                              controller.insertDetail(
                                txtTitle.text,
                                txtAmount.text,
                                0,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Successfully add"),
                                ),
                              );
                              FocusManager.instance.primaryFocus!.unfocus();
                              formKey.currentState!.reset();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Select the category"),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: const Text(
                          "Income",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (controller.select.value != null) {
                              controller.insertDetail(
                                txtTitle.text,
                                txtAmount.text,
                                1,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Data add"),
                                ),
                              );
                              FocusManager.instance.primaryFocus!.unfocus();
                              formKey.currentState!.reset();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Enter the category"),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text(
                          "Expense",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
