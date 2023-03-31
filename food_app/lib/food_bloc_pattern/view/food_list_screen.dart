import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/food_bloc_pattern/bloc/food_bloc.dart';
import 'package:food_app/food_bloc_pattern/bloc/food_event.dart';
import 'package:food_app/food_mvvm_pattern/models/food.dart';
import '../../food_mvvm_pattern/view_models/food_view_model.dart';
import '../bloc/food_state.dart';
import 'food_item_view.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({Key? key}) : super(key: key);

  @override
  _StateFoodListView createState() => _StateFoodListView();
}

class _StateFoodListView extends State<FoodListScreen> {
  int maxCount = 10;
  late FoodModel searchFood;
  bool isShow = false;
  bool isNoData = false;
  FoodBloc foodBloc = FoodBloc();
  TextEditingController foodNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey,
      body: BlocProvider<FoodBloc>(
        create: (BuildContext context) => foodBloc,
        child: BlocListener<FoodBloc, FoodState>(
          listener: (context, state) {
            if (state is SearchEventSuccess) {
              setState(() {
                searchFood = state.searchedFood;
                isShow = true;
                isNoData = false;
              });
            } else if (state is NoFoundEvent || state is FoodEventFailure) {
              FocusScope.of(context).unfocus();
              setState(() {
                isNoData = true;
                isShow = false;
              });
            }
          },
          child: BlocBuilder<FoodBloc, FoodState>(
            builder: (context, state) {
              if (state is FoodEventLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Stack(
                  children: [
                    Column(
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 34, left: 16, right: 16),
                          child: Text(
                            'Enter the food name which you want to search',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 32, right: 32, bottom: 8),
                          child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: foodNameController,
                              keyboardType: TextInputType.text,
                              keyboardAppearance: Brightness.light,
                              enableSuggestions: true,
                              textInputAction: TextInputAction.search,
                              validator: (value) {
                                if (value == null) return 'Enter City Name';
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Enter Food Name',
                                labelStyle: const TextStyle(color: Colors.blue),
                                focusColor: Colors.blueAccent[100],
                                fillColor: Colors.blue,
                                alignLabelWithHint: true,
                                hintText: 'Eg. Pizza',
                                hintStyle:
                                    const TextStyle(color: Colors.white54),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                prefixIcon: const Icon(
                                  Icons.location_on,
                                  color: Colors.blue,
                                ),
                              )),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            foodBloc.add(SearchFoodEvent(
                              foodName: foodNameController.text.toString(),
                            ));
                          },
                          child: const Text("Search"),
                        ),
                        isShow
                            ? Container(
                                width: 100,
                                height: 100,
                                child: Image.asset(
                                  searchFood.image!,
                                ),
                              )
                            : Container(),
                        isShow
                            ? Container(
                                margin: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      child: Text(
                                        '${searchFood.name} ',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      child: Text(
                                        '${searchFood.brand} ',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      child: Text(
                                        '${searchFood.price} ',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        isNoData
                            ? Container(
                                margin: const EdgeInsets.only(top: 50),
                                child: const Text(
                                  'There is no result found',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              )
                            : Container()
                      ],
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
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
