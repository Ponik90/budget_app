import 'package:budget_app/utils/helper/db_helper.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxList<Map> readData = <Map>[].obs;

  Future<void> getReadData() async {
    DbHelper db = DbHelper();
    readData.value = await db.readCategory();
  }
}
