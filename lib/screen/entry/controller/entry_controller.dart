import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

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
      time.toString(),
      date.toString(),
      amount,
      select.value!,
      status,
    );

    transactionData();
  }
}
