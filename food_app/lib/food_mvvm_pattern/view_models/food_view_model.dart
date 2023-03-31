import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../const/food_const.dart';
import '../models/food.dart';

class FoodViewModel extends ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List<FoodModel> foodList = [];
  late BuildContext context;
  int MAX_COUNT = 10;

  FoodViewModel() {
    initFoodViewModel();
  }
  void initFoodViewModel() {
    for (int i = 0; i < MAX_COUNT; i++) {
      foodList.add(FOODLIST[i]);
    }
  }

  Future<void> onRefreshEvent(BuildContext context) async {
    onRefreshList();
    refreshController.refreshCompleted();
  }

  Future<void> onLoadMoreEvent() async {
    if (MAX_COUNT == FOODLIST.length) {
      refreshController.loadNoData();
    } else {
      Future.delayed(Duration(milliseconds: 1000), () {
        getMoreList(MAX_COUNT + 10);
        // Do something
      });
      refreshController.loadComplete();
    }
  }

  void onRefreshList() {
    clearFoodList();
    for (int i = 0; i < MAX_COUNT; i++) {
      foodList.add(FOODLIST[i]);
    }
    notifyListeners(); // to notify UI widget
  }

  //to load more food list >> Khaing
  void getMoreList(int nextCount) {
    for (int i = MAX_COUNT; i < nextCount; i++) {
      foodList.add(FOODLIST[i]); // modified ---- by john
    }
    MAX_COUNT = nextCount;
    notifyListeners(); // to notify food list
  }

  void clearFoodList() {
    foodList.clear();
  }
}
