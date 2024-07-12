import 'package:budget_app/utils/helper/db_helper.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxList<Map> readData = <Map>[].obs;
  List<Map> searchList = <Map>[];
  List<Map> copyList = <Map>[];
  RxnString imagePath = RxnString();



  Future<void> getReadData() async {
    DbHelper db = DbHelper();
    readData.value = await db.readCategory();
    copyList = List.from(readData);
  }

  Future<void> updateCategory(String name, int id) async {
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
    print("=======================${imagePath.value}");
    DbHelper db = DbHelper();
    await db.insertCategory(name,imagePath.value!);

    getReadData();
  }

  void filterBySearch(String search) {
    readData.value = copyList;
    searchList.clear();
    for (var x in readData) {
      if (x['name'].contains(search)) {
        searchList.add(x);
      }
    }
    readData.value = List.from(searchList);
  }
}
