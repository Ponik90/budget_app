import 'package:budget_app/utils/helper/db_helper.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxList<Map> readData = <Map>[].obs;

  Future<void> getReadData() async {
    DbHelper db = DbHelper();
    readData.value = await db.readCategory();

  }

  Future<void> updateCategory(String name,int id) async {
    DbHelper db = DbHelper();
    await db.updateCategory(name, id);
    getReadData();
  }

  Future<void> deleteCategory(int id) async {
    DbHelper db = DbHelper();
    await db.deleteCategory(id);
    getReadData();
  }

  Future<void> insertCategory(String name) async {
    DbHelper db = DbHelper();
    await db.insertCategory(name);
    getReadData();
  }
}
