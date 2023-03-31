import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_app/food_bloc_pattern/bloc/food_event.dart';
import 'package:food_app/food_bloc_pattern/bloc/food_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../const/food_const.dart';
import '../../food_mvvm_pattern/models/food.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  FoodBloc() : super(FoodInitial());

  Stream<FoodState> mapEventToState(FoodEvent event) async* {
    if (event is FoodListEvent) {
      yield* _mapGetFoodList(event);
    } else if (event is FoodListLoadMoreEvent) {
      yield* _mapLoadMoreFoodList(event);
    } else if (event is SearchFoodEvent) {
      yield* _mapSearchFoodEvent(event);
    }
  }

  Stream<FoodState> _mapGetFoodList(FoodListEvent event) async* {
    yield FoodEventLoading();
    try {
      List<FoodModel> response = _getFoodData(event.maxCount);
      yield FoodEventSuccess();
    } catch (error) {
      yield FoodEventFailure(errorMsg: error.toString());
    }
  }
}

Stream<FoodState> _mapLoadMoreFoodList(FoodListLoadMoreEvent event) async* {
  yield FoodEventLoading();
  try {
    List<FoodModel> response = _getFoodData(event.maxCount);
    yield FoodEventSuccess();
  } catch (error) {
    yield FoodEventFailure(errorMsg: error.toString());
  }
}

Stream<FoodState> _mapSearchFoodEvent(SearchFoodEvent event) async* {
  late FoodModel searchFood;
  yield FoodEventLoading();
  try {
    for (FoodModel food in FOODLIST) {
      if (food.name?.toLowerCase() == event.foodName.toLowerCase()) {
        searchFood = food;
      }
    }
    if (searchFood.name != null) {
      yield SearchEventSuccess(searchFood);
    } else {
      yield NoFoundEvent();
    }
  } catch (error) {
    yield FoodEventFailure(errorMsg: error.toString());
  }
}

List<FoodModel> _getFoodData(int maxCount) {
  List<FoodModel> foodList = [];
  for (int i = 0; i < maxCount; i++) {
    foodList.add(FOODLIST[i]);
  }
  return foodList;
}
