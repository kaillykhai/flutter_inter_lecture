import 'package:equatable/equatable.dart';

class FoodEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FoodListEvent extends FoodEvent {
  int maxCount;
  FoodListEvent({required this.maxCount});
}

class FoodListRefreshEvent extends FoodEvent {}

class FoodListLoadMoreEvent extends FoodEvent {
  int maxCount;
  FoodListLoadMoreEvent({required this.maxCount});
}

class SearchFoodEvent extends FoodEvent {
  String foodName;
  SearchFoodEvent({required this.foodName});
}
