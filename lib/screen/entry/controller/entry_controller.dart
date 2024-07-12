import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/helper/db_helper.dart';

class EntryController extends GetxController {
  RxList<Map> transactionList = <Map>[].obs;
  List<Map> filterTransactionList = <Map>[];

  RxList<Map> categoryList = <Map>[].obs;
  RxnString select = RxnString();
  DbHelper db = DbHelper();

  Rx<DateTime> date = DateTime.now().obs;
  Rx<TimeOfDay> time = TimeOfDay.now().obs;
  RxString shortBy = "all".obs;
  List amount = [];

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

  Future<void> filterData(String value) async {
    shortBy.value = value;
    if (shortBy.value == "all") {
      transactionData();
    } else if (shortBy.value == "income") {
      filterTransactionList = await db.filterTransaction(0);
      transactionList.value = filterTransactionList;
    } else if (shortBy.value == "expanse") {
      filterTransactionList = await db.filterTransaction(1);
      transactionList.value = filterTransactionList;
    }
  }

  void totalAmount() {
    if (shortBy.value == 'income') {
      for (var x in transactionList) {
        print("===============${x['amount']}");
        amount = x['amount'];
      }

    }
  }
}
