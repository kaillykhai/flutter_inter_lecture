import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/food.dart';
import '../view_models/food_view_model.dart';
import 'food_card_item.dart';

class FoodListView extends StatefulWidget {
  _StateFoodListView createState() => _StateFoodListView();
}

class _StateFoodListView extends State<FoodListView> {
  @override
  Widget build(BuildContext context) {
    FoodViewModel foodViewModel = context.watch<FoodViewModel>();

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          physics: const AlwaysScrollableScrollPhysics(),
          header: const WaterDropHeader(),
          controller: foodViewModel.refreshController,
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body = Container();
              if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.noMore) {
                body = Text("No More Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          onLoading: () {
            foodViewModel.onLoadMoreEvent();
          },
          onRefresh: () {
            foodViewModel.onRefreshEvent(context);
          },
          child: _buildFoodListView(foodViewModel.foodList, foodViewModel)),
    );
  }

  Widget _buildFoodListView(
    List<FoodModel>? foodList,
    FoodViewModel foodViewModel,
  ) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        itemCount: foodList?.length,
        itemBuilder: (_, int index) {
          return FoodCardItem(
            foodList?[index].name,
            foodList?[index].brand,
            foodList?[index].image,
            foodList?[index].price,
          );
        });
  }
}
