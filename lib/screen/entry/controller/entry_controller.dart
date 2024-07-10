import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/helper/db_helper.dart';

class EntryController extends GetxController {
  RxList<Map> transactionList = <Map>[].obs;

  RxList<Map> categoryList = <Map>[].obs;
  RxnString select = RxnString();
  DbHelper db = DbHelper();

  Rx<DateTime> date = DateTime.now().obs;
  Rx<TimeOfDay> time = TimeOfDay.now().obs;

  Future<void> categoryData() async {
    categoryList.value = await db.readCategory();
  }

  void changeDate(DateTime value) {
    date.value = value;
  }

  void changeTime(TimeOfDay value) {
    time.value = value;
  }

  Future<void> transactionData() async {
    transactionList.value = await db.readTransaction();
  }

  void insertDetail(String title, String amount, int status) {
    db.insertTransaction(
      title,
      "${time.value.hour}:${time.value.minute}",
      "${date.value.day}/${date.value.month}/${date.value.year}",
      amount,
      select.value!,
      status,
    );

    transactionData();
  }

  void updateDetail(
    int id,
    String title,
    String amount,
  ) {
    db.updateTransaction(
      id,
      title,
      amount,
      "${time.value.hour.toString()}:${time.value.minute.toString()}",
      "${date.value.day.toString()}/${date.value.month.toString()}/${date.value.year.toString()}",
      select.value!,
    );
    transactionData();
  }

  void deleteDetail(int id) {
    db.deleteTransaction(id);
    transactionData();
  }
}
