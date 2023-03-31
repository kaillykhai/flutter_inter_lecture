import 'package:equatable/equatable.dart';

import '../../food_mvvm_pattern/models/food.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodInitial extends FoodState {}

class FoodEventLoading extends FoodState {}

class FoodEventSuccess extends FoodState {}

class SearchEventSuccess extends FoodState {
  FoodModel searchedFood;
  SearchEventSuccess(this.searchedFood);
}

class NoFoundEvent extends FoodState {}

class FoodEventFailure extends FoodState {
  String errorMsg;
  FoodEventFailure({required this.errorMsg});
}
