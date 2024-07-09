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

  @override
  void initState() {
    super.initState();
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
              subtitle: Text("${controller.transactionList[index]['amount']}"),
              trailing: Column(
                children: [],
              ),
              children: [
                IconButton(
                  onPressed: () {
                    controller
                        .deleteDetail(controller.transactionList[index]['id']);
                  },
                  icon: const Icon(Icons.delete),
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
}
